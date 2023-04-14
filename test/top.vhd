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
    SIGNAL clk, reset, SR_IN_L, SR_IN_R, SR_OUT_L, SR_OUT_R : STD_ULOGIC := '0';
    SIGNAL A_IN, B_IN, SEL_FCT, SEL_ROUTE : STD_ULOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL SEL_OUT : STD_ULOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RES_OUT : STD_ULOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    top1 : top PORT MAP(
        clk => clk,
        reset => reset,
        SR_IN_L => SR_IN_L,
        SR_IN_R => SR_IN_R,
        A_IN => A_IN,
        B_IN => B_IN,
        SEL_FCT => SEL_FCT,
        SEL_ROUTE => SEL_ROUTE,
        SEL_OUT => SEL_OUT,
        RES_OUT => RES_OUT,
        SR_OUT_L => SR_OUT_L,
        SR_OUT_R => SR_OUT_R
    );

    myclock : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 10 us;
        clk <= '1';
        WAIT FOR 10 us;
    END PROCESS myclock;

    myprocess : PROCESS
    BEGIN
        FOR i IN 0 TO 4 LOOP
            SEL_OUT <= STD_ULOGIC_VECTOR(to_unsigned(i, 2));
            WAIT FOR 100 us;
            A_IN <= "0010";
            B_IN <= "0001";
            SEL_FCT <= "1101";
            SEL_OUT <= "11";
            SEL_ROUTE <= "1011";
            SR_IN_R <= '1';
            WAIT FOR 100 us;
            A_IN <= "1010";
            B_IN <= "1001";
            SEL_FCT <= "1101";
            SEL_OUT <= "11";
            SEL_ROUTE <= "1011";
            SR_IN_R <= '0';
        END LOOP;
        WAIT;
    END PROCESS myprocess;

END test_top_arch;