.PHONY: run sim clean

define PARSE_CFG
    $(shell $(AURORA_HOME)/tool/parse_cfg.py $(shell pwd)/cfg/$(TEST).yaml)
endef
$(eval $(PARSE_CFG))

GTKW = wave/$(TOP).gtkw
ifeq ($(shell find ${GTKW} -type f  >/dev/null 2>&1 && echo yes || echo no), no)
    GTKW =
endif

TOOL_EMPTY :=
TOOL_SPACE := $(TOOL_EMPTY) $(TOOL_EMPTY)
TOOL_COMMA := ,$(TOOL_SPACE)

 TOP = $(TEST)_tb
VTOP = V$(TOP)

BUILD_DIR = $(shell pwd)/build
BUILD_MK  = $(VTOP).mk
BUILD_BIN = $(BUILD_DIR)/$(TOP)
BUILD_VCD = $(BUILD_DIR)/$(TOP).vcd
