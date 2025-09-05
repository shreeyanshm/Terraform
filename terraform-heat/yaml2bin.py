#!/usr/bin/env python3
import sys
from pathlib import Path

def main():
    if len(sys.argv) != 2:
        print("Usage: python yaml2bin.py <heat-template.yaml>")
        sys.exit(1)

    file_path = Path(sys.argv[1])
    if not file_path.exists():
        print(f"Error: File {file_path} not found.")
        sys.exit(1)

    content = file_path.read_text()

    escaped = content.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")

    print('Copy-paste this into Terraform:')
    print()
    print('template_opts = {')
    print(f'  Bin = "{escaped}"')
    print('}')

if __name__ == "__main__":
    main()
