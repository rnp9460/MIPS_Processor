library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registerFile is
    GENERIC (BIT_DEPTH : INTEGER := 8; 
            LOG_PORT_DEPTH : INTEGER := 3);
    PORT (
            clk_n  : IN std_logic;
            we   : IN std_logic;
            Addr1 : IN std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
            Addr2 : IN std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
            Addr3 : IN std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
            wd : IN std_logic_vector(BIT_DEPTH-1 downto 0);
            RD1   : OUT std_logic_vector(BIT_DEPTH-1 downto 0);
            RD2   : OUT std_logic_vector(BIT_DEPTH-1 downto 0)
        );
end registerFile;

architecture Behavioral of registerFile is
    --array 8 x 8 for lab 2
    type mem_data_type is array(BIT_DEPTH-1 downto 0) of std_logic_vector(BIT_DEPTH-1 downto 0);
    Signal mem_data: mem_data_type := (others=>(others=>'0'));
  
begin
    mem_process: process(clk_n) is begin
        if falling_edge(clk_n) then
            if we = '1' and TO_INTEGER(unsigned(Addr3))/= 0 then
                mem_data (TO_INTEGER(unsigned(Addr3))) <= wd;
            end if;
        end if;
    end process;
    
    Rd1 <= mem_data(TO_INTEGER(unsigned(Addr1)));
    Rd2 <= mem_data(TO_INTEGER(unsigned(Addr2)));
    

    
            
end Behavioral;
