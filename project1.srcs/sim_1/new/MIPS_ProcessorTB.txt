library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MIPS_ProcessorTB is
end;

architecture bench of MIPS_ProcessorTB is

  component MIPS_Processor
  Port (
         clk             : IN std_logic;
         rst             : IN std_logic;
         ALUResult       : OUT std_logic_vector(31 downto 0)
        );
  end component;

  signal clk: std_logic := '0';
  signal rst: std_logic := '1';
  signal ALUResult: std_logic_vector(31 downto 0) ;

  constant period: time := 10 ns;
  

begin

  uut: MIPS_Processor
                         port map ( clk             => clk,
                                    rst             => rst,
                                    ALUResult       => ALUResult );

  stimulus: process
  begin
       wait for period;
       WAIT until clk = '1';
       rst <= '0';
       wait until clk = '0';
       rst <= '0';
       for i in 0 to 30 loop
          wait until clk = '1';
       end loop;

    wait for 2*period;
    wait;
  end process;

  clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 

end;