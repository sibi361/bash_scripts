#!/bin/python3

"""
This script recursively finds and deletes all binary files present in CWD.
"""

import glob
import os

BINARY_EXTENSIONS = [".exe", ".o", ".class"]

cwd = os.path.abspath(os.getcwd())
paths_all = glob.glob(cwd + "/**", recursive=True)

paths_to_remove = [
    path
    for path in paths_all
    if (
        (
            "." not in path
            or any(path.endswith(extension) for extension in BINARY_EXTENSIONS)
        )
        and not os.path.isdir(path)
    )
]

count = len(paths_to_remove)
if not count:
    print("No binary files found in CWD\n\nExiting")
    exit(0)

for filePath in paths_to_remove:
    print(filePath)

print("\nThe above listed {} files will be permanently deleted.".format(count))
try:
    input("Are you sure? Ctrl+C to stop and exit ")
    input("Are you ABSOLUTELY sure? Ctrl+C to stop and exit ")
except KeyboardInterrupt:
    print("\n\nExiting")
    exit(0)

for filePath in paths_to_remove:
    os.remove(filePath)

print("\nAll binaries present in CWD have been deleted")
