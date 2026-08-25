//
//  TestHTTPServer.swift
//  swift-stripe
//
//  A local HTTP/1.1 server so the client can be tested over a real
//  `AsyncHTTPClient` connection: the request bytes asserted here are the bytes
//  that actually went over the socket.
//

import NIOConcurrencyHelpers
import NIOCore
import NIOHTTP1
import NIOPosix

/// One request as the server received it.
struct RecordedRequest: Sendable {
    var method: HTTPMethod
    var uri: String
    var headers: HTTPHeaders
    var body: String
}

/// Scripted reply.
struct ScriptedResponse: Sendable {
    var status: Int
    var body: String
    var headers: [(String, String)]

    init(status: Int = 200, body: String, headers: [(String, String)] = []) {
        self.status = status
        self.body = body
        self.headers = headers
    }
}

final class TestHTTPServer: Sendable {
    private let channel: any Channel
    private let group: MultiThreadedEventLoopGroup
    private let state: NIOLockedValueBox<State>

    struct State: Sendable {
        var received: [RecordedRequest] = []
        var responses: [ScriptedResponse] = []
    }

    /// The port the server bound to.
    var port: Int { channel.localAddress?.port ?? 0 }

    /// Every request received so far, in order.
    var received: [RecordedRequest] { state.withLockedValue { $0.received } }

    private init(
        channel: any Channel,
        group: MultiThreadedEventLoopGroup,
        state: NIOLockedValueBox<State>
    ) {
        self.channel = channel
        self.group = group
        self.state = state
    }

    /// Starts a server that replies with `responses` in order, repeating the
    /// last entry once exhausted.
    static func start(responses: [ScriptedResponse]) async throws -> TestHTTPServer {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let state = NIOLockedValueBox(State(responses: responses))

        let bootstrap = ServerBootstrap(group: group)
            .serverChannelOption(.backlog, value: 16)
            .serverChannelOption(.socketOption(.so_reuseaddr), value: 1)
            .childChannelInitializer { channel in
                channel.pipeline.configureHTTPServerPipeline().flatMap {
                    channel.pipeline.addHandler(Handler(state: state))
                }
            }

        let channel = try await bootstrap.bind(host: "127.0.0.1", port: 0).get()
        return TestHTTPServer(channel: channel, group: group, state: state)
    }

    func stop() async throws {
        try? await channel.close().get()
        try await group.shutdownGracefully()
    }

    /// Accumulates one request, then writes the next scripted response.
    private final class Handler: ChannelInboundHandler {
        typealias InboundIn = HTTPServerRequestPart
        typealias OutboundOut = HTTPServerResponsePart

        private let state: NIOLockedValueBox<State>
        private var head: HTTPRequestHead?
        private var body = ""

        init(state: NIOLockedValueBox<State>) { self.state = state }

        func channelRead(context: ChannelHandlerContext, data: NIOAny) {
            switch unwrapInboundIn(data) {
            case .head(let head):
                self.head = head
                self.body = ""

            case .body(var buffer):
                body += buffer.readString(length: buffer.readableBytes) ?? ""

            case .end:
                guard let head else { return }
                let request = RecordedRequest(
                    method: head.method,
                    uri: head.uri,
                    headers: head.headers,
                    body: body
                )

                let response: ScriptedResponse = state.withLockedValue {
                    $0.received.append(request)
                    // Repeat the final entry rather than running dry, so a test
                    // that retries more than expected still terminates.
                    return $0.responses.count > 1 ? $0.responses.removeFirst() : ($0.responses.first ?? ScriptedResponse(body: "{}"))
                }

                var headers = HTTPHeaders([
                    ("Content-Type", "application/json"),
                    ("Content-Length", String(response.body.utf8.count)),
                ])
                for (name, value) in response.headers {
                    headers.add(name: name, value: value)
                }

                let responseHead = HTTPResponseHead(
                    version: .http1_1,
                    status: .init(statusCode: response.status),
                    headers: headers
                )
                context.write(wrapOutboundOut(.head(responseHead)), promise: nil)
                var buffer = context.channel.allocator.buffer(capacity: response.body.utf8.count)
                buffer.writeString(response.body)
                context.write(wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)
                context.writeAndFlush(wrapOutboundOut(.end(nil)), promise: nil)
            }
        }
    }
}
