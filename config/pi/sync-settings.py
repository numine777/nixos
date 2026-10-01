"""Merge shared settings into Pi's writable state during Home Manager activation."""

import json
import os
from pathlib import Path
import sys
import tempfile


def sync_settings(target, source):
    shared = json.loads(source.read_text())
    current = json.loads(target.read_text()) if target.exists() else {}
    if not isinstance(current, dict) or not isinstance(shared, dict):
        raise ValueError("Pi settings must be JSON objects")

    # Preserve local package filters and additional packages. Match the object
    # form by source so a filtered package is not loaded a second time.
    packages = current.get("packages", [])
    if not isinstance(packages, list):
        raise ValueError("Pi settings packages must be an array")
    packages = list(packages)
    sources = [p.get("source") if isinstance(p, dict) else p for p in packages]
    for package in shared.get("packages", []):
        source_name = package.get("source") if isinstance(package, dict) else package
        if source_name not in sources:
            packages.append(package)
            sources.append(source_name)
    merged = {**current, **shared, "packages": packages}
    if target.exists() and current == merged:
        return

    target.parent.mkdir(parents=True, exist_ok=True)
    # Write beside the destination for an atomic replacement; mkstemp uses 0600.
    fd, temporary = tempfile.mkstemp(prefix=".settings-", dir=target.parent)
    try:
        with os.fdopen(fd, "w") as output:
            json.dump(merged, output, indent=2)
            output.write("\n")
        os.replace(temporary, target)
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)


if __name__ == "__main__":
    sync_settings(Path(sys.argv[1]), Path(sys.argv[2]))
