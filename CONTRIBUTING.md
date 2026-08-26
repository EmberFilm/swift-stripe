## Legal

By submitting a pull request, you represent that you have the right to license
your contribution to the swift-stripe project and the community, and agree by
submitting the patch that your contributions are licensed under the Apache
License, Version 2.0 (see `LICENSE`).

## How to submit a bug report

Please report any issues related to this library in the
[swift-stripe](https://github.com/EmberFilm/swift-stripe/issues) repository.

Specify the following:

* swift-stripe version
* Stripe API version in use, if it differs from `Stripe.generatedAPIVersion`
* Contextual information (e.g. what you were trying to achieve with swift-stripe)
* Simplest possible steps to reproduce
  * More complex the steps are, lower the priority will be.
  * A pull request with failing test case is preferred, but it's just fine to paste the test
    case into the issue description. A decoding failure is best reported with the response
    or webhook payload that triggered it, secrets and identifiers redacted.
* Anything that might be relevant in your opinion, such as:
  * Swift version or the output of `swift --version`
  * OS version and the output of `uname -a`
  * Whether the build is static Linux (musl) or glibc

### Example

```
swift-stripe version: 0.14.0

Context:
While handling a `customer.subscription.updated` webhook, I noticed that ...

Steps to reproduce:
1. ...
2. ...
3. ...

$ swift --version
Swift version 6.3.3 (swift-6.3.3-RELEASE)
Target: aarch64-unknown-linux-gnu

Operating system: Ubuntu Linux 24.04 64-bit

$ uname -a
Linux stripe-host 6.8.0-45-generic #45-Ubuntu SMP x86_64 GNU/Linux
```

## Contributing a pull request

1. Prepare your change, keeping in mind that a good patch is:
   - Concise, and contains as few changes as needed to achieve the end result.
   - Tested, ensuring that any tests provided failed before the patch and pass after it.
   - Documented, adding API documentation as needed to cover new functions and properties.
   - Accompanied by a great commit message.
2. Run the checks that continuous integration runs, before opening the pull request:

   ```bash
   swift build --build-tests
   swift test
   swift format lint --strict --recursive Sources Tests
   ```

   Every Swift file starts with the license header in `.license_header_template`.
3. Open a pull request at https://github.com/EmberFilm/swift-stripe and wait for code review
   by the maintainers.

### Generated sources

The models under `Sources/Stripe/Models`, the request types under `Sources/Stripe/Requests`
and the clients under `Sources/Stripe/Clients` are generated from Stripe's OpenAPI
specification; `Scripts/generated-files.txt` lists every generated file. Do not edit those
files by hand — change the generator and regenerate, then run the gates that keep the tree
in step with the specification:

```bash
Scripts/generate-models.py spec3.sdk.json
Scripts/generate-requests.py spec3.sdk.json
Scripts/spec-fixture.py spec3.sdk.json
Scripts/model-drift.py spec3.sdk.json
Scripts/generate-models.py spec3.sdk.json --check
Scripts/generate-requests.py spec3.sdk.json --check
```

`CLAUDE.md` describes the generator's rules and the architecture in detail.

## Automated release process

This repository uses automated releases based on semantic versioning labels. Each pull request
carries one of `semver/none`, `🔨 semver/patch`, `🆕 semver/minor` or `⚠️ semver/major`; the
weekly release workflow computes the next version from the labels of pull requests merged since
the last release. First and major releases are created manually.
