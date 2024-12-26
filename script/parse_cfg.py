#!/usr/bin/env python3

import yaml
import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: parse_cfg.py <yaml_file>")
        sys.exit(1)

    yaml_file = sys.argv[1]

    with open(yaml_file, "r") as file:
        cfgs = yaml.safe_load(file)

    for key, value in cfgs.items():
        if isinstance(value, dict):
            for subkey, subvalue in value.items():
                print(f"{key}_{subkey}={subvalue}")
        else:
            print(f"{key}={value}")

if __name__ == "__main__":
    main()
