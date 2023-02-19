import pathlib
import json
import re
import sys

REPOSITORY_NAME="r/k3s-infra-testing"

with open('./renovate.log', 'r') as fd:
    lines = fd.readlines()

start = 0;
end = 0;
for idx, line in enumerate(lines):
    if f"Extracted dependencies (repository={REPOSITORY_NAME})" in line:
        start = idx
        continue

    if start > 0:
        if any(a in line for a in ["INFO", "WARN",  "ERROR"]):
            end = idx;
            break

print("extract dependencies from log", start, end)
extracted = "{"+''.join(lines[start+1:end])+"}"
renovate = json.loads(extracted)

files = list(set([x for a in ["*.yaml", "*.yml"] for x in pathlib.Path("../kubernetes").rglob(a)]))

versions = {}


print("please wait...")
for f in files:

    with open(f, 'r') as fd:
        lines = fd.readlines()

    p = str(f)[3:]
    versions[p] = []

    for idx, line in enumerate(lines):
        result = re.search(r".*[^\.\dvV]([vV]?\d+\.\d+\.\d+)[^\.]", line)
        if result is None:
            continue

        for x in result.groups():
            versions[p].append((idx, x, line.strip()))

    if len(versions[p]) == 0:
        del versions[p]



def extract(content):
    result = []

    if "packageFile" in content:
        for d in content["deps"]:
            if all(a in d for a in ["currentValue"]):
                result.append((
                    content["packageFile"],
                    d["currentValue"]
                ))
    else:
        if isinstance(content, dict):
            for k in content.keys():
                if isinstance(content[k], list):
                    for item in content[k]:
                        result += extract(item)
                else:
                    result += extract(content[k])


    return result


tracked = {}
for item in extract(renovate):
    if item[0] in tracked:
        tracked[item[0]].append(item[1])
    else:
        tracked[item[0]] = [item[1]]


missing = []

for f in versions:
    if f not in tracked:
        for item in versions[f]:
            if ".sops" not in f:
                missing.append(f"{f}:{item[0]+1} {item[2]}")
    else:
        for item in versions[f]:
            if item[1] not in tracked[f]:
                if ".sops" not in f:
                    missing.append(f"{f}:{item[0]+1} {item[2]}")


for item in missing:
    print(item)

print(" => Found",  len(missing), " untracked dependencies")
