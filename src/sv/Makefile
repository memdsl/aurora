.PHONY: run sim clean

run:
	mkdir -p build
	iverilog -g2005-sv -o build/${FILE} -I rtl rtl/${FILE}.sv sim/${FILE}_tb.sv
	vvp -n build/${FILE} -lxt2
sim: run
	gtkwave build/${FILE}.vcd
clean:
	rm -rf build
