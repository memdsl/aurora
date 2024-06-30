'''
Author      : myyerrol
Date        : 2024-06-28 22:12:21
LastEditors : myyerrol
LastEditTime: 2024-06-30 18:05:42
FilePath    : /memdsl-cpu/meteor/ip/util/gen_io.py
Description : generate io of ip

Copyright (c) 2024 by myyerrol, All Rights Reserved.
'''

#!/usr/bin/python3

class gen_io:
    def __init__(self):
        pass

    def __read_sv(self):
        self.sv = open("/home/myyerrol/Workspaces/memdsl-cpu/meteor/ip/src/sv/common/adder/rtl/adder_xbit_serial.sv", "r")

    def __pars_sv(self):
        json_obj = {}
        json_module = ""
        json_params_arr = []
        for line in self.sv:
            line = line.strip()
            if line.startswith("module"):
                json_module = line[len("module") : ].rstrip("#(").strip()
            if line.startswith("endmodule"):
                if (len(json_params_arr) > 0):
                    json_obj["module"] = json_module
                    json_obj["params"] = json_params_arr
                    self.json_arr.append(json_obj)
                    json_params_arr = []
                    json_obj = {}
                else:
                    pass
            if line.startswith("parameter"):
                json_params_obj = {}
                param = line[len("parameter") : ].rstrip(",").strip()
                param = param.split(" = ")
                if (len(param) == 2):
                    json_params_obj["name"] = param[0]
                    json_params_obj["type"] = "number"
                    json_params_obj["data"] = int(param[1])
                    json_params_arr.append(json_params_obj)
                else:
                    assert 0, "Error: parameter format is incorrect"
            else:
                pass
        self.sv.close()

    def __gen_json(self):
        print(self.json_arr)

    def run(self):
        self.__read_sv()
        self.__pars_sv()
        self.__gen_json()

    sv = None
    json_arr = []

# if __name__ == "main":
gen_io_obj = gen_io()
gen_io_obj.run()
