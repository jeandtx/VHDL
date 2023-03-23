Library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.numeric_std.all ;

--Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
entity mybufferNbitstestbench is

end mybufferNbitstestbench;

architecture mybufferNbitstestbench_Arch of mybufferNbitstestbench is
	component bufferNbits is
	generic (N : integer );
	port(
		e1 : in std_logic_vector (N-1 downto 0);
		reset : in std_logic;
		preset : in std_logic;
		clock : in std_logic;
		s1 : out std_logic_vector (N-1 downto 0)
	);
	end component;

	constant N : integer := 3;

    constant PERIOD : time := 50 us;

	signal e1_sim : std_logic_vector(N-1 downto 0) := (others => '0');
	signal s1_sim : std_logic_vector(N-1 downto 0) := (others => '0');
	signal reset_sim, preset_sim, clock_sim : std_logic := '0';

begin

	MyComponentsynthcombo1underTest : bufferNbits
	generic map(N =>N)
	port map (
		e1 => e1_sim,
		reset => reset_sim,
		preset => preset_sim,
		clock => clock_sim,
		s1 => s1_sim
	);
    My_Clock_Proc: process
    begin 
        clock_sim <= '0';
        wait for PERIOD/2;
        clock_sim <= '1';
        wait for PERIOD/2;
    end process;

    MyStimulus_Proc2: process
    begin
        for i in 0 to (2**N)-1 loop
            e1_sim <= std_logic_vector(to_unsigned(i,N));
            wait for PERIOD;
        end loop;
        for i in 0 to (2**N)-1 loop
            e1_sim <= std_logic_vector(to_unsigned(i,N));
            wait for PERIOD;
        end loop;
        wait;
    end process;
    My_Reset_Proc: process
    begin
        wait for 234 us;
        reset_sim <= '1';
        wait for 150 us;
        reset_sim <= '0';
        wait;
    end process;
    My_Preset_Proc: process
    begin
        wait for 610 us;
        preset_sim <= '1';
        wait for 150 us;
        preset_sim <= '0';
        wait;
    end process;
end mybufferNbitstestbench_Arch;
