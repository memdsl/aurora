.PHONY: run sim clean

INCS_DIR = $(shell find ${AURORA_HOME}/src/ -type d -name "rtl")
INCS     = $(addprefix -I, $(INCS_DIR))

SRCS = $(addsuffix .sv, $(addprefix rtl/, $(SRC)))

ARGS = -g2005-sv -gno-assertions
GTKW = tb/${TOP}_tb.gtkw

ifeq ($(shell find ${GTKW} -type f  >/dev/null 2>&1 && echo yes || echo no), no)
    GTKW =
endif

run:
	mkdir -p build
	iverilog ${ARGS} -o build/${TOP} ${INCS} $(SRCS) tb/${TOP}_tb.sv
	vvp -n build/${TOP} -lxt2
sim: run
	gtkwave build/${TOP}.vcd ${GTKW}
clean:
	rm -rf build
