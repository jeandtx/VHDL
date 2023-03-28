Library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.numeric_std.all ;

entity selouttest is 
end selouttest;

architecture selouttest_arch of selouttest is
    component selout is
        port( 
            SEL_OUT: in std_logic_vector(1 downto 0);
            S: in std_logic_vector(7 downto 0);
            MEM_CACHE1: in std_logic_vector(7 downto 0);
            MEM_CACHE2: in std_logic_vector(7 downto 0);

            resOUT: out std_logic_vector(7 downto 0)
        );
    end component;
    signal SEL_OUT: std_logic_vector(1 downto 0);
    signal S, MEM_CACHE1, MEM_CACHE2, resout: std_logic_vector(7 downto 0);
begin
    uut: selout
    port map(
        SEL_OUT => SEL_OUT,
        S => S,
        MEM_CACHE1 => MEM_CACHE1,
        MEM_CACHE2 => MEM_CACHE2,
        resOUT => resOUT
    );

    myprocess: process
    begin
        S <= "00110000";
        MEM_CACHE1 <= "00000011";
        MEM_CACHE2 <= "11000010";
        for i in 0 to 3 loop
            SEL_OUT <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns;
        end loop;
        wait;
    end process;
end selouttest_arch;