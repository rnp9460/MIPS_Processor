----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2021 10:24:50 AM
-- Design Name: 
-- Module Name: WriteBackStage - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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