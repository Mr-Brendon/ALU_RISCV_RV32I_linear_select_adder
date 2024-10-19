


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench is
    generic(M: integer := 8;   --bits per block
            N: integer := 4;   --numbers of blocks
            Num: integer := 32);
end testbench;

architecture test of testbench is


component ALU_core is
    port(A, B: in std_logic_vector(Num-1 downto 0);
         Y: out std_logic_vector(Num-1 downto 0);
         --segnali controllo:
         funct7_6, opcode_5: in std_logic;
         funct3: in std_logic_vector(2 downto 0);
         Cout_flag: out std_logic
         );
end component;

signal A, B, Y: std_logic_vector(Num-1 downto 0);
signal funct7_6, opcode_5, Cout_flag: std_logic;
signal funct3: std_logic_vector(2 downto 0);

begin


sim: ALU_core port map(A => A, B => B , Y => Y , funct7_6 => funct7_6, opcode_5 => opcode_5, funct3 => funct3, Cout_flag => Cout_flag);



--funct7[bit6]-funct3[bit3-2-1]-opcode[bit5] => decoder output bit: out_decoder

--ADD 0-000-1 => 000
--SUB 1-000-1 => 001
--AND 0-111-1 => 010    
--OR 0-110-1 =>  011
--XOR 0-100-1 => 100
--NOT 1-111-1 => 101



process
begin

A <= (others => '0');                      --not
B <= (others => '0');
funct7_6 <= '1';
opcode_5 <= '1';
funct3 <= "110";
wait for 1 ns;


A <= "00000000000000100010011010100100";    --or
B <= "00000000000000100010011010100100";
funct7_6 <= '0';
opcode_5 <= '1';
funct3 <= "110";
wait for 1 ns;

A <= (others => '0');                       --or
B <= (others => '0');
funct7_6 <= '0';
opcode_5 <= '1';
funct3 <= "110";
wait for 1 ns;

A <= "00000000000000100010011010100100";    --add
B <= "00000000000000100010011010100100";
funct7_6 <= '0';
opcode_5 <= '1';
funct3 <= "000";
wait for 1 ns;


A <= "00000000000000100010011010100100";    --or
B <= "11000000000000110010011011101100";
funct7_6 <= '0';
opcode_5 <= '1';
funct3 <= "110";
wait for 1 ns;

A <= "00000000000000100010011010100100";    --sub
B <= "01000000100000110010011111111111";
funct7_6 <= '1';
opcode_5 <= '1';
funct3 <= "000";
wait;
std.env.stop;


end process;




end test;
