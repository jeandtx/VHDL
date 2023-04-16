LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY test_memory IS
END test_memory;

ARCHITECTURE testing_memory OF test_memory IS

    COMPONENT memory IS
        PORT (
            entry : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            outp : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL entry, outp_unused : STD_ULOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    uu_memory : memory PORT MAP(
        entry => entry,
        outp => outp_unused
    );

    myprocess : PROCESS
    BEGIN
        entry <= "00010000";
        WAIT FOR 10 ns;
        entry <= "00000010";
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS myprocess;
END testing_memory;