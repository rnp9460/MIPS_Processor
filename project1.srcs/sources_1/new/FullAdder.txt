library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FullAdder is
  Port ( 
        A    : IN std_logic;
        B    : IN std_logic;
        Cin  : IN std_logic;
        Sum  : OUT std_logic; 
        Cout : OUT std_logic
       );
end FullAdder;

architecture Behavioral of FullAdder is
begin

Sum <= A xor B xor Cin;
Cout <= (A and B) OR (B and Cin) OR (A and Cin);

end Behavioral;

