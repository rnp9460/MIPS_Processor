library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity xorN is
GENERIC (N : INTEGER := 4);
    PORT (
            A : IN STD_LOGIC_VECTOR(N-1 downto 0);
            B : IN STD_LOGIC_VECTOR(N-1 downto 0);
            Y : OUT STD_LOGIC_VECTOR(N-1 downto 0)
         );

end xorN;

architecture Behavioral of xorN is

begin

Y <= A xor B;

end Behavioral;