library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity multNbits is 
generic (
    N : integer := 4
);
port (
    e1: in std_logic_vector(N-1 downto 0);
    e2: in std_logic_vector(N-1 downto 0);
    s: out std_logic_vector(2*N-1 downto 0)
);
end multNbits;

architecture multNbits_Dataflow of multNbits is
begin
    s <= e1 * e2;
end multNbits_Dataflow;
