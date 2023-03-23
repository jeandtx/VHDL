library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity myinterconnection is
end myinterconnection;

architecture myinterconnection_arch of myinterconnection is
    component interconnection is
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
    end component;

    signal SR_IN_L, SR_IN_R, RESET, CLK, SR_OUT_L, SR_OUT_R: std_logic := '0'; 
    signal A_in, B_in, MEM_SEL_FCT, SEL_ROUTE: std_logic_vector(3 downto 0) := (others => '0');
    signal MEM_SEL_OUT: std_logic_vector(1 downto 0) := (others => '0');
    signal RES_OUT: std_logic_vector(7 downto 0) := (others => '0');

begin
    clock: process
    begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
    end process;
    
    myinterconnectionTEST: process
    begin
        A_in <= "0001";
        wait for 100 ns;
        A_in <= "0000";
        wait;
    end process;
end myinterconnection_arch;