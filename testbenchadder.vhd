library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ualtestbench is
end ualtestbench;

architecture ualtestbench_arch of ualtestbench is
    component ual
    port (
        A_in: in std_logic_vector(3 downto 0);
        B_in: in std_logic_vector(3 downto 0);
        SR_in_L: in std_logic;
        SR_in_R: in std_logic;
        SEL_FCT: in std_logic_vector(3 downto 0);
        SR_out_L: out std_logic;
        SR_out_R: out std_logic;
        S_out: out std_logic_vector(7 downto 0)
    );
    end component;

    signal A_in_sim, B_in_sim: std_logic_vector(3 downto 0) := (others => '0');
    signal SR_in_L_sim, SR_in_R_sim, SR_out_L_sim, SR_out_R_sim: std_logic := '0';
    signal SEL_FCT_sim: std_logic_vector(3 downto 0) := (others => '0');
    signal S_out_sim: std_logic_vector(7 downto 0) := (others => '0');

begin  
    ual1: ual
    port map(
        A_in => A_in_sim,
        B_in => B_in_sim,
        SR_in_L => SR_in_L_sim,
        SR_in_R => SR_in_R_sim,
        SEL_FCT => SEL_FCT_sim,
        SR_out_L => SR_out_L_sim,
        SR_out_R => SR_out_R_sim,
        S_out => S_out_sim
    );
    
    myprocess: process
    begin
        if SEL_FCT_sim = "0000" then
            A_in_sim <= "0010";
            B_in_sim <= "0011";
            SR_in_L_sim <= '0';
            SR_in_R_sim <= '1';
            wait;
        else
            report "Error";
        wait;
        end if;
    end process myprocess;
end ualtestbench_arch;
