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

INCS_DIR = rtl
INCS     = $(addprefix -I, $(INCS_DIR))

SRCS_FILE = $(subst ',, $(subst $(TOOL_COMMA),$(TOOL_SPACE), $(subst ],, $(subst [,, $(FILE)))))
SRCS      = $(SRCS_FILE) \
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
