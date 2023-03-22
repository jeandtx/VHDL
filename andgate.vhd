library IEEE;
use IEEE.std_logic_1164.all;

entity testBench is
end testBench;


architecture myArch of testBench is

     component ET2 is
        port (
            e1 : in std_logic;
            e2 : in std_logic;
            s1 : out std_logic
        );
      end component     ET2;

      signal e1_sim, e2_sim : std_logic := '0';
      signal s1_sim : std_logic := '0';


begin

    myComponentUnderTest : ET2

    port map (
    e1 => e1_sim,
    e2 => e2_sim,
    s1 => s1_sim
       );

    myStimulus : process
    begin
      e1_sim <= '0';
      e2_sim <= '0';
      wait for 100 us;
      report "e1_sim = " & std_logic'image(e1_sim) & " | e2_sim = " & std_logic'image(e2_sim) & " | s1_sim = " & std_logic'image(s1_sim) severity note;
      e1_sim <= '0';
      e2_sim <= '1';
      wait for 100 us;
      report "e1_sim = " & std_logic'image(e1_sim) & " | e2_sim = " & std_logic'image(e2_sim) & " | s1_sim = " & std_logic'image(s1_sim) severity warning;
      e1_sim <= '1';
      e2_sim <= '0';
      wait for 100 us;
      report "e1_sim = " & std_logic'image(e1_sim) & " | e2_sim = " & std_logic'image(e2_sim) & " | s1_sim = " & std_logic'image(s1_sim) severity error;
      e1_sim <= '1';
      e2_sim <= '1';
      wait for 100 us;
      report "e1_sim = " & std_logic'image(e1_sim) & " | e2_sim = " & std_logic'image(e2_sim) & " | s1_sim = " & std_logic'image(s1_sim) severity note;
    end process;
end myArch;