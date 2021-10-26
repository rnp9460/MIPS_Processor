library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
    generic( N: INTEGER := 4);
    Port ( A   : in STD_LOGIC_VECTOR (N-1 downto 0);
           B   : in STD_LOGIC_VECTOR (N-1 downto 0);
           Sel : in STD_LOGIC;
           Y   : out STD_LOGIC_VECTOR (N-1 downto 0));
end Mux;

architecture Behavioral of Mux is

begin

process(A,B,Sel) is
begin

Case Sel is
    when '0' => Y <= A;
    when '1' => Y <= B;
    when others => Y <= (others => '0');
end case;
end process;
end Behavioral;
