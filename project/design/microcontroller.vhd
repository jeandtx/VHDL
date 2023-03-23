library IEEE;
use IEEE.std_logic_1164.all;

entity microcontroller is(
    port(
        clk: in std_logic;
        rst: in std_logic;
        sr_in_l: in std_logic;
        sr_in_r: in std_logic;
        A_in: in std_logic_vector(4 downto 0);
        B_in: in std_logic_vector(4 downto 0);
        res_out: out std_logic_vector(8 downto 0);
        sr_out_l: out std_logic;
        sr_out_r: out std_logic;
    );
);
end microcontroller;

architecture microcontroller_dataflow of microcontroller is
begin
    microcontroller_process_flag: process(clk, rst, sr_in_l, sr_in_r, A_in, B_in)
    begin
        -- if(rst = '1') then
        --     res_out <= "000000000";
        --     sr_out_l <= '0';
        --     sr_out_r <= '0';
        -- elsif(rising_edge(clk)) then
        --     if(A_in(4) = '1') then
        --         res_out <= A_in + B_in;
        --     else
        --         res_out <= A_in - B_in;
        --     end if;
        --     if(res_out(8) = '1') then
        --         sr_out_l <= '1';
        --         sr_out_r <= '0';
        --     else
        --         sr_out_l <= '0';
        --         sr_out_r <= '1';
        --     end if;
        -- end if;
    end process;
end microcontroller_dataflow;
