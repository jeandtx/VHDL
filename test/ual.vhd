LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY ualtestbench IS
END ualtestbench;

ARCHITECTURE ualtestbench_arch OF ualtestbench IS
    COMPONENT ual
        PORT (
            A_in : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            B_in : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            SR_in_L : IN STD_ULOGIC;
            SR_in_R : IN STD_ULOGIC;
            SEL_FCT : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            SR_out_L : OUT STD_ULOGIC;
            SR_out_R : OUT STD_ULOGIC;
            S_out : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A_in_sim, B_in_sim : STD_ULOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL SR_in_L_sim, SR_in_R_sim, SR_out_L_sim_unused, SR_out_R_sim_unused : STD_ULOGIC := '0';
    SIGNAL SEL_FCT_sim : STD_ULOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL S_out_sim_unused : STD_ULOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    ual1 : ual
    PORT MAP(
        A_in => A_in_sim,
        B_in => B_in_sim,
        SR_in_L => SR_in_L_sim,
        SR_in_R => SR_in_R_sim,
        SEL_FCT => SEL_FCT_sim,
        SR_out_L => SR_out_L_sim_unused,
        SR_out_R => SR_out_R_sim_unused,
        S_out => S_out_sim_unused
    );

    myprocess : PROCESS
    BEGIN
        A_in_sim <= "0010";
        B_in_sim <= "1110";
        SR_in_L_sim <= '1';
        SR_in_R_sim <= '1';
        FOR i IN 0 TO 15 LOOP
            SEL_FCT_sim <= STD_ULOGIC_VECTOR(to_unsigned(i, 4));
            FOR j IN 0 TO 15 LOOP
                A_in_sim <= STD_ULOGIC_VECTOR(to_unsigned(j, 4));
                WAIT FOR 10 ns;
            END LOOP;
            WAIT FOR 10 ns;
        END LOOP;
        WAIT;
    END PROCESS myprocess;
END ualtestbench_arch;