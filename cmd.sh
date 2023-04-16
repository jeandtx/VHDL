ual 
ghdl -a --ieee=synopsys -fexplicit ./design/ual.vhd  
ghdl -e --ieee=synopsys -fexplicit ual

ghdl -a --ieee=synopsys -fexplicit ./test/ual.vhd
ghdl -e --ieee=synopsys -fexplicit ualtestbench

ghdl -r --ieee=synopsys -fexplicit ualtestbench --vcd=testbench.vcd --stop-time=1ms

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

MEMORY_CACHE 
ghdl -a --ieee=synopsys -fexplicit ./design/memoryCache.vhd  
ghdl -e --ieee=synopsys -fexplicit memory

ghdl -a --ieee=synopsys -fexplicit ./test/memoryCache.vhd
ghdl -e --ieee=synopsys -fexplicit test_memory

ghdl -r --ieee=synopsys -fexplicit test_memory --vcd=testbench.vcd --stop-time=1ms

TOP
ghdl -a --ieee=synopsys -fexplicit ./design/buffer.vhd  
ghdl -e --ieee=synopsys -fexplicit bufferNbits
ghdl -a --ieee=synopsys -fexplicit ./design/selroute.vhd  
ghdl -e --ieee=synopsys -fexplicit selroute
ghdl -a --ieee=synopsys -fexplicit ./design/selout.vhd  
ghdl -e --ieee=synopsys -fexplicit selout
ghdl -a --ieee=synopsys -fexplicit ./design/ual.vhd  
ghdl -e --ieee=synopsys -fexplicit ual
ghdl -a --ieee=synopsys -fexplicit ./design/memoryCache.vhd  
ghdl -e --ieee=synopsys -fexplicit memory
ghdl -a --ieee=synopsys -fexplicit ./design/top.vhd  
ghdl -e --ieee=synopsys -fexplicit top

ghdl -a --ieee=synopsys -fexplicit ./test/top.vhd
ghdl -e --ieee=synopsys -fexplicit test_top

ghdl -r --ieee=synopsys -fexplicit test_top --vcd=testbench.vcd --stop-time=1ms
