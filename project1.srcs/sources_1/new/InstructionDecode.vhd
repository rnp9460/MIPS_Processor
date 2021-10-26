library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionDecode is
    port(clk: in std_logic;
         Instruction: in std_logic_vector(31 downto 0);
         RegWriteAddr: in std_logic_vector(4 downto 0);
         RegWriteData: in std_logic_vector(31 downto 0);
         RegWriteEn: in std_logic;
         
         RegWrite: out std_logic;
         MemtoReg: out std_logic;
         MemWrite: out std_logic;
         AluControl: out std_logic_vector(3 downto 0);
         ALUSrc: out std_logic;
         RegDst: out std_logic;
         RD1: out std_logic_vector(31 downto 0);
         RD2: out std_logic_vector(31 downto 0);
         RtDest: out std_logic_vector(4 downto 0);
         RdDest: out std_logic_vector(4 downto 0);
         ImmOut: out std_logic_vector(31 downto 0)
        
         );
end InstructionDecode;

architecture Behavioral of InstructionDecode is

Component RegisterFile is
generic(
		BIT_DEPTH      : integer := 32; --Bit depth of signals
		LOG_PORT_DEPTH : integer := 5 --log_2 of the signal width
	);
	
PORT( 
     Addr1      : IN std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
     Addr2      : IN std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
     Addr3      : IN std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
     wd         : IN std_logic_vector(BIT_DEPTH-1 downto 0);
     clk_n      : IN std_logic;
     we         : IN std_logic;
     RD1        : OUT std_logic_vector(BIT_DEPTH-1 downto 0);
     RD2        : OUT std_logic_vector(BIT_DEPTH-1 downto 0)
    );
end component; 	

Component ControlUnit is
Port ( 
       Opcode     : IN std_logic_vector(5 downto 0);
       Funct      : IN std_logic_vector(5 downto 0);
       RegWrite   : OUT std_logic;
       MemtoReg   : OUT std_logic;
       MemWrite   : OUT std_logic;
       ALUControl : OUT std_logic_vector(3 downto 0);
       ALUSrc     : OUT std_logic;
       RegDst     : OUT std_logic
     );
end Component;
    
begin
    
regfile : RegisterFile
generic map (
             BIT_DEPTH     => 32,
		     LOG_PORT_DEPTH => 5 
		    )
port map    (
              Addr1   => Instruction(25 downto 21),
              Addr2   => Instruction(20 downto 16),
              Addr3   => RegWriteAddr,
              wd      => RegWriteData,
              clk_n   => clk,
              we      => RegWriteEn,
              RD1     => RD1,
              RD2     => RD2
             );
             
           
control_unit : ControlUnit

port map (
          Opcode    => Instruction(31 downto 26),              
          Funct     => Instruction(5 downto 0),  
          RegWrite  => RegWrite,   
          MemtoReg  => MemtoReg,
          MemWrite  => MemWrite,
          ALUControl=> ALUControl,
          ALUSrc    => ALUSrc,
          RegDst    => RegDst
         );
         
RtDest <= Instruction(20 downto 16);
RdDest <= Instruction(15 downto 11);

ImmOut(15 downto 0) <=  Instruction(15 downto 0);
ImmOut(31 downto 16) <= (others => Instruction(15));

end Behavioral;