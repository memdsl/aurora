'''
Author      : myyerrol
Date        : 2024-06-28 22:12:21
LastEditors : myyerrol
LastEditTime: 2024-07-02 16:16:13
path        : /memdsl/aurora/util/gen_io.py
Description : generate io of ip

Copyright (c) 2024 by myyerrol, All Rights Reserved.
'''

#!/usr/bin/python3

import json
import os

class GenIO:
    '''
    description: Initialize directories of project.
    param  {None} self
    return {None}
    '''
    def __init__(self) -> None:
        self.prj_dir = os.path.abspath(
            os.path.dirname(os.path.dirname(__file__)))
        self.prj_dir_sv = os.path.join(self.prj_dir, "src/sv")
        self.prj_dir_io = os.path.join(self.prj_dir, "io")

    '''
    description: Read systemverilog file.
    param  {None}   self
    param  {String} path
    return {None}
    '''
    def __read_sv(self, path) -> None:
        file_arr = os.listdir(path)
        for file in file_arr:
            file = os.path.join(path, file)
            if os.path.isdir(file):
                self.__read_sv(file)
            else:
                if "rtl" in file:
                    self.__pars_sv(open(file, mode="r"))
                    pass
                else:
                    pass

    '''
    description: Parse parameters of module in systemverilog file.
    param  {None}   self
    param  {String} file
    return {None}
    '''
    def __pars_sv(self, file) -> None:
        json_obj = {}
        json_module = ""
        json_params_arr = []
        for line in file:
            line = line.strip()
            if line.startswith("module"):
                json_module = line[len("module") : ].rstrip("#(").strip()
            elif line.startswith("endmodule"):
                if (len(json_params_arr) > 0):
                    json_obj["module"] = json_module
                    json_obj["params"] = json_params_arr
                    self.json_arr.append(json_obj)
                    json_params_arr = []
                    json_obj = {}
                else:
                    pass
            elif line.startswith("parameter"):
                json_params_obj = {}
                param = line[len("parameter") : ].rstrip(",").strip()
                param = param.split(" = ")
                if (len(param) == 2):
                    json_params_obj["name"] = param[0]
                    json_params_obj["type"] = "number"
                    json_params_obj["data"] = int(param[1])
                    json_params_arr.append(json_params_obj)
                else:
                    assert 0, "error: the parameter format is incorrect"
            else:
                pass
        file.close()

    '''
    description: Generate json file.
    param  {None} self
    return {None}
    '''
    def __gen_json(self) -> None:
        self.json_file = open(os.path.join(self.prj_dir_io, "io.json"),
                              mode="w")
        self.json_file.write(json.dumps(self.json_arr, indent=4))

    '''
    description: Run the complete process of generating io.
    param  {None} self
    return {None}
    '''
    def run(self) -> None:
        self.__read_sv(self.prj_dir_sv)
        self.__gen_json()

    prj_dir     = ""
    prj_dir_sv  = ""
    prj_dir_io  = ""
    sv_file_arr = []
    json_arr    = []


if __name__ == "__main__":
    try:
        gen_io_obj = GenIO()
        gen_io_obj.run()
    except IOError:
        print("error: the file is not found or failed to read/write file")
    else:
        print("success")
