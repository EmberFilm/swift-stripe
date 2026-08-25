#!/usr/bin/env python3
"""Replaces one hand-written resource with its generated model, keeping what the request layer needs.

    Scripts/cutover.py <hand file> <struct name> <namespace> <generated file>

Removes the resource struct from the hand file, then removes every hand declaration directly
under <namespace> whose name the generated struct also declares as a nested type — the generated
one is the spec's, the hand one is stale. Everything else in the hand file is kept, renamed
*.Retained.swift, since request types name those nested enums and the generator spells them
differently. Works at declaration level, so a block that groups a stale enum with a live one
loses only the stale one.
"""
import pathlib, re, sys

if sys.argv[1] == "--sweep":
    # Sibling sweep: other hand files that extend the resource, or one of its generated nested
    # types, with declarations the generated struct now provides. Those blocks are stale.
    namespace, generated = sys.argv[2:4]
    gen_names = set(re.findall(r"^        public (?:struct|enum|typealias) `?(\w+)`?", pathlib.Path(generated).read_text(), re.M))
    swept = []
    for f in pathlib.Path("Sources/Stripe/Models").rglob("*.swift"):
        if "Generated" in f.parts: continue
        s = f.read_text()
        if f"extension {namespace}" not in s: continue
        blocks = re.split(r"(?m)^(?=(?://[^\n]*\n|\n)*(?:extension |// MARK|// extension|//extension))", s)
        head, body = blocks[0], blocks[1:]
        kept = []
        for b in body:
            m = re.match(r"^(extension ([\w.]+) \{\n)(.*)(\n\}\n*)$", b, re.S)
            if not m: kept.append(b); continue
            header, ext_ns, inner, tail = m.groups()
            if ext_ns != namespace and ext_ns.startswith(namespace + ".") and ext_ns[len(namespace) + 1:].split(".")[0] in gen_names:
                swept.append(f"{f.name}: extension {ext_ns}"); continue
            if ext_ns == namespace:
                members, buf, depth = [], [], 0
                for line in inner.split("\n"):
                    buf.append(line); depth += line.count("{") - line.count("}")
                    if depth == 0 and re.match(r"^    \}$", line): members.append("\n".join(buf)); buf = []
                if buf: members.append("\n".join(buf))
                surv = []
                for mem in members:
                    d = re.search(r"^    public (?:struct|enum|typealias) `?(\w+)`?", mem, re.M)
                    if d and d.group(1) in gen_names: swept.append(f"{f.name}: {ext_ns}.{d.group(1)}")
                    else: surv.append(mem)
                if any(re.search(r"^    public ", x, re.M) for x in surv): kept.append(header + "\n".join(surv) + tail)
                continue
            kept.append(b)
        new = head + "".join(kept)
        if new != s:
            if not re.search(r"^\s*public ", new, re.M): f.unlink(); swept.append(f"{f.name}: removed (nothing left)")
            else: f.write_text(new)
    print(f"sweep {namespace}: {len(swept)} stale declaration(s)" + ("".join("\n   - " + x for x in swept) if swept else ""))
    sys.exit(0)

hand, struct_name, namespace, generated = sys.argv[1:5]
hand_p, gen_p = pathlib.Path(hand), pathlib.Path(generated)
s = hand_p.read_text()

# names the generated struct declares directly inside itself: 8-space indent under an
# extension, 4-space for a module-level struct
gen_src = gen_p.read_text()
top_level = "." not in namespace
gen_names = set(re.findall(r"^    public (?:struct|enum|typealias) `?(\w+)`?" if top_level
                           else r"^        public (?:struct|enum|typealias) `?(\w+)`?", gen_src, re.M))

def split_members(body: str):
    """Top-level members of an extension body, each with leading comments/attributes attached."""
    members, i, lines = [], 0, body.split("\n")
    buf, depth = [], 0
    for line in lines:
        buf.append(line)
        depth += line.count("{") - line.count("}")
        if depth == 0 and re.match(r"^    (public|private|internal|@)", line) or (depth == 0 and buf and re.search(r"^    \}$", line)):
            members.append("\n".join(buf)); buf = []
    if buf: members.append("\n".join(buf))
    return members

