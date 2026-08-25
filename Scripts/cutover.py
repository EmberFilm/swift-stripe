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

hand, struct_name, namespace, generated = sys.argv[1:5]
hand_p, gen_p = pathlib.Path(hand), pathlib.Path(generated)
s = hand_p.read_text()

# names the generated struct declares directly inside itself (8-space indent)
gen_names = set(re.findall(r"^        public (?:struct|enum|typealias) `?(\w+)`?", gen_p.read_text(), re.M))

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
blocks = re.split(r"(?m)^(?=extension |// MARK|// extension|//extension)", s)
head, body = blocks[0], blocks[1:]
kept, dropped = [], []
for b in body:
    m = re.match(r"^(extension ([\w.]+) \{\n)(.*)(\n\}\n*)$", b, re.S)
    if not m:
        if b.startswith("extension "):
            raise SystemExit(f"could not parse block: {b.splitlines()[0]}")
        kept.append(b); continue
    header, ext_ns, inner, tail = m.groups()
    if ext_ns != namespace and not ext_ns.startswith(namespace + "."):
        # e.g. `extension Stripe.Billing { public struct Subscription ... }` — the struct's own home
        if re.search(rf"^    public struct {struct_name}\b", inner, re.M) and ext_ns == namespace.rsplit(".", 1)[0]:
            dropped.append(f"{ext_ns}: struct {struct_name}"); continue
        kept.append(b); continue
    if ext_ns != namespace:
        # extension of a nested type: drop if that nested type is generated (stale sibling)
        nested = ext_ns[len(namespace) + 1:].split(".")[0]
        if nested in gen_names:
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
new_p = hand_p.with_name(hand_p.name.replace(".swift", ".Retained.swift"))
out = head.replace(hand_p.name, new_p.name).rstrip("\n") + \
      f"\n\n// The {struct_name} struct is generated (Models/Generated). These are the nested types the\n" \
      f"// request layer still names under `{namespace}` that the generator spells differently.\n\n" + "".join(kept)
new_p.write_text(out); hand_p.unlink()
print(f"{struct_name}: dropped {len(dropped)}, kept {len(kept)} block(s)")
for d in dropped: print("   -", d)
