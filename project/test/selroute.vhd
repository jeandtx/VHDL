library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity selroutetestbench is
end selroutetestbench;

architecture selroutetestbench_arch of selroutetestbench is
    component selroute
    port (
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        SEL_ROUTE: in std_logic_vector(3 downto 0);
        RES_IN: in std_logic_vector(7 downto 0);

        MEM_CACHE1_OUT: out std_logic_vector(7 downto 0);
        MEM_CACHE2_OUT: out std_logic_vector(7 downto 0);
        Buffer_A_IN: out std_logic_vector(3 downto 0);
        Buffer_B_IN: out std_logic_vector(3 downto 0)
    );
    end component;

    signal A, B, SEL_ROUTE, Buffer_A_IN, Buffer_B_IN: std_logic_vector(3 downto 0);
    signal RES_IN, MEM_CACHE1_OUT, MEM_CACHE2_OUT: std_logic_vector(7 downto 0);

begin
    uut: selroute
    port map (
        A => A,
        B => B,
        SEL_ROUTE => SEL_ROUTE,
        RES_IN => RES_IN,

        MEM_CACHE1_OUT => MEM_CACHE1_OUT,
        MEM_CACHE2_OUT => MEM_CACHE2_OUT,
        Buffer_A_IN => Buffer_A_IN,
        Buffer_B_IN => Buffer_B_IN
    );

    process
    begin
        A <= "1010";
        B <= "0101";
        RES_IN <= "11001100";
        for i in 0 to 15 loop
            SEL_ROUTE <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;
end selroutetestbench_arch;