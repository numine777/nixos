#!/usr/bin/env python3
import datetime
import json
import os
from typing import *
import subprocess
import itertools

TIME_FORMAT = "%d/%b/%Y"
ISO_FORMAT = "%Y-%m-%dT%H:%M:%SZ"
NIX_LOCKFILE = f"{os.getenv('HOME')}/nixos/flake.lock"
LockFile = Dict[str, Dict[str, Any]]


class RootNode(TypedDict):
    inputs: Dict[str, str]


class Original(TypedDict):
    owner: str
    repo: str
    type: str
    ref: Optional[str]
    dir: Optional[str]


class Locked(TypedDict):
    dir: Optional[str]
    lastModified: int
    narHash: str
    owner: str
    repo: str
    rev: str
    type: str


class Node(TypedDict):
    original: Original
    locked: Locked


class LockFile(TypedDict):
    nodes: Dict[str, Union[RootNode, Node]]
    root: str
    version: int


def batched(iterable: Iterable[str], n: int):
    # batched('ABCDEFG', 3) --> ABC DEF G
    if n < 1:
        raise ValueError("n must be at least one")
    it = iter(iterable)
    while batch := tuple(itertools.islice(it, n)):
        yield batch


def pretty_date(time: datetime.datetime):
    """
    Get a datetime object or a int() Epoch timestamp and return a
    pretty string like 'an hour ago', 'Yesterday', '3 months ago',
    'just now', etc
    """
    now = datetime.datetime.now()
    diff = now - time
    second_diff = diff.seconds
    day_diff = diff.days

    if day_diff < 0:
        return ""

    if day_diff == 0:
        if second_diff < 10:
            return "just now"
        if second_diff < 60:
            return str(second_diff) + " seconds ago"
        if second_diff < 120:
            return "a minute ago"
        if second_diff < 3600:
            return str(second_diff // 60) + " minutes ago"
        if second_diff < 7200:
            return "an hour ago"
        if second_diff < 86400:
            return str(second_diff // 3600) + " hours ago"
    if day_diff == 1:
        return "Yesterday"
    if day_diff < 7:
        return str(day_diff) + " days ago"
    if day_diff < 31:
        return str(day_diff // 7) + " weeks ago"
    if day_diff < 365:
        return str(day_diff // 30) + " months ago"
    return str(day_diff // 365) + " years ago"


def load_flake_lockfile() -> LockFile:
    with open(NIX_LOCKFILE) as f:
        return json.load(f)


def flake_inputs(lock: LockFile) -> Dict[str, str]:
    nodes = lock.get("nodes", {})
    root = nodes.get("root")
    if root:
        root_node = cast(RootNode, root)
        return root_node.get("inputs")
    return {}


def latest_commit(owner: str, repo: str) -> Tuple[str, datetime.datetime]:
    args = [
        "gh", "api", f"/repos/{owner}/{repo}/commits", "--jq",
        ".[0]|.sha,.commit.author.date"
    ]
    output = subprocess.check_output(args).decode()
    commit, commit_date = output.splitlines()
    commit_date = datetime.datetime.strptime(commit_date, ISO_FORMAT)
    return (commit, commit_date)


def get_releases(
        owner: str, repo: str,
        since: datetime.datetime) -> List[Tuple[str, str, datetime.datetime]]:
    args = [
        "gh",
        "api",
        f"/repos/{owner}/{repo}/releases",
        "--jq",
        ".[]|.tag_name,.name,.published_at",
    ]
    output = subprocess.check_output(args).decode()
    results: List[Tuple[str, str, datetime.datetime]] = []
    for tag, name, published in batched(output.splitlines(), 3):
        published = datetime.datetime.strptime(published, ISO_FORMAT)
        if published > since:
            results.append((tag, name, published))
    return results


def show_inputs(lock: LockFile):
    inputs = flake_inputs(lock)
    for input, nodename in inputs.items():
        if nodename not in lock["nodes"]:
            continue
        node = cast(Node, lock["nodes"][nodename])
        original = node["original"]
        locked = node["locked"]
        print(input.title())
        print(
            f"  Repo:    {original['type']}.com/{original['owner']}/{original['repo']}"
        )
        updated = datetime.datetime.fromtimestamp(locked["lastModified"])

        commit, commit_date = latest_commit(original["owner"],
                                            original["repo"])
        releases = get_releases(original["owner"], original["repo"], updated)

        print(
            f"  Updated: {updated.strftime(TIME_FORMAT)} ({pretty_date(updated)})"
        )
        print(
            f"  Latest:  {commit_date.strftime(TIME_FORMAT)} ({pretty_date(commit_date)}) [{commit}]"
        )

        if releases:
            print("  Releases:")
        for rel_tag, rel_name, rel_date in releases:
            print(
                f"    {rel_name} {rel_date.strftime(TIME_FORMAT)} ({pretty_date(rel_date)}) [{rel_tag}]"
            )


if __name__ == "__main__":
    lockfile = load_flake_lockfile()
    show_inputs(lockfile)
