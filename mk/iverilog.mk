include $(AURORA_HOME)/mk/base.mk

ifeq ($(shell find $(GTKW) -type f > /dev/null 2>&1 && echo yes || echo no), no)
    GTKW =
endif

IVERILOG      = iverilog
IVERILOG_VVP  = vvp
IVERILOG_ARGS = -g2005-sv       \
                -gno-assertions \
                -o $(BUILD_BIN)
IVERILOG_ARGS_VVP = $(BUILD_BIN) \
                    -n           \
                    -lxt2

INCS_DIR = $(shell find $(AURORA_HOME)/src/ -type d -name "rtl")
INCS     = $(addprefix -I, $(INCS_DIR))

SRCS = $(addprefix rtl/, $(subst ],,$(subst [,,$(FILE)))) \
       $(addprefix tb/,  $(TOP).sv)

run:
	mkdir -p build
	$(IVERILOG) $(IVERILOG_ARGS) \
	$(INCS) $(SRCS)
	$(IVERILOG_VVP) $(IVERILOG_ARGS_VVP)
sim: run
	gtkwave $(BUILD_VCD) $(GTKW)
clean:
	rm -rf build
