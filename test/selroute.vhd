LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY selroutetestbench IS
END selroutetestbench;

ARCHITECTURE selroutetestbench_arch OF selroutetestbench IS
    COMPONENT selroute
        PORT (
            A : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            B : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            SEL_ROUTE : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
            RES_IN : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            MEM_CACHE1_IN : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            MEM_CACHE2_IN : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);

            MEM_CACHE1_OUT : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0);
            MEM_CACHE2_OUT : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0);
            Buffer_A_IN : OUT STD_ULOGIC_VECTOR(3 DOWNTO 0);
            Buffer_B_IN : OUT STD_ULOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A, B, SEL_ROUTE, Buffer_A_IN_unused, Buffer_B_IN_unused : STD_ULOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL RES_IN, MEM_CACHE1_OUT_unused, MEM_CACHE2_OUT_unused, MEM_CACHE1_IN, MEM_CACHE2_IN : STD_ULOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    uut : selroute
    PORT MAP(
        A => A,
        B => B,
        SEL_ROUTE => SEL_ROUTE,
        RES_IN => RES_IN,
        MEM_CACHE1_IN => MEM_CACHE1_IN,
        MEM_CACHE2_IN => MEM_CACHE2_IN,

        MEM_CACHE1_OUT => MEM_CACHE1_OUT_unused,
        MEM_CACHE2_OUT => MEM_CACHE2_OUT_unused,
        Buffer_A_IN => Buffer_A_IN_unused,
        Buffer_B_IN => Buffer_B_IN_unused
    );

    PROCESS
    BEGIN
        A <= "1010";
        B <= "0101";
        RES_IN <= "11001100";
        MEM_CACHE1_IN <= "11111111";
        MEM_CACHE2_IN <= "11100111";
        FOR i IN 0 TO 15 LOOP
            SEL_ROUTE <= STD_ULOGIC_VECTOR(to_unsigned(i, 4));
            WAIT FOR 10 ns;
        END LOOP;
        WAIT;
    END PROCESS;
END selroutetestbench_arch;