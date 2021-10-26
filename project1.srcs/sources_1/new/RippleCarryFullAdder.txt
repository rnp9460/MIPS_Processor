library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RippleCarryFullAdder is
  generic( N : integer:= 32);
  Port ( 
         A   : IN std_logic_vector(N-1 downto 0);
         B   : IN std_logic_vector(N-1 downto 0);
         OP  : IN std_logic;
         Sum : OUT std_logic_vector(N-1 downto 0)   
  );
end RippleCarryFullAdder;

architecture Behavioral of RippleCarryFullAdder is

Component FullAdder is
  Port ( 
        A    : IN std_logic;
        B    : IN std_logic;
        Cin  : IN std_logic;
        Sum  : OUT std_logic; 
        Cout : OUT std_logic
       );
end Component;

signal carry_in : std_logic_vector(N-1 downto 0);
signal Add_or_Sub : std_logic_vector(N-1 downto 0);

begin

AddSub  : FOR I IN 0 TO N-1 GENERATE
        Add_or_Sub(I) <= B(I) XOR OP;
end generate AddSub;

full_add0 : FullAdder 
PORT MAP( A   => A(0),
          B   => Add_or_Sub(0),
          Cin => OP,
          Sum => Sum(0),
          Cout => carry_in(0)
          );
                        
gen_add  : FOR I IN 1 TO N-1 GENERATE
    full_add : FullAdder 
        PORT MAP( A    => A(I),
                  B    => Add_or_Sub(I),
                  Cin  => carry_in(I-1),
                  Sum  => Sum(I),
                  Cout => carry_in(I)
                  );
end GENERATE gen_add;
     


end Behavioral;