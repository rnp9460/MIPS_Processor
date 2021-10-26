library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity  alu4 is
GENERIC (N : INTEGER  := 32); 
PORT (in1           : IN  std_logic_vector(N-1  downto  0);
       in2            : IN  std_logic_vector(N-1  downto  0);
       control           : IN std_logic_vector(3 downto 0);
       out1            : OUT  std_logic_vector(N-1  downto  0));
end alu4;
 
architecture  structural  of alu4 is
   
   Component andN is
            GENERIC (N : INTEGER := 4);
       PORT(
           A : IN std_logic_vector(N-1 downto 0);
           B : IN std_logic_vector(N-1 downto 0);
           Y : OUT std_logic_vector(N-1 downto 0)
       );
end  Component;

   Component orN is
            GENERIC (N : INTEGER := 4);
       PORT(
           A : IN std_logic_vector(N-1 downto 0);
           B : IN std_logic_vector(N-1 downto 0);
           Y : OUT std_logic_vector(N-1 downto 0)
       );
end  Component;

   Component xorN is
            GENERIC (N : INTEGER := 4);
       PORT(
           A : IN std_logic_vector(N-1 downto 0);
           B : IN std_logic_vector(N-1 downto 0);
           Y : OUT std_logic_vector(N-1 downto 0)
       );
end  Component;
   
   Component sllN is
      GENERIC (N : INTEGER  := 4);        
      PORT (A           : IN  std_logic_vector(N-1  downto  0);
           SHIFT_AMT    : IN  std_logic_vector(N-1   downto  0);
            Y           : OUT  std_logic_vector(N-1  downto  0)
           );
end  Component;
    
   Component srlN is
       GENERIC (N : INTEGER  := 4);        
       PORT (A           : IN  std_logic_vector(N-1  downto  0);
            SHIFT_AMT    : IN  std_logic_vector(N-1  downto  0);
             Y           : OUT  std_logic_vector(N-1  downto  0)
            );
end  Component;
     
    Component sraN is
       GENERIC (N : INTEGER  := 4);          
        PORT (A           : IN  std_logic_vector(N-1  downto  0);
             SHIFT_AMT    : IN  std_logic_vector(N-1  downto  0);
              Y           : OUT  std_logic_vector(N-1  downto  0)
             );
end  Component;

Component RippleCarryFullAdder is
  generic( N : integer:= 32);
  Port ( 
         A   : IN std_logic_vector(N-1 downto 0);
         B   : IN std_logic_vector(N-1 downto 0);
         OP  : IN std_logic;
         Sum : OUT std_logic_vector(N-1 downto 0)   
  );
end Component;

Component Multiplier is
  generic (N : integer :=32);
  Port (
        A : IN std_logic_vector((N/2) - 1 downto 0); 
        B : IN std_logic_vector((N/2)-1 downto 0);
        Product : OUT std_logic_vector(N-1 downto 0)  
       );
end Component;

signal not_result : std_logic_vector(N-1 downto 0);
signal sll_result : std_logic_vector(N-1 downto 0);
signal srl_result : std_logic_vector(N-1 downto 0);
signal sra_result : std_logic_vector(N-1 downto 0);
signal and_result : std_logic_vector(N-1 downto 0);
signal or_result  : std_logic_vector(N-1 downto 0);
signal xor_result : std_logic_vector(N-1 downto 0);
signal full_add_result : std_logic_vector(N-1 downto 0);
signal Multiplier_result : std_logic_vector(N-1 downto 0);

begin
    
 sll_comp: sllN
        generic map ( N => 32)
        port map ( A => in2 ,SHIFT_AMT => in1(N-1 downto 0), Y => sll_result );
        
 srl_comp: srlN
        generic map ( N => 32)
        port map ( A => in2, SHIFT_AMT => in1(N-1 downto 0), Y => srl_result );
               
 sra_comp: sraN
        generic map ( N => 32)
        port map ( A => in2, SHIFT_AMT => in1(N-1 downto 0), Y => sra_result );
                      
 and_comp: andN
        generic map ( N => 32)
        port map ( A => in1, B => in2, Y => and_result );
        
 or_comp: orN
        generic map ( N => 32)
        port map ( A => in1, B => in2, Y => or_result );
               
 xor_comp: xorN
        generic map ( N => 32)
        port map ( A => in1, B => in2, Y => xor_result );
                      
addorsub : RippleCarryFullAdder 
       generic map ( N => 32)
       port map ( A => in1, B => in2, OP => Control(0), Sum =>  full_add_result);

multiply : Multiplier
       generic map (N => 32)
       port map (A => in1((N/2) - 1 downto 0),B=> in2((N/2)-1 downto 0),Product=> Multiplier_result);
        
       out1 <= or_result    when control = "1000" else 
            and_result      when control = "1010" else
            xor_result      when control = "1011" else
            sll_result      when control = "1100" else
            srl_result      when control = "1101" else
            sra_result      when control = "1110" else
            full_add_result when control = "0100" else -- Add
            full_add_result when control = "0101" else --Sub
            Multiplier_result;
            
end structural;