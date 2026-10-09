import json
import subprocess
import sys
from os import makedirs, remove
from os.path import dirname
from pathlib import Path

NEW_SYMLINK_JSON_FILE_PATH: str = "@new_symlink_file@"
SYMLINK_JSON_SAVE_LOCATION: str = "@old_symlink_file@"


def _error_out(msg: str):
    print(msg, file=sys.stderr)
    sys.exit(1)


def get_links(fname: str) -> list[tuple[str, str]]:
    symlink_list: list[tuple[str, str]] = []
    with open(fname, "r") as f:
        parsed_json: list[list[str]] = json.load(f)
        if not isinstance(parsed_json, list):
            _error_out("symlink file isn't a list")
        for tup in parsed_json:
            if not isinstance(tup, list):
                _error_out("symlinks must be a list of lists")
            if len(tup) == 0:
              continue
            if len(tup) != 2:
                _error_out("symlink must be a src -> dst tuple")
            symlink_list.append((tup[0], tup[1]))
    return symlink_list


def validate_new_list(symlinks: list[tuple[str, str]]):
    for fpath, _ in symlinks:
        file = Path(fpath)
        if not file.exists():
            _error_out(f"source {fpath} doesn't exist")


def init_destinations(symlinks: list[tuple[str, str]]):
    for _, dest in symlinks:
        parent = Path(dirname(dest))
        makedirs(parent, exist_ok=True)


def build_symlink(source, dest):
    subprocess.run(
        [
            "ln",
            "-sfn",
            source,
            dest,
        ],
        check=True,
    )
    print(f"Linked {source} -> {dest}")


def build_symlinks(symlinks: list[tuple[str, str]]):
    for src, dst in symlinks:
        build_symlink(src, dst)


def write_symlinks(symlinks: list[tuple[str, str]], dest: str):
    with open(dest, "w") as f:
        json.dump(symlinks, f)


def filter_link_destinations(symlinks: list[tuple[str, str]]) -> set[str]:
    links: set[str] = set()
    for _, dst in symlinks:
        links.add(dst)
    return links


def get_oldsymlinks() -> set[str]:
    if not Path(SYMLINK_JSON_SAVE_LOCATION).exists():
      return set()
    old_symlinks: list[tuple[str, str]] = get_links(SYMLINK_JSON_SAVE_LOCATION)
    return filter_link_destinations(old_symlinks)


def get_links_to_remove(new_links: set[str], old_links: set[str]) -> list[str]:
    return list(old_links - new_links)


def remove_old_links(links: list[str]):
    if len(links) == 0:
        print("No Links to remove")
    for link in links:
        print(f"Removing old link {link}")
        remove(link)


new_symlinks: list[tuple[str, str]] = get_links(NEW_SYMLINK_JSON_FILE_PATH)
new_links: set[str] = filter_link_destinations(new_symlinks)
validate_new_list(new_symlinks)
init_destinations(new_symlinks)
build_symlinks(new_symlinks)
old_links: set[str] = get_oldsymlinks()
links_to_remove: list[str] = get_links_to_remove(new_links, old_links)
remove_old_links(links_to_remove)

write_symlinks(new_symlinks, SYMLINK_JSON_SAVE_LOCATION)
