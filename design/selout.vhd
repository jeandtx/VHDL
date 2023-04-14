LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY selout IS
    PORT (
        SEL_OUT : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
        S : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
        MEM_CACHE1 : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
        MEM_CACHE2 : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);

        resOUT : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0)
    );
END selout;

ARCHITECTURE selout_arch OF selout IS
BEGIN
    PROCESS (SEL_OUT, S, MEM_CACHE1, MEM_CACHE2)
    BEGIN
        CASE SEL_OUT IS
            WHEN "00" =>
                resOUT <= (OTHERS => '0');
            WHEN "01" =>
                resOUT <= MEM_CACHE1;
            WHEN "10" =>
                resOUT <= MEM_CACHE2;
            WHEN "11" =>
                resOUT <= S;
            WHEN OTHERS =>
                NULL;
        END CASE;
    END PROCESS;
END selout_arch;