library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionFetch is
    port(clk: in std_logic;
         rst: in std_logic;
         Instruction: out std_logic_vector(31 downto 0)
         );
end InstructionFetch;

architecture Behavioral of InstructionFetch is
    signal PC : UNSIGNED(27 downto 0);     
begin 
   
    process(clk,rst) is begin
        if rst = '1' then
            PC <= (others => '0');
        elsif rising_edge(clk) then
            PC <= PC + 4;
        end if;
     end process;
     
    
    Intsruction_Memory0: entity work.InstructionMemory
        generic map ( mem_size=> 1024)
        port map ( clk => clk, Addr => std_logic_vector(PC), Dout => Instruction);
    
end Behavioral;