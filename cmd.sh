selout
ghdl -a --ieee=synopsys -fexplicit ./design/selout.vhd  
ghdl -e --ieee=synopsys -fexplicit selout

ghdl -a --ieee=synopsys -fexplicit ./test/selout.vhd
ghdl -e --ieee=synopsys -fexplicit selouttest

ghdl -r --ieee=synopsys -fexplicit selouttest --vcd=testbench.vcd --stop-time=1ms

selroute
ghdl -a --ieee=synopsys -fexplicit ./design/selroute.vhd  
ghdl -e --ieee=synopsys -fexplicit selroute

ghdl -a --ieee=synopsys -fexplicit ./test/selroute.vhd
ghdl -e --ieee=synopsys -fexplicit selroutetestbench

ghdl -r --ieee=synopsys -fexplicit selroutetestbench --vcd=testbench.vcd --stop-time=1ms

buffer 
ghdl -a --ieee=synopsys -fexplicit ./design/buffer.vhd  
ghdl -e --ieee=synopsys -fexplicit bufferNbits

ghdl -a --ieee=synopsys -fexplicit ./test/buffer.vhd
ghdl -e --ieee=synopsys -fexplicit mybufferNbitstestbench

ghdl -r --ieee=synopsys -fexplicit mybufferNbitstestbench --vcd=testbench.vcd --stop-time=1ms
