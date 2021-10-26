library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity andN is 
    Generic(N: Integer:= 32);
    port(
        A,B : in std_logic_vector(N-1 downto 0);
        Y   : out std_logic_vector(N-1 downto 0));
end entity;
    
architecture arch of andN is 
    begin 
        Y <= A and B;
end arch;


        