
-----------------------------------------------------------------------------------------
-------------------------------------IMPORTANT-------------------------------------------
--
--
--Cout is a very important signal, it indicates whether the result of the subtraction is correct;
--when Cout is equal to '1' means the subtraction is right,whereas when Cout is equal
--to '0' means the second number is larger than the second one. If this adder/subtractor
--is going to be implemented in a ALU block, it is necessary to manage Cout properly.
--When Selection = '0' Cout is the Carry of the sum, when Selection = '1' Cout describes
--the right result of the subtraction as it is said before.
--To add the Cout result for example a Flag Register is enough introducing a MUX, when 
--Selection = '0' Cout can go through the Carry bit of the FR whereas if it is equal to '1'
--it can go through the overflow pin.
--
--the subtractor also works as signed subtractor, you just need to pay attenction to the most
--significant bit of the input and output values.
--
--
-----------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity core_Add_Sub is
    generic(M: integer := 8;   --bits per block
            N: integer := 4;   --numbers of blocks
            Num: integer := 32);
    port(A, B: in std_logic_vector(Num-1 downto 0);
         Selection: in std_logic; --this bit selects the adder when is = '0' and subtractor when is = '1'
         Sum: out std_logic_vector(Num-1 downto 0);
         Cout: out std_logic);
end core_Add_Sub;

architecture Bh of core_Add_Sub is

component core is
    port(A, B: in std_logic_vector(Num-1 downto 0);
         Cin: in std_logic;
         Sum: out std_logic_vector(Num-1 downto 0);
         Cout: out std_logic);
end component;

signal B_right: std_logic_vector(Num-1 downto 0);
signal Cin_right: std_logic;
begin

process (B, Selection)
begin
for i in 0 to Num-1 loop

B_right(i) <= Selection xor B(i); --for two complement

end loop;
end process;

Cin_right <= Selection;

subtractor_adder: core port map(A => A, B => B_right, Cin => Cin_right, Sum => Sum, Cout => Cout);

end Bh;
