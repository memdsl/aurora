.PHONY: run sim clean

INCS_DIR = $(shell find ${AURORA_HOME}/src/ -type d -name "rtl")
INCS     = $(addprefix -I, $(INCS_DIR))

SRCS = $(addsuffix .sv, $(addprefix rtl/, $(SRC)))

ARGS = -g2005-sv -gno-assertions
GTKW = wave/${TOP}_tb.gtkw

ifeq ($(shell find ${GTKW} -type f  >/dev/null 2>&1 && echo yes || echo no), no)
    GTKW =
endif

# run:
# 	mkdir -p build
# 	iverilog ${ARGS} -o build/${TOP} ${INCS} $(SRCS) tb/${TOP}_tb.sv
# 	vvp -n build/${TOP} -lxt2
# sim: run
# 	gtkwave build/${TOP}.vcd ${GTKW}
# clean:
# 	rm -rf build








SIMULATOR := verilator



# iVerilog


# Verilator
define PARSE_CFG
    $(shell $(AURORA_HOME)/tool/parse_cfg.py $(shell pwd)/cfg/$(TEST).yaml)
endef
$(eval $(PARSE_CFG))

TOOL_EMPTY :=
TOOL_SPACE := $(TOOL_EMPTY) $(TOOL_EMPTY)
TOOL_COMMA := ,$(TOOL_SPACE)

TEST     ?=
TEST_LIST = $(shell find tb -type f | sed "s|.*/||; s|_tb\.sv$$||")
ifeq ($(filter $(TEST_LIST), $(TEST)),)
    ifeq ($(findstring $(MAKECMDGOALS), config|clean),)
        $(error [error]: $$TEST is incorrect, optional values in \
       [$(subst $(TOOL_SPACE),$(TOOL_COMMA),$(TEST_LIST))])
    endif
endif

 TOP = $(TEST)_tb
VTOP = V$(TOP)

BUILD_DIR = $(shell pwd)/build
BUILD_MK  = $(VTOP).mk
BUILD_BIN = $(BUILD_DIR)/$(TOP)
BUILD_VCD = $(BUILD_DIR)/$(TOP).vcd

VERILATOR      = verilator
VERILATOR_ARGS = --cc                \
                 --exe               \
                 --Mdir build        \
                 --MMD               \
                 --o $(BUILD_BIN)    \
                 --timing            \
                 --top-module $(TOP) \
                 --trace             \
                 --main

CXX = g++
CXX_VERSION = $(shell g++ -dumpversion | cut -d. -f1)
ifeq ($(shell [ $(CXX_VERSION) -le 9 ] && echo yes || echo no), yes)
    ifeq ($(shell command -v g++-10 >/dev/null 2>&1 && echo yes || echo no), yes)
        CXX = g++-10
    else
        $(error [error] g++ version must >=10, such as g++-10)
    endif
endif

CXX_CFLAGS  =  -std=c++20   \
               -fcoroutines
CXX_LDFLAGS =

INCS_SV_DIR  = rtl
INCS_SV      = $(addprefix -I, $(INCS_SV_DIR))
INCS_CXX_DIR =
INCS_CXX     = $(addprefix -I, $(shell find $(INCS_CXX_DIR) -name "*.h"))
INCS         = $(INCS_SV)

SRCS_SV_DIR           =
SRCS_SV_SRC_BLACKLIST =
SRCS_SV_DIR_BLACKLIST =
SRCS_SV_BLACKLIST     = $(SRCS_SV_SRC_BLACKLIST)                            \
                        $(shell find $(SRCS_SV_DIR_BLACKLIST) -name "*.sv")
SRCS_SV_WHITELIST    =  $(addprefix rtl/, $(subst ],,$(subst [,,$(FILE))))  \
                        $(addprefix tb/,  $(TOP).sv)
SRCS_SV               = $(filter-out $(SRCS_SV_BLACKLIST), $(SRCS_SV_WHITELIST))

SRCS_CXX =
SRCS     = $(SRCS_SV) $(SRCS_CXX)

GTKW = wave/$(TOP).gtkw

ifeq ($(shell find ${GTKW} -type f  >/dev/null 2>&1 && echo yes || echo no), no)
    GTKW =
endif

$(BUILD_MK):
	$(VERILATOR) $(VERILATOR_ARGS)         \
	$(INCS) $(SRCS)                        \
	$(addprefix -CFLAGS ,  $(CXX_CFLAGS))  \
	$(addprefix -LDFLAGS , $(CXX_LDFLAGS))
$(BUILD_BIN): $(BUILD_MK)
	make -C build -f $(BUILD_MK) CXX=$(CXX)

.PHONY: clean run sim

all:
	@echo $(SRCS)
run: $(BUILD_BIN)
	$(BUILD_BIN)
sim: run
	gtkwave $(BUILD_VCD) $(GTKW)
clean:
	rm -rf build
