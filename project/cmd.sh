ghdl -a --ieee=synopsys -fexplicit designual.vhd  
ghdl -e --ieee=synopsys -fexplicit ual

ghdl -a --ieee=synopsys -fexplicit testbenchual.vhd
ghdl -e --ieee=synopsys -fexplicit ualtestbench

ghdl -r --ieee=synopsys -fexplicit ualtestbench --vcd=testbench.vcd --stop-time=1us
