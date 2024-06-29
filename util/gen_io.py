#!/usr/bin/python3

class gen_io:
    def __init__(self):
        pass

    def __read_sv(self):
        self.__sv = open("../sv/common/adder/rtl/adder_xbit_serial.sv", "r")

    def __pars_sv(self):
        for line in self.__sv:
            line = line.strip()
            print(line)
            if line.startswith("module"):
                self.__yaml_module = line[len("module") : ].rstrip("#(").strip()
            if line.startswith("parameter"):
                param = line[len("parameter") : ].rstrip(",").strip()
                print(param)
                param = param.split(" = ")
                print(param)
                if (len(param) == 2):
                    self.__yaml_param["name"] = param[0]
                    self.__yaml_param["type"] = param[1]

        self.__sv.close()

    def __gen_yaml(self):
        print(self.__yaml_module)
        print(self.__yaml_param)
        pass

    def run(self):
        self.__read_sv()
        self.__pars_sv()
        self.__gen_yaml()
        pass

    __sv = None
    __yaml_module = ""
    __yaml_params = []
    __yaml_param  = { "name": "", "type": "number" }

# if __name__ == "main":
gen_io_obj = gen_io()
gen_io_obj.run()
