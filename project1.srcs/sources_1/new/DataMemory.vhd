library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
generic ( RAM_WIDTH : integer := 32;
          ADDR_SPACE : integer := 10);
port(
      clk       : IN std_logic;
      w_en      : IN std_logic;
	  addr      : IN std_logic_vector(ADDR_SPACE-1 downto 0);
	  d_in      : IN std_logic_vector(RAM_WIDTH-1 downto 0);
	  d_out     : OUT std_logic_vector(RAM_WIDTH-1 downto 0)
	  );
end entity;

architecture Behavioral of DataMemory is

type ram_array is array ((2** ADDR_SPACE)-1 downto 0) of std_logic_vector(RAM_WIDTH-1 downto 0);
signal mips_mem : ram_array := (others => (others => '0'));
begin

write_to_mem:process (clk) is
begin
if (rising_edge(clk)) then
  if (w_en = '1') then
    mips_mem(to_integer(unsigned(addr))) <= d_in;
  end if;
end if;
end process;

d_out <= mips_mem(to_integer(unsigned(addr)));

end Behavioral;  