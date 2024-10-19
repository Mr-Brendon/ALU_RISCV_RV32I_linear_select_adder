This is an implementation of an ALU with a linear select adder made for RISCV CPU, with RV32I instruction set.
It works with some bits of the instruction word:

Typical Instruction Word for arithmetic operation on RV32I instruction set:
![image](https://github.com/user-attachments/assets/2e8d9b6b-9d0b-4267-9622-c56d9736e1c8)


it uses funct7[bit6]-funct3[bit3-2-1]-opcode[bit5] for the following instructions:

ADD 0-000-1

SUB 1-000-1

AND 0-111-1    

OR 0-110-1

XOR 0-100-1

NOT 1-111-1
