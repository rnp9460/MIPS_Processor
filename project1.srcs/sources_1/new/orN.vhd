library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity orN is 
    Generic(N: Integer:= 32);
    port(
        A,B : in std_logic_vector(N-1 downto 0);
        Y   : out std_logic_vector(N-1 downto 0));
end entity;
    
architecture arch of orN is 
    begin 
        Y <= A or B;
end arch;


        