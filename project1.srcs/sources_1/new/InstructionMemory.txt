library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity InstructionMemory is
    GENERIC (mem_size : INTEGER := 1024); 
    port(clk: in std_logic;
        Addr: in std_logic_vector(27 downto 0);
         Dout: out std_logic_vector(31 downto 0)
         );
end InstructionMemory;


architecture Behavioral of InstructionMemory is
    type mem_type is array(0 to mem_size-1) of std_logic_vector(7 downto 0);
    signal mem: mem_type :=(
--                          x"20",x"09",x"00",x"10", --ADDI $t1 $zero 0x0010 --0010
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"20",x"08",x"00",x"20", --ADDI $t0 $zero 0x0020 --0020
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"01",x"28",x"50",x"20", --ADD $t2 $t1 $t0 --0030
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"01",x"09",x"60",x"22", --SUB $t4 $t0 $t1 --0010
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"01",x"28",x"50",x"19", --MULTU $t2 $t1 $t0 --0200                          
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"20",x"08",x"00",x"04", --ADDI $t0 $zero 0x0004 --0004
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"01",x"09",x"50",x"00", --sll $t2 $t1 $t0 --0100
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"01",x"09",x"50",x"03", --sra $t2 $t1 $t0 --0001
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"20",x"09",x"00",x"ff", --ADDI $t1 $zero 0x00FF --00ff
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"01",x"09",x"50",x"02", --srl $t2 $t1 $t0 -- 000f
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"20",x"09",x"01",x"01", --ADDI $t1 $zero 0x0101 --0101
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"31",x"2A",x"10",x"10", --andi $t2 $t1 0x1010 --0000
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"35",x"4A",x"01",x"11", --ori $t2 $t2 0x0111 -0111
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"AC",x"0A",x"00",x"0C", --SW $t2 $0 0x000C --store 0111 in mipsmem at C
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"20",x"09",x"10",x"00", --ADDI $t1 $zero 0x1000 --1000
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
--                          x"39",x"2A",x"02",x"22", --xori $t2 $t1 0x0222 --1222
--                          x"00",x"00",x"00",x"00", --NOOP --Break
--                          x"00",x"00",x"00",x"00", --NOOP --Break
                          
                          

                            x"20",x"01",x"00",x"01", --ADDI R1,R0, 1 --1
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AC",x"01",x"00",x"00", --SW R1, imm(R0)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP                          
                            
                            x"00",x"01",x"10",x"20", --ADD R2,R1,R0 -- 1
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AC",x"22",x"00",x"00", --SW R2, imm(R1)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP

                            x"00",x"22",x"18",x"20", --ADD R3,R2,R1 -- 2
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                           
                            x"AC",x"43",x"00",x"00", --SW R3, imm(R2)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"00",x"43",x"20",x"20", --ADD R4,R3,R2 -- 3
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AC",x"64",x"00",x"00", --SW R4, imm(R3)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP   
                            
                            x"00",x"64",x"28",x"20", --ADD R5,R4,R3 -- 5
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AC",x"85",x"00",x"00", --SW R5, imm(R4)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP                           

                            x"00",x"85",x"30",x"20", --ADD R6,R5,R4 -- 8
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AC",x"A6",x"00",x"00", --SW R6, imm(R5)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"00",x"A6",x"38",x"20", --ADD R7,R6,R5 -- 13
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                           
                            x"AC",x"C7",x"00",x"00", --SW R7, imm(R6)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP                            

                            x"00",x"C7",x"40",x"20", --ADD R8,R7,R6 -- 21
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AC",x"E8",x"00",x"00", --SW R8, imm(R7)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP

                            x"00",x"E8",x"48",x"20", --ADD R9,R8,R7
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AD",x"09",x"00",x"00", --SW R9, imm(R8)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP

                            x"01",x"09",x"50",x"20", --ADD R10,R9,R8
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            
                            x"AD",x"2A",x"00",x"00", --SW R10, imm(R9)
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP
                            x"00",x"00",x"00",x"00", --NOOP   
                          

                            Others=>(others=>'0'));

begin
    process(addr) is begin
        if (to_integer(unsigned(STD_LOGIC_VECTOR'(addr(27 downto 0)))) < 1024)
        then
        Dout <= mem(to_integer(unsigned(STD_LOGIC_VECTOR'(addr(27 downto 2) & "00")))) &
            mem(to_integer(unsigned(STD_LOGIC_VECTOR'(ADDR(27 downto 2) & "01")))) &
            mem(to_integer(unsigned(STD_LOGIC_VECTOR'(ADDR(27 downto 2) & "10"))))  &
            mem(to_integer(unsigned(STD_LOGIC_VECTOR'(ADDR(27 downto 2) & "11"))));
            
        else
        Dout <= (others => '0');    
        end if;
        
        end process;
        
end Behavioral;