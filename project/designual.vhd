library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ual is
    port(
        A_in: in std_logic_vector(3 downto 0);
        B_in: in std_logic_vector(3 downto 0);
        SR_in_L: in std_logic;
        SR_in_R: in std_logic;
        SEL_FCT: in std_logic_vector(3 downto 0);
        SR_out_L: out std_logic;
        SR_out_R: out std_logic;
        S_out: out std_logic_vector(7 downto 0)
    
);
end ual;

architecture ual_dataflow of ual is
    begin
        process(A_in, B_in, SEL_FCT, SR_in_L, SR_in_R)
        begin
            S_out <= (others => '0');
            case SEL_FCT is
            when "0000" => -- nop (no operation)
            S_out <= (others => '0');
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "0001" => -- S=A SR_OUT_L=0etSR_OUT_R=0
            S_out(3 downto 0) <= A_in;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "0010" => -- S=B SR_OUT_L=0etSR_OUT_R=0
            S_out(3 downto 0) <= B_in;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "0011" => -- S=notA|SR_OUT_L=0etSR_OUT_R=0
            S_out(3 downto 0) <= not A_in;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "0100" => -- S=notB SR_OUT_L=0etSR_OUT_R=0
            S_out(3 downto 0) <= not B_in;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "0101" => -- S=A&B SR_OUT_L=0etSR_OUT_R=0
            S_out(3 downto 0) <= A_in and B_in;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "0110" => -- S=AorB|SR_OUT_L=0etSR_OUT_R=0
            S_out(3 downto 0) <= A_in or B_in;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "0111" => -- S=A xor B SR_OUT_L=0etSR_OUT_R=0
            S_out(3 downto 0) <= A_in xor B_in;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "1000" => -- S = Right shift A (avec SR_IN_L)
            S_out(3 downto 0) <= '0' & A_in(3 downto 1);
            SR_out_R <= A_in(0);
            SR_out_L <= '0' or SR_in_L;
            when "1001" => -- S = Left shift A (avec SR_IN_R)
            S_out(3 downto 1) <= A_in(2 downto 0);
            S_out(0) <= SR_in_R;
            SR_out_L <= A_in(3);
            SR_out_R <= '0';
            when "1010" => -- S = Right shift B (avec SR_IN_L)
            S_out(2 downto 0) <= B_in(3 downto 1);
            S_out(3) <= SR_in_L;
            SR_out_R <= B_in(0);
            SR_out_L <= '0';            
            when "1011" => -- S = Left shift B (avec SR_IN_R)
            S_out(3 downto 1) <= B_in(2 downto 0);
            S_out(0) <= SR_in_R;
            SR_out_L <= B_in(3);
            SR_out_R <= '0';
            when "1100" => -- S = A * B
            S_out <= std_logic_vector(unsigned(A_in) * unsigned(B_in));
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "1101" => -- S = A + B with SR_IN_R as carry in
            if SR_in_R = '1' then
                S_out(3 downto 0) <= std_logic_vector(unsigned(A_in) + unsigned(B_in) + 1);
                if to_integer(unsigned(A_in)) + to_integer(unsigned(B_in)) > 14 then
                    S_out(4) <= '1';
                end if;
            else
                S_out(3 downto 0) <= std_logic_vector(unsigned(A_in) + unsigned(B_in));
                if to_integer(unsigned(A_in)) + to_integer(unsigned(B_in)) > 14 then
                    S_out(4) <= '1';
                end if;
            end if;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "1110" => -- S = A + B without carry in
            S_out(3 downto 0) <= std_logic_vector(unsigned(A_in) + unsigned(B_in));
            if to_integer(unsigned(A_in)) + to_integer(unsigned(B_in))> 15 then
                S_out(4) <= '1';
            end if;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when "1111" => -- S = A - B
            S_out(3 downto 0) <= std_logic_vector(unsigned(A_in) - unsigned(B_in));
            if unsigned(A_in) < unsigned(B_in) then
                S_out(4) <= '1';
            end if;
            SR_out_L <= '0';
            SR_out_R <= '0';
            when others =>
            S_out <= (others => '0');
            SR_out_L <= '0';
            SR_out_R <= '0';
        end case;
    end process;
end ual_dataflow;

