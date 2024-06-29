export PATH := $(PATH):$(abspath ./util)

CFG_CFLAGS_TOP_NAME = UART GPIO HDMI

BUILD_DIR = $(METEOR_IP_HOME)/chisel/rtl/build

SRCSS_DIR           = $(abspath $(METEOR_IP_HOME)/chisel/rtl/src)
SRCSS_SRC_BLACKLIST =
SRCSS_DIR_BLACKLIST =
SRCSS_BLACKLIST     = $(SRCSS_SRC_BLACKLIST)                                  \
                      $(shell find $(SRCSS_DIR_BLACKLIST) -name "*.scala")
SRCSS_WHITELIST     = $(shell find $(SRCSS_DIR) -name "*.scala")
SRCSS               = $(filter-out $(SRCSS_BLACKLIST), $(SRCSS_WHITELIST))

SRCVS_DIR = $(METEOR_IP_HOME)/chisel/rtl/srcv
SRCVS_GEN = $(addsuffix .v, $(addprefix $(BUILD_DIR)/, $(CFG_CFLAGS_TOP_NAME)))
SRCVS     = $(shell find $(SRCVS_DIR) -name "*.v")

$(SRCVS_GEN): $(SRCSS)
	mkdir -p $(BUILD_DIR) && \
	mill -i rtl.runMain TopMain -td $(BUILD_DIR)

.PHONY: test gen fmt cfmt clean bsp

test:
	mill -i rtl.test

gen: $(SRCVS_GEN)

fmt:
	mill -i rtl.reformat

cfmt:
	mill -i rtl.checkFormat

clean:
	rm -rf out
	rm -rf test_run_dir
	rm -rf rtl/build

bsp:
	mill -i mill.bsp.BSP/install
