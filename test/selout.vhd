LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY selouttest IS
END selouttest;

ARCHITECTURE selouttest_arch OF selouttest IS
    COMPONENT selout IS
        PORT (
            SEL_OUT : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
            S : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            MEM_CACHE1 : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            MEM_CACHE2 : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);

            resOUT : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL SEL_OUT : STD_ULOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL S, MEM_CACHE1, MEM_CACHE2, resOUT_unused : STD_ULOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    uut : selout
    PORT MAP(
        SEL_OUT => SEL_OUT,
        S => S,
        MEM_CACHE1 => MEM_CACHE1,
        MEM_CACHE2 => MEM_CACHE2,
        resOUT => resOUT_unused
    );

    myprocess : PROCESS
    BEGIN
        S <= "00110000";
        MEM_CACHE1 <= "00000011";
        MEM_CACHE2 <= "11000010";
        FOR i IN 0 TO 3 LOOP
            SEL_OUT <= STD_ULOGIC_VECTOR(to_unsigned(i, 2));
            WAIT FOR 10 ns;
        END LOOP;
        WAIT;
    END PROCESS;
END selouttest_arch;