ghdl -a --ieee=synopsys -fexplicit ./design/buffer.vhd  
ghdl -e --ieee=synopsys -fexplicit bufferNbits

ghdl -a --ieee=synopsys -fexplicit ./test/buffer.vhd
ghdl -e --ieee=synopsys -fexplicit mybufferNbitstestbench

ghdl -r --ieee=synopsys -fexplicit mybufferNbitstestbench --vcd=testbench.vcd --stop-time=1ms
