LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY top IS
    PORT (
        clk : IN STD_ULOGIC;
        reset : IN STD_ULOGIC;
        SR_IN_L : IN STD_ULOGIC;
        SR_IN_R : IN STD_ULOGIC;
        A_IN : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
        B_IN : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);

        SEL_FCT : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
        SEL_ROUTE : IN STD_ULOGIC_VECTOR(3 DOWNTO 0);
        SEL_OUT : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);

        RES_OUT : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0);
        SR_OUT_L : OUT STD_ULOGIC;
        SR_OUT_R : OUT STD_ULOGIC
    );
END top;

ARCHITECTURE top_arch OF top IS
    COMPONENT selroute IS
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
    END COMPONENT;

    SIGNAL MEM_CACHE1 : STD_ULOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL MEM_CACHE2 : STD_ULOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Buffer_A : STD_ULOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Buffer_B : STD_ULOGIC_VECTOR(3 DOWNTO 0);

    COMPONENT selout IS
        PORT (
            SEL_OUT : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
            S : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            MEM_CACHE1 : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            MEM_CACHE2 : IN STD_ULOGIC_VECTOR(7 DOWNTO 0);
            resOUT : OUT STD_ULOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ual IS
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
    END COMPONENT;

    COMPONENT bufferNbits IS
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
    END COMPONENT;
    SIGNAL Buffer_A_OUT : STD_ULOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Buffer_B_OUT : STD_ULOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL S_out : STD_ULOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    selroute1 : selroute PORT MAP(
        A => A_IN,
        B => B_IN,
        SEL_ROUTE => SEL_ROUTE,
        RES_IN => S_out,
        MEM_CACHE1_IN => MEM_CACHE1,
        MEM_CACHE2_IN => MEM_CACHE2,

        MEM_CACHE1_OUT => MEM_CACHE1,
        MEM_CACHE2_OUT => MEM_CACHE2,
        Buffer_A_IN => Buffer_A,
        Buffer_B_IN => Buffer_B
    );

    bufferA : bufferNbits GENERIC MAP(
        N => 4) PORT MAP (
        e1 => Buffer_A,
        reset => reset,
        preset => '0',
        clock => clk,
        s1 => Buffer_A_OUT
    );

    bufferB : bufferNbits GENERIC MAP(
        N => 4) PORT MAP (
        e1 => Buffer_B,
        reset => reset,
        preset => '0',
        clock => clk,
        s1 => Buffer_B_OUT
    );

    ual1 : ual PORT MAP(
        A_in => Buffer_A_OUT,
        B_in => Buffer_B_OUT,
        SR_in_L => SR_IN_L,
        SR_in_R => SR_IN_R,
        SEL_FCT => SEL_FCT,
        SR_out_L => SR_OUT_L,
        SR_out_R => SR_OUT_R,
        S_out => S_out
    );

    selout1 : selout PORT MAP(
        SEL_OUT => SEL_OUT,
        S => S_out,
        MEM_CACHE1 => MEM_CACHE1,
        MEM_CACHE2 => MEM_CACHE2,
        resOUT => RES_OUT
    );

END top_arch;