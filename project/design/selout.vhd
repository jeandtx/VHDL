library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity selout is 
port(
    SEL_OUT: in std_logic_vector(1 downto 0);
    S: in std_logic_vector(7 downto 0);
    MEM_CACHE1: in std_logic_vector(7 downto 0);
    MEM_CACHE2: in std_logic_vector(7 downto 0);

    resOUT: out std_logic_vector(7 downto 0)
);
end selout;

architecture selout_arch of selout is
begin
    process(SEL_OUT, S, MEM_CACHE1, MEM_CACHE2)
    begin
        case SEL_OUT is
            when "00" => 
                resOUT <= (others =>'0');
            when "01" =>
                resOUT <= MEM_CACHE1;
            when "10" =>
                resOUT <= MEM_CACHE2;
            when "11" =>
                resOUT <= S;
            when others =>
                null;
        end case;
    end process;
end selout_arch;