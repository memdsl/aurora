include $(AURORA_HOME)/mk/base.mk

ifeq ($(shell find $(GTKW) -type f > /dev/null 2>&1 && echo yes || echo no), no)
    GTKW =
endif

TEST     ?=
TEST_LIST = $(shell find tb -type f | sed "s|.*/||; s|_tb\.sv$$||")
ifeq ($(filter $(TEST_LIST), $(TEST)),)
    ifeq ($(findstring $(MAKECMDGOALS), config|clean),)
        $(error [error]: $$TEST is incorrect, optional values in \
       [$(subst $(TOOL_SPACE),$(TOOL_COMMA),$(TEST_LIST))])
    endif
endif

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
SRCS_SV_FILE          = $(subst ',, $(subst $(TOOL_COMMA),$(TOOL_SPACE), $(subst ],, $(subst [,, $(FILE)))))
SRCS_SV_WHITELIST     = $(SRCS_SV_FILE) \
                        $(addprefix tb/,  $(TOP).sv)
SRCS_SV               = $(filter-out $(SRCS_SV_BLACKLIST), $(SRCS_SV_WHITELIST))

SRCS_CXX =
SRCS     = $(SRCS_SV) $(SRCS_CXX)

$(BUILD_MK):
	$(VERILATOR) $(VERILATOR_ARGS)         \
	$(INCS) $(SRCS)                        \
	$(addprefix -CFLAGS ,  $(CXX_CFLAGS))  \
	$(addprefix -LDFLAGS , $(CXX_LDFLAGS))
$(BUILD_BIN): $(BUILD_MK)
	make -C build -f $(BUILD_MK) CXX=$(CXX)

run: $(BUILD_BIN)
	$(BUILD_BIN)
sim: run
	gtkwave $(BUILD_VCD) $(GTKW)
clean:
	rm -rf build
