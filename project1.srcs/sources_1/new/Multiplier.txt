library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier is
  generic (N : integer := 32);
  Port (
        A : IN std_logic_vector((N/2) - 1 downto 0); 
        B : IN std_logic_vector((N/2)-1 downto 0);
        Product : OUT std_logic_vector(N-1 downto 0)  
       );
end Multiplier;

architecture Behavioral of Multiplier is

Component FullAdder is
  Port ( 
        A    : IN std_logic;
        B    : IN std_logic;
        Cin  : IN std_logic;
        Sum  : OUT std_logic; 
        Cout : OUT std_logic
       );
end Component;

type and_array is array ((N/2)-1 downto 0) of std_logic_vector((N/2)-1 downto 0);
type sum_array is array ((N/2)-1 downto 0) of std_logic_vector((N/2)-1 downto 0);
type carry_array is array ((N/2)-1 downto 0) of std_logic_vector((N/2)-1 downto 0);

signal and_sig : and_array;
signal sum_sig : sum_array;
signal carry_sig : carry_array;

begin

rows: FOR row IN 0 TO (N/2)-1 generate
    columns: FOR col IN 0 TO (N/2)-1 generate
        ands : and_sig(row)(col) <= A(col) and B(row);

          carry_out : If col = 0 and row = 1 generate
                row1_col0 : FullAdder 
                    PORT MAP ( A    => and_sig(row-1)(col+1),
                               B    => and_sig(row)(col),
                               Cin  => '0',
                               Sum  => sum_sig(row)(col),
                               Cout => carry_sig(row)(col)
                             );
           end generate carry_out;
           row1_center_col : If col > 0 and col < (N/2)-1 and row = 1 generate
           adder_mid : FullAdder 
                    PORT MAP ( A    => and_sig(row-1)(col+1),
                               B    => and_sig(row)(col),
                               Cin  => carry_sig(row)(col-1),
                               Sum  => sum_sig(row)(col),
                               Cout => carry_sig(row)(col)
                              );
             end generate row1_center_col;
             row1_end_col : if col = (N/2)-1 and row = 1 generate   
             adder_end : FullAdder 
                      PORT MAP ( A    => '0',
                                 B    => and_sig(row)(col),
                                 Cin  => carry_sig(row)(col-1),
                                 Sum  => sum_sig(row)(col),
                                 Cout => carry_sig(row)(col)
                                );
              end generate row1_end_col;
              rowN_col : if col = 0 and row > 1 and row < (N/2)-1 generate
              adder_col0_row : FullAdder 
                      PORT MAP ( A    => sum_sig(row-1)(col+1),
                                 B    => and_sig(row)(col),
                                 Cin  => '0',
                                 Sum  => sum_sig(row)(col),
                                 Cout => carry_sig(row)(col)
                                );
               end generate rowN_col;
               rowN_center_colN : if col > 0 and col < (N/2)-1 and row > 1 and row < (N/2)-1 generate
               addercolNrowN : FullAdder 
                      PORT MAP ( A    => sum_sig(row-1)(col+1),
                                 B    => and_sig(row)(col),
                                 Cin  => carry_sig(row)(col-1),
                                 Sum  => sum_sig(row)(col),
                                 Cout => carry_sig(row)(col)
                                );
                end generate rowN_center_colN;
                rowN_colend : if row > 1 and row < (N/2)-1 and col = (N/2)-1 generate
                rowNlastcol : FullAdder 
                      PORT MAP ( A    => carry_sig(row-1)(col),
                                 B    => and_sig(row)(col),
                                 Cin  => carry_sig(row)(col-1),
                                 Sum  => sum_sig(row)(col),
                                 Cout => carry_sig(row)(col)
                               );
                end generate rowN_colend;
                lastrow : if row = (N/2)-1 and col = 0 generate
                lastrowcol0 : FullAdder
                       PORT MAP ( A    => sum_sig(row-1)(col+1),
                                  B    => and_sig(row)(col),
                                  Cin  => '0',
                                  Sum  => sum_sig(row)(col),
                                  Cout => carry_sig(row)(col)
                                );
                 end generate lastrow;
                 lastrowmid : if row = (N/2)-1 and col > 0 and col < (N/2)-1 generate
                 lastrowcolmid : FullAdder
                        PORT MAP ( A    => sum_sig(row-1)(col+1),
                                   B    => and_sig(row)(col),
                                   Cin  => carry_sig(row)(col-1),
                                   Sum  => sum_sig(row)(col),
                                   Cout => carry_sig(row)(col)
                                 );
                  end generate lastrowmid;
                  lastrowlastcol :  if row = (N/2)-1 and col = (N/2)-1 generate
                  lastrowlstcol : FullAdder
                        PORT MAP ( A    => carry_sig(row-1)(col),
                                   B    => and_sig(row)(col),
                                   Cin  => carry_sig(row)(col-1),
                                   Sum  => sum_sig(row)(col),
                                   Cout => carry_sig(row)(col)
                                  );
                   end generate lastrowlastcol;
              
                     sum: If row = 0 and col = 0 generate
                      Product(row) <= and_sig(row)(col);
                   end generate;
                   
                   sum_out: If row > 0 and col = 0 and row < (N/2)-1 generate
                   Product(row) <= sum_sig(row)(col);
                   end generate;
                   
                   sum_out1: If row = (N/2)-1 and col = 0 generate
                   Product(row) <= sum_sig(row)(col);
                   end generate;
                   
                   sum_out2: If row = (N/2)-1 and col > 0 and col < (N/2)-1 generate
                   Product(col+(N/2)-1) <= sum_sig(row)(col);
                   end generate;
                   
                   sum_out3: If row = (N/2)-1 and col = (N/2)-1 generate
                   Product(N-2) <= sum_sig(row)(col);
                   Product(N-1) <= carry_sig(row)(col);
                   end generate;
                   
       end generate columns;
   end generate rows;       
end Behavioral;