----------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------






library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_core is
    generic(M: integer := 8;   --bits per block
            N: integer := 4;   --numbers of blocks
            Num: integer := 32);
    port(A, B: in std_logic_vector(Num-1 downto 0);
         Y: out std_logic_vector(Num-1 downto 0);
         --segnali controllo:
         funct7_6, opcode_5: in std_logic;
         funct3: in std_logic_vector(2 downto 0);
         Cout_flag: out std_logic
         );
end ALU_core;


architecture ALU_c of ALU_core is


component core_Add_Sub is
    port(A, B: in std_logic_vector(Num-1 downto 0);
         Selection: in std_logic; --this bit selects the adder when is = '0' and subtractor when is = '1'
         Sum: out std_logic_vector(Num-1 downto 0);
         Cout: out std_logic);
end component;

signal output_and, output_or, output_xor, output_not, output_add_sub: std_logic_vector(Num-1 downto 0);
signal Selection_A_S: std_logic; --poi vediamo come gestire il carry se viene gestito ed il selection.

--signals for decoder:
--signal funct7_6, opcode_5: std_logic;
--signal funct3: std_logic_vector(2 downto 0); --attenction to the index
signal out_decode: std_logic_vector(2 downto 0); --6 istructions 2^3 comb 3 bit through the mux

begin




--sintassi operazioni
output_and <= A and B;
output_or <= A or B;
output_not <= not A;
output_xor <= A xor B;
module_A_S: core_Add_Sub port map(A => A, B => B, Sum => output_add_sub, Cout => Cout_flag, Selection => Selection_A_S);

Selection_A_S <= funct7_6; --funct7[bit6].

--end of operations syntax.


--decoder syntax
--here I describe the bits needed: the funct7_6 bit, which is the sixth of funct7, the funct3_n with n from 3 to 1, and opcode_5, which is the fifth bit.
--respectively, these bits:
--funct7[bit6]-funct3[bit3-2-1]-opcode[bit5] => decoder output bit: out_decoder

--ADD 0-000-1 => 000
--SUB 1-000-1 => 001
--AND 0-111-1 => 010    
--OR 0-110-1 =>  011
--XOR 0-100-1 => 100
--NOT 1-111-1 => 101

--note the opcode is important in its entirety, but here we can avoid checking everything because the ALU can also function when it's not
--being used. The total opcode that addresses the ALU and carries the signals is decided by the Control Unit (CU).



--start

out_decode <= "000" when funct7_6 = '0' and funct3 = "000" and opcode_5 = '1' else
              "001" when funct7_6 = '1' and funct3 = "000" and opcode_5 = '1' else
              "010" when funct7_6 = '0' and funct3 = "111" and opcode_5 = '1' else
              "011" when funct7_6 = '0' and funct3 = "110" and opcode_5 = '1' else
              "100" when funct7_6 = '0' and funct3 = "100" and opcode_5 = '1' else
              "101" when funct7_6 = '1' and funct3 = "111" and opcode_5 = '1' else
              ---
              "110"; --the last one I set to 110, and then in the mux, it either does nothing or can do anything since the CU controls everything.


--fine sintassi decoder


--syntax mux

Y <= output_add_sub when out_decode = "000" else
     output_add_sub when out_decode = "001" else
     output_and when out_decode = "010" else
     output_or when out_decode = "011" else
     output_xor when out_decode = "100" else
     output_not when out_decode = "111" else
     output_not;                  --it won't be used anyway because the CU will control other parts.

                               --the inputs are also needed, otherwise it won't change with the variation of the outputs and would function as a buffer.
--process(A, B, out_decode)  --Selection_A_S, funct7_6, funct3, opcode_5
--begin

--case out_decode is                 --problem with process delay.
--    when "000" => Y <= output_add_sub;
--    when "001" => Y <= output_add_sub;
--    when "010" => Y <= output_and;
--    when "011" => Y <= output_or;
--    when "100" => Y <= output_xor;
--    when "101" => Y <= output_not;
--    when others => Y <= output_not;  --it won't be used anyway because the CU will control other parts.
--end case;
--
--end process;


--end syntax mux

end ALU_c;






