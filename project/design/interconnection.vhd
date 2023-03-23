library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity interconnection is 
port(
    SR_IN_L: in std_logic;
    SR_IN_R: in std_logic;
    A_in: in std_logic_vector(3 downto 0);
    B_in: in std_logic_vector(3 downto 0);
    RESET: in std_logic;
    CLK: in std_logic;
    MEM_SEL_FCT: in std_logic_vector(3 downto 0);
    SEL_ROUTE: in std_logic_vector(3 downto 0);
    MEM_SEL_OUT: in std_logic_vector(1 downto 0);
    SR_OUT_L: out std_logic;
    SR_OUT_R: out std_logic;
    RES_OUT: out std_logic_vector(7 downto 0)
);
end interconnection;

architecture interconnection_dataflow of interconnection is
    component bufferNbits is 
    generic (
        N: integer := 4
    );
    port(
        e1: in std_logic_vector(N-1 downto 0);
        clock: in std_logic;
        s1: out std_logic_vector(N-1 downto 0);
        reset : in std_logic;
	    preset : in std_logic
    );
    end component bufferNbits;
    signal A_out: std_logic_vector(3 downto 0);

    begin
        MyComponentBuffer: bufferNbits
        generic map (N => 4)
        port map(
            e1 => A_in,
            clock => CLK,
            s1 => A_out,
            reset => SR_IN_L,
            preset => SR_IN_R
        );
        

end interconnection_dataflow;