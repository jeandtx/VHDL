LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY test_top IS
END test_top;

ARCHITECTURE test_top_arch OF test_top IS
    COMPONENT top
        PORT (
            clk : IN STD_ULOGIC;
            reset : IN STD_ULOGIC;
            SR_IN_L : IN STD_ULOGIC;
            SR_IN_R : IN STD_ULOGIC;
            A_IN : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            B_IN : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);

            SEL_FCT : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            SEL_ROUTE : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            SEL_OUT : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);

            RES_OUT : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0);
            SR_OUT_L : OUT STD_ULOGIC;
            SR_OUT_R : OUT STD_ULOGIC
        );
    END COMPONENT;
    SIGNAL clk, reset_unused, SR_IN_L_unused, SR_IN_R_unused, SR_OUT_L_unused, SR_OUT_R_unused : STD_ULOGIC := '0';
    SIGNAL A_IN, B_IN, SEL_FCT, SEL_ROUTE : STD_ULOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL SEL_OUT : STD_ULOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RES_OUT_unused : STD_ULOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    top1 : top PORT MAP(
        clk => clk,
        reset => reset_unused,
        SR_IN_L => SR_IN_L_unused,
        SR_IN_R => SR_IN_R_unused,
        A_IN => A_IN,
        B_IN => B_IN,
        SEL_FCT => SEL_FCT,
        SEL_ROUTE => SEL_ROUTE,
        SEL_OUT => SEL_OUT,
        RES_OUT => RES_OUT_unused,
        SR_OUT_L => SR_OUT_L_unused,
        SR_OUT_R => SR_OUT_R_unused
    );

    myclock : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 us;
        clk <= '1';
        WAIT FOR 10 us;
    END PROCESS myclock;

    -- mySYNCprocess : PROCESS
    -- BEGIN
    --     A_IN <= "0010";
    --     B_IN <= "0001";
    --     SEL_ROUTE <= "0000";
    --     WAIT UNTIL rising_edge(CLK);
    --     SEL_ROUTE <= "0001";
    --     WAIT UNTIL rising_edge(CLK);
    --     SEL_FCT <= "1111";
    --     SEL_OUT <= "11";
    --     WAIT;
    -- END PROCESS mySYNCprocess;

    -- a_times_b : PROCESS
    -- BEGIN
    --     A_IN <= "0010";
    --     B_IN <= "0110";
    --     SEL_ROUTE <= "0000";
    --     WAIT UNTIL rising_edge(clk);
    --     SEL_ROUTE <= "0001";
    --     WAIT UNTIL rising_edge(clk);
    --     SEL_FCT <= "1100";
    --     SEL_OUT <= "11";
    --     WAIT UNTIL rising_edge(clk);

    --     A_IN <= "0010";
    --     B_IN <= "1000";
    --     SEL_ROUTE <= "0000";
    --     WAIT UNTIL rising_edge(clk);
    --     SEL_ROUTE <= "0001";
    --     WAIT UNTIL rising_edge(clk);
    --     SEL_FCT <= "1100";
    --     SEL_OUT <= "11";

    --     WAIT;
    -- END PROCESS a_times_b;

    -- aplusb_xnora : PROCESS
    -- BEGIN
    --     SEL_OUT <= "11";
    --     A_IN <= "0010";
    --     B_IN <= "0100";
    --     SEL_ROUTE <= "0000";
    --     WAIT UNTIL rising_edge(clk);
    --     SEL_ROUTE <= "0001";
    --     WAIT UNTIL rising_edge(clk);

    --     SEL_FCT <= "1110";
    --     SEL_ROUTE <= "1110";
    --     WAIT UNTIL rising_edge(clk);
    --     -- Now A = A, B = A + B 

    --     SEL_FCT <= "0111";
    --     SEL_ROUTE <= "1100";
    --     WAIT UNTIL rising_edge(clk);
    --     -- Now A = A xor (A + B), B = A + B

    --     SEL_FCT <= "0011";
    --     -- Output A xnor (A + B) in RES_OUT
    --     WAIT;
    -- END PROCESS aplusb_xnora;

    A0andB1_or_A1andB0 : PROCESS
    BEGIN
        SEL_OUT <= "11";
        A_IN <= "1111";
        B_IN <= "1000";
        SEL_ROUTE <= "0000";
        WAIT UNTIL rising_edge(clk);
        SEL_ROUTE <= "0001";
        WAIT UNTIL rising_edge(clk);
        -- Now A = A0, B = B0

        SEL_FCT <= "0010";
        SEL_ROUTE <= "1011";
        WAIT UNTIL rising_edge(clk);
        -- Now A = A0, B = B0, MEM_CACHE2 = B0

        SEL_FCT <= "0001";
        SEL_ROUTE <= "0110";
        WAIT UNTIL rising_edge(clk);
        -- Now A = A0, B = B0, MEM_CACHE1 = A0, MEM_CACHE2 = B0

        A_IN <= "0100";
        B_IN <= "0001";
        -- Now A = A, B = B, MEM_CACHE1 = A0, MEM_CACHE2 = B0

        SEL_ROUTE <= "0010";
        WAIT UNTIL rising_edge(clk);
        SEL_ROUTE <= "0001";
        WAIT UNTIL rising_edge(clk);
        SEL_FCT <= "0101";
        SEL_ROUTE <= "0110";
        WAIT UNTIL rising_edge(clk);
        -- Now A = A, B = B, MEM_CACHE1 = A0 and B, MEM_CACHE2 = B0

        SEL_ROUTE <= "0000";
        WAIT UNTIL rising_edge(clk);
        SEL_ROUTE <= "0111";
        WAIT UNTIL rising_edge(clk);
        SEL_FCT <= "0101";
        SEL_ROUTE <= "1011";
        WAIT UNTIL rising_edge(clk);
        -- Now A = A, B = B, MEM_CACHE1 = A0 and B, MEM_CACHE2 = A and B0

        SEL_ROUTE <= "0010";
        WAIT UNTIL rising_edge(clk);
        SEL_ROUTE <= "0111";
        WAIT UNTIL rising_edge(clk);
        SEL_FCT <= "0110";
        -- Finally, RES_OUT = (A0 and B) or (A and B0)

        WAIT;
    END PROCESS A0andB1_or_A1andB0;

END test_top_arch;