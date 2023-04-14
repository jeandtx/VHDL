LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

--Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
ENTITY mybufferNbitstestbench IS

END mybufferNbitstestbench;

ARCHITECTURE mybufferNbitstestbench_Arch OF mybufferNbitstestbench IS
    COMPONENT bufferNbits IS
        GENERIC (N : INTEGER);
        PORT (
            e1 : IN STD_ULOGIC_VECTOR (N - 1 DOWNTO 0);
            reset : IN STD_ULOGIC;
            preset : IN STD_ULOGIC;
            clock : IN STD_ULOGIC;
            s1 : OUT STD_ULOGIC_VECTOR (N - 1 DOWNTO 0)
        );
    END COMPONENT;

    CONSTANT N : INTEGER := 3;

    CONSTANT PERIOD : TIME := 50 us;

    SIGNAL e1_sim : STD_ULOGIC_VECTOR(N - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s1_sim_unused : STD_ULOGIC_VECTOR(N - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL reset_sim, preset_sim, clock_sim : STD_ULOGIC := '0';

BEGIN

    MyComponentsynthcombo1underTest : bufferNbits
    GENERIC MAP(N => N)
    PORT MAP(
        e1 => e1_sim,
        reset => reset_sim,
        preset => preset_sim,
        clock => clock_sim,
        s1 => s1_sim_unused
    );
    My_Clock_Proc : PROCESS
    BEGIN
        clock_sim <= '0';
        WAIT FOR PERIOD/2;
        clock_sim <= '1';
        WAIT FOR PERIOD/2;
    END PROCESS;

    MyStimulus_Proc2 : PROCESS
    BEGIN
        FOR i IN 0 TO (2 ** N) - 1 LOOP
            e1_sim <= STD_ULOGIC_VECTOR(to_unsigned(i, N));
            WAIT FOR PERIOD;
        END LOOP;
        FOR i IN 0 TO (2 ** N) - 1 LOOP
            e1_sim <= STD_ULOGIC_VECTOR(to_unsigned(i, N));
            WAIT FOR PERIOD;
        END LOOP;
        WAIT;
    END PROCESS;
    My_Reset_Proc : PROCESS
    BEGIN
        WAIT FOR 234 us;
        reset_sim <= '1';
        WAIT FOR 150 us;
        reset_sim <= '0';
        WAIT;
    END PROCESS;
    My_Preset_Proc : PROCESS
    BEGIN
        WAIT FOR 610 us;
        preset_sim <= '1';
        WAIT FOR 150 us;
        preset_sim <= '0';
        WAIT;
    END PROCESS;
END mybufferNbitstestbench_Arch;