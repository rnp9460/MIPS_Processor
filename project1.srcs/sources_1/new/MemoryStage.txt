library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemoryStage is
generic ( RAM_WIDTH : integer := 32);
  Port ( 
       clk      : IN std_logic;
       RegWrite : IN std_logic;
       MemtoReg : IN std_logic;
       WriteReg : IN std_logic_vector(4 downto 0);
       MemWrite : IN std_logic;
       AluResult : IN std_logic_vector(RAM_WIDTH-1 downto 0);
       WriteData : IN std_logic_vector(RAM_WIDTH-1 downto 0);
       RegWriteOut : OUT std_logic;
       MemtoRegOut : OUT std_logic;
       WriteRegOut : OUT std_logic_vector(4 downto 0);
       MemOut : OUT std_logic_vector(RAM_WIDTH-1 downto 0);
       AluResultOut : OUT std_logic_vector(RAM_WIDTH-1 downto 0)

  );
end MemoryStage;

architecture Behavioral of MemoryStage is

Component DataMemory is
generic ( RAM_WIDTH : integer := 32;
          ADDR_SPACE : integer := 10);
 port(
      clk  : IN std_logic;
      w_en   : IN std_logic;
	  addr : IN std_logic_vector(ADDR_SPACE-1 downto 0);
	  d_in : IN std_logic_vector(RAM_WIDTH-1 downto 0);
	  d_out : OUT std_logic_vector(RAM_WIDTH-1 downto 0)
	  );
end component;
begin

mem : DataMemory 
generic map (RAM_WIDTH => 32,
          ADDR_SPACE => 10)
Port map (      
          clk       => clk,
          w_en      => MemWrite,
	      addr      => ALUResult(9 downto 0),
	      d_in      => WriteData,
	      d_out     => MemOut
          );


              
RegWriteOut <= RegWrite;
MemtoRegOut <= MemtoReg;
WriteRegOut <= WriteReg;
AluResultOut <= AluResult;

end Behavioral;