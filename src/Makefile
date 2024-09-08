.PHONY: run sim clean

INCS_DIR = $(shell find ${AURORA_HOME}/src/ -type d -name "rtl")
INCS     = $(addprefix -I, $(INCS_DIR))

run:
	mkdir -p build
	iverilog -g2005-sv -o build/${FILE} ${INCS} rtl/${FILE}.sv  tb/${FILE}_tb.sv
	vvp -n build/${FILE} -lxt2
sim: run
	gtkwave build/${FILE}.vcd
clean:
	rm -rf build
