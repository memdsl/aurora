#!/usr/bin/env python3

import os
import yaml
import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: parse_cfg.py <yaml_file>")
        sys.exit(1)

    yaml_file = sys.argv[1]
    yaml_dirs = os.path.dirname(yaml_file)
    test_name = os.path.splitext(os.path.basename(yaml_file))[0]

    if (yaml_file.find("cvrt") != -1):
        yaml_file = yaml_dirs + "/cvrt.yaml"
    elif (yaml_file.find("reg") != -1):
        yaml_file = yaml_dirs + "/reg.yaml"
    elif (yaml_file.find("mux") != -1):
        yaml_file = yaml_dirs + "/mux.yaml"

    with open(yaml_file, "r") as file:
        cfgs = yaml.safe_load(file)

    for key, val in cfgs.items():
        if isinstance(val, dict):
            for sub_key, sub_val in val.items():
                print(f"{key}_{sub_key}={sub_val}")
        else:
            if (key == "FILE"):
                val = [file.replace("$this", test_name) for file in val]
            print(f"{key}={val}")

if __name__ == "__main__":
    main()
