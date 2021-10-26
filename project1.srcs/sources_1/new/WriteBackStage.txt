library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WriteBackStage is
generic ( RAM_WIDTH : integer := 32);
  Port (
       RegWrite : IN std_logic;
       MemtoReg : IN std_logic;
       AluResult : IN std_logic_vector(RAM_WIDTH-1 downto 0);
       ReadData : IN std_logic_vector(RAM_WIDTH-1 downto 0);
       WriteReg : IN std_logic_vector(4 downto 0);
       RegWriteOut : OUT std_logic;
       WriteRegOut : OUT std_logic_vector(4 downto 0);
       Result : OUT std_logic_vector(RAM_WIDTH-1 downto 0)
  );
end WriteBackStage;

architecture Behavioral of WriteBackStage is

begin

process (MemtoReg,AluResult,ReadData,RegWrite,WriteReg) is
begin
  case MemtoReg is 
    when '1' =>
      Result <= ReadData;
    when others =>
      Result <= AluResult;
  end case;
end process;

WriteRegOut <= WriteReg;
RegWriteOut <= RegWrite;

end Behavioral;