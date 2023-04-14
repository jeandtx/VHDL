LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY ual IS
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
END ual;

ARCHITECTURE ual_dataflow OF ual IS
BEGIN
    PROCESS (A_in, B_in, SEL_FCT, SR_in_L, SR_in_R)
    BEGIN
        S_out <= (OTHERS => '0');
        CASE SEL_FCT IS
            WHEN "0000" => -- nop (no operation)
                S_out <= (OTHERS => '0');
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "0001" => -- S=A SR_OUT_L=0etSR_OUT_R=0
                S_out(3 DOWNTO 0) <= A_in;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "0010" => -- S=B SR_OUT_L=0etSR_OUT_R=0
                S_out(3 DOWNTO 0) <= B_in;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "0011" => -- S=notA|SR_OUT_L=0etSR_OUT_R=0
                S_out(3 DOWNTO 0) <= NOT A_in;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "0100" => -- S=notB SR_OUT_L=0etSR_OUT_R=0
                S_out(3 DOWNTO 0) <= NOT B_in;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "0101" => -- S=A&B SR_OUT_L=0etSR_OUT_R=0
                S_out(3 DOWNTO 0) <= A_in AND B_in;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "0110" => -- S=AorB|SR_OUT_L=0etSR_OUT_R=0
                S_out(3 DOWNTO 0) <= A_in OR B_in;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "0111" => -- S=A xor B SR_OUT_L=0etSR_OUT_R=0
                S_out(3 DOWNTO 0) <= A_in XOR B_in;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "1000" => -- S = Right shift A (avec SR_IN_L)
                S_out(3 DOWNTO 0) <= '0' & A_in(3 DOWNTO 1);
                SR_out_R <= A_in(0);
                SR_out_L <= '0' OR SR_in_L;
            WHEN "1001" => -- S = Left shift A (avec SR_IN_R)
                S_out(3 DOWNTO 1) <= A_in(2 DOWNTO 0);
                S_out(0) <= SR_in_R;
                SR_out_L <= A_in(3);
                SR_out_R <= '0';
            WHEN "1010" => -- S = Right shift B (avec SR_IN_L)
                S_out(2 DOWNTO 0) <= B_in(3 DOWNTO 1);
                S_out(3) <= SR_in_L;
                SR_out_R <= B_in(0);
                SR_out_L <= '0';
            WHEN "1011" => -- S = Left shift B (avec SR_IN_R)
                S_out(3 DOWNTO 1) <= B_in(2 DOWNTO 0);
                S_out(0) <= SR_in_R;
                SR_out_L <= B_in(3);
                SR_out_R <= '0';
            WHEN "1100" => -- S = A * B
                S_out <= STD_ULOGIC_VECTOR(unsigned(A_in) * unsigned(B_in));
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "1101" => -- S = A + B with SR_IN_R as carry in
                IF SR_in_R = '1' THEN
                    S_out(3 DOWNTO 0) <= STD_ULOGIC_VECTOR(unsigned(A_in) + unsigned(B_in) + 1);
                    IF to_integer(unsigned(A_in)) + to_integer(unsigned(B_in)) > 14 THEN
                        S_out(4) <= '1';
                    END IF;
                ELSE
                    S_out(3 DOWNTO 0) <= STD_ULOGIC_VECTOR(unsigned(A_in) + unsigned(B_in));
                    IF to_integer(unsigned(A_in)) + to_integer(unsigned(B_in)) > 14 THEN
                        S_out(4) <= '1';
                    END IF;
                END IF;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "1110" => -- S = A + B without carry in
                S_out(3 DOWNTO 0) <= STD_ULOGIC_VECTOR(unsigned(A_in) + unsigned(B_in));
                IF to_integer(unsigned(A_in)) + to_integer(unsigned(B_in)) > 15 THEN
                    S_out(4) <= '1';
                END IF;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN "1111" => -- S = A - B
                S_out(3 DOWNTO 0) <= STD_ULOGIC_VECTOR(unsigned(A_in) - unsigned(B_in));
                IF unsigned(A_in) < unsigned(B_in) THEN
                    S_out(4) <= '1';
                END IF;
                SR_out_L <= '0';
                SR_out_R <= '0';
            WHEN OTHERS =>
                S_out <= (OTHERS => '0');
                SR_out_L <= '0';
                SR_out_R <= '0';
        END CASE;
    END PROCESS;
END ual_dataflow;