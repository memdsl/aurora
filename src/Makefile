.PHONY: run sim clean

INCS_DIR = $(shell find ${AURORA_HOME}/src/ -type d -name "rtl")
INCS     = $(addprefix -I, $(INCS_DIR))

SRCS = $(addsuffix .sv, $(addprefix rtl/, $(SRC)))

run:
	mkdir -p build
	iverilog -g2005-sv -o build/${TOP} ${INCS} $(SRCS) tb/${TOP}_tb.sv
	vvp -n build/${TOP} -lxt2
sim: run
	gtkwave build/${TOP}.vcd
clean:
	rm -rf build
