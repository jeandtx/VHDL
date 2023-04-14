LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY bufferNbits IS
	GENERIC (
		N : INTEGER := 4
	);
	PORT (
		e1 : IN STD_ULOGIC_VECTOR (N - 1 DOWNTO 0);
		reset : IN STD_ULOGIC;
		preset : IN STD_ULOGIC;
		clock : IN STD_ULOGIC;
		s1 : OUT STD_ULOGIC_VECTOR (N - 1 DOWNTO 0)
	);
END bufferNbits;

ARCHITECTURE bufferNbits_Arch OF bufferNbits IS

BEGIN
	PROCESS (reset, clock)
	BEGIN
		IF (reset = '1') THEN
			s1 <= (OTHERS => '0');
		ELSIF (rising_edge(clock)) THEN
			IF (preset = '1') THEN
				s1 <= (OTHERS => '1');
			ELSE
				s1 <= e1;
			END IF;
		END IF;
	END PROCESS;
END bufferNbits_Arch;