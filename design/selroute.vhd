LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY selroute IS
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
END selroute;

ARCHITECTURE selroute_dataflow OF selroute IS
BEGIN
    PROCESS (A, B, SEL_ROUTE, RES_IN)
    BEGIN
        CASE SEL_ROUTE IS
            WHEN "0000" =>
                Buffer_A_IN <= A;
            WHEN "0001" =>
                Buffer_B_IN <= B;
            WHEN "0010" =>
                Buffer_A_IN <= MEM_CACHE1_IN(3 DOWNTO 0);
            WHEN "0011" =>
                Buffer_A_IN <= MEM_CACHE1_IN(7 DOWNTO 4);
            WHEN "0100" =>
                Buffer_B_IN <= MEM_CACHE1_IN(3 DOWNTO 0);
            WHEN "0101" =>
                Buffer_B_IN <= MEM_CACHE1_IN(7 DOWNTO 4);
            WHEN "0110" =>
                MEM_CACHE1_OUT <= RES_IN;
            WHEN "0111" =>
                Buffer_A_IN <= MEM_CACHE2_IN(3 DOWNTO 0);
            WHEN "1000" =>
                Buffer_A_IN <= MEM_CACHE2_IN(7 DOWNTO 4);
            WHEN "1001" =>
                Buffer_B_IN <= MEM_CACHE2_IN(3 DOWNTO 0);
            WHEN "1010" =>
                Buffer_B_IN <= MEM_CACHE2_IN(7 DOWNTO 4);
            WHEN "1011" =>
                MEM_CACHE2_OUT <= RES_IN;
            WHEN "1100" =>
                Buffer_A_IN <= RES_IN(3 DOWNTO 0);
            WHEN "1101" =>
                Buffer_A_IN <= RES_IN(7 DOWNTO 4);
            WHEN "1110" =>
                Buffer_B_IN <= RES_IN(3 DOWNTO 0);
            WHEN "1111" =>
                Buffer_B_IN <= RES_IN(7 DOWNTO 4);
            WHEN OTHERS =>
                NULL;
        END CASE;
    END PROCESS;
END selroute_dataflow;