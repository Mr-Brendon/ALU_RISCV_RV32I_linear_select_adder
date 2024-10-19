This is an implementation of an ALU with a linear select adder made for RISCV CPU, it work with RV32I instruction set.
It works with some bits of the instruction word:
it uses funct7[bit6]-funct3[bit3-2-1]-opcode[bit5] for the following instructions:
ADD 0-000-1
SUB 1-000-1
AND 0-111-1    
OR 0-110-1
XOR 0-100-1
NOT 1-111-1
