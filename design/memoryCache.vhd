LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY memory IS
    PORT (
        entry : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
        outp : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0)
    );
END memory;

ARCHITECTURE memory_arch OF memory IS
BEGIN
    PROCESS (entry)
    BEGIN
        outp <= entry;
    END PROCESS;
END memory_arch;