# `// MARK:` lines and commented-out `// extension` blocks sit between blocks; splitting on them
# too keeps each real block's tail clean. Chunks that are not a live extension pass through.
blocks = re.split(r"(?m)^(?=(?://[^\n]*\n|\n)*(?:extension |// MARK|// extension|//extension))", s)
head, body = blocks[0], blocks[1:]
kept, dropped = [], []
if top_level:
    # the struct itself sits at file scope: cut its brace-matched block out of the head
    m = re.search(rf"^(?:///[^\n]*\n)*public struct {struct_name}\b[^{{]*\{{", head, re.M)
    assert m, f"top-level struct {struct_name} not found"
    i, depth = head.index("{", m.start()), 0
    while True:
        if head[i] == "{": depth += 1
        elif head[i] == "}":
            depth -= 1
            if depth == 0: break
        i += 1
    head = head[:m.start()] + head[i + 1:].lstrip("\n")
    dropped.append(f"(file scope): struct {struct_name}")
for b in body:
    m = re.match(r"^(extension ([\w.]+) \{\n)(.*)(\n\}\n*)$", b, re.S)
    if not m:
        if b.startswith("extension ") and not re.match(r"^extension [\w.]+ \{[^\n]*\}\n*$", b):
            raise SystemExit(f"could not parse block: {b.splitlines()[0]}")
        kept.append(b); continue     # a one-line namespace declaration, or prose
    header, ext_ns, inner, tail = m.groups()
    if ext_ns != namespace and not ext_ns.startswith(namespace + "."):
        # e.g. `extension Stripe.Billing { public struct Subscription ... }` — the struct's own home
        if not top_level and re.search(rf"^    public struct {struct_name}\b", inner, re.M) and ext_ns == namespace.rsplit(".", 1)[0]:
            if kept and re.fullmatch(r"(?://[^\n]*\n|\n)*", kept[-1]): kept.pop()
            dropped.append(f"{ext_ns}: struct {struct_name}"); continue
        kept.append(b); continue
    if ext_ns != namespace:
        # extension of a nested type: drop if that nested type is generated (stale sibling)
        nested = ext_ns[len(namespace) + 1:].split(".")[0]
        if nested in gen_names:
            if kept and re.fullmatch(r"(?://[^\n]*\n|\n)*", kept[-1]): kept.pop()
            dropped.append(f"{ext_ns}: extension of generated {nested}"); continue
        kept.append(b); continue
    survivors = []
    for member in split_members(inner):
        decl = re.search(r"^    public (?:struct|enum|typealias) `?(\w+)`?", member, re.M)
        name = decl.group(1) if decl else None
        if name in gen_names:
            dropped.append(f"{ext_ns}: {name}")
        else:
            survivors.append(member)
    if any(re.search(r"^    public ", x, re.M) for x in survivors):
        kept.append(header + "\n".join(survivors) + tail)

assert any(f"struct {struct_name}" in d for d in dropped), "struct not found"
if not re.search(r"^\s*(public|extension)\s", head + "".join(kept), re.M):
    hand_p.unlink(); print(f"{struct_name}: nothing to retain; hand file removed"); sys.exit(0)
new_p = hand_p if hand_p.name.endswith(".Retained.swift") else hand_p.with_name(hand_p.name.replace(".swift", ".Retained.swift"))
out = head.replace(hand_p.name, new_p.name).rstrip("\n") + \
      f"\n\n// The {struct_name} struct is generated (Models/Generated). These are the nested types the\n" \
      f"// request layer still names under `{namespace}` that the generator spells differently.\n\n" + "".join(kept)
new_p.write_text(out); hand_p.unlink()
print(f"{struct_name}: dropped {len(dropped)}, kept {len(kept)} block(s)")
for d in dropped: print("   -", d)
