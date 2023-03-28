library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity selroute is 
port(
    A: in std_logic_vector(3 downto 0);
    B: in std_logic_vector(3 downto 0);
    SEL_ROUTE: in std_logic_vector(3 downto 0);
    RES_IN: in std_logic_vector(7 downto 0);
    MEM_CACHE1_IN: in std_logic_vector(7 downto 0);
    MEM_CACHE2_IN: in std_logic_vector(7 downto 0);

    MEM_CACHE1_OUT: out std_logic_vector(7 downto 0);
    MEM_CACHE2_OUT: out std_logic_vector(7 downto 0);
    Buffer_A_IN: out std_logic_vector(3 downto 0);
    Buffer_B_IN: out std_logic_vector(3 downto 0)
);
end selroute;

architecture selroute_dataflow of selroute is
begin
    process(A, B, SEL_ROUTE, RES_IN)
    begin
        Buffer_A_IN <= (others => '0');
        Buffer_B_IN <= (others => '0');
        MEM_CACHE1_OUT <= (others => '0');
        MEM_CACHE2_OUT <= (others => '0');
        case SEL_ROUTE is 
            when "0000" =>
                Buffer_A_IN <= A;
            when "0001" =>
                Buffer_B_IN <= B;
            when "0010" =>
                Buffer_A_IN <= MEM_CACHE1_IN(3 downto 0);
            when "0011" =>
                Buffer_A_IN <= MEM_CACHE1_IN(7 downto 4);
            when "0100" =>
                Buffer_B_IN <= MEM_CACHE1_IN(3 downto 0);
            when "0101" =>
                Buffer_B_IN <= MEM_CACHE1_IN(7 downto 4);
            when "0110" =>
                MEM_CACHE1_OUT <= RES_IN;
            when "0111" =>
                Buffer_A_IN <= MEM_CACHE2_IN(3 downto 0);
            when "1000" =>
                Buffer_A_IN <= MEM_CACHE2_IN(7 downto 4);
            when "1001" =>
                Buffer_B_IN <= MEM_CACHE2_IN(3 downto 0);
            when "1010" =>
                Buffer_B_IN <= MEM_CACHE2_IN(7 downto 4);
            when "1011" =>
                MEM_CACHE2_OUT <= RES_IN;
            when "1100" =>
                Buffer_A_IN <= RES_IN(3 downto 0);
            when "1101" =>
                Buffer_A_IN <= RES_IN(7 downto 4);
            when "1110" =>
                Buffer_B_IN <= RES_IN(3 downto 0);
            when "1111" =>
                Buffer_B_IN <= RES_IN(7 downto 4);
            when others =>
                null;
        end case;
    end process;
end selroute_dataflow;