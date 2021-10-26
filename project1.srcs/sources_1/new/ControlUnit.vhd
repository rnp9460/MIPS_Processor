library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is
    port(Opcode: in std_logic_vector(5 downto 0);
         Funct: in std_logic_vector(5 downto 0);        
         RegWrite: out std_logic;
         MemtoReg: out std_logic;
         MemWrite: out std_logic;
         AluControl: out std_logic_vector(3 downto 0);
         ALUSrc: out std_logic;
         RegDst: out std_logic
         );
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
        RegWriteProc: process(Opcode, Funct) begin
        Case Opcode is
            when "101011" => RegWrite <= '0';
            when others   => RegWrite <= '1'; 
        end case;
        end process;
     
        MemtoRegProc: process(Opcode, Funct) begin
        Case Opcode is
            when "100011" => MemtoReg   <= '1'; --LW
            when others => MemToReg <= '0';
        end case;
        end process;
        
        MemWriteProc: process(Opcode, Funct) begin
        Case Opcode is
            when "101011" => MemWrite <= '1'; --SW
            when others   => MemWrite <= '0';
        end case;
        end process;
     
     
        AluControlProc: process(Opcode,Funct) begin
            if Opcode = "000000" then
                Case funct is
                    when "100000" =>  AluControl <= "0100"; --ADD
                    when "100100" =>  AluControl <= "1010";  --AND
                    when "011001" =>  AluControl <= "0110";  --MULTU
                    when "100101" =>  AluControl <= "1000";  --OR
                    when "000000" =>  AluControl <= "1100";  --SLL
                    when "000011" =>  AluControl <= "1110";  --SRA
                    when "000010" =>  AluControl <= "1101";  --SRL
                    when "100010" =>  AluControl <= "0101";  --SUB
                    when "100110" =>  AluControl <= "1011";  --XOR
                    when others => AluControl <= "0000";
                end case;              
            else
                Case Opcode is
                    when "001000" =>  AluControl <= "0100"; --ADDI
                    when "001100" =>  AluControl <= "1010";  --ANDI
                    when "001101" =>  AluControl <= "1000";  --ORI
                    when "001110" =>  AluControl <= "1011";  --XORi
                    when "101011" =>  AluControl <= "0100";  --SW
                    when "100011" =>  AluControl <= "0100";  --LW
                    when others => AluControl <= "0000";
                end case;
            end if;
        end process;
        
        ALUSrcProc: process(Opcode, Funct) begin
        Case Opcode is
            when "001000" => AluSrc <= '1'; -- ADDI
            when "001100" => AluSrc <= '1'; -- ANDI
            when "001101" => AluSrc <= '1'; -- ORI
            when "001110" => AluSrc <= '1'; --XORI
            when "101011" => AluSrc <= '1'; --SW
            when "100011" => AluSrc <= '1'; --LW
            when others   => AluSrc <= '0';
        end case;
        end process;
        
        RegDstProc: process(Opcode, Funct) begin
        Case Opcode is
            when "001000" => RegDst <= '0';
            when "001100" => RegDst <= '0';
            when "001101" => RegDst <= '0';
            when "001110" => RegDst <= '0';
            when "101011" => RegDst <= '0';
            when "100011" => RegDst <= '0';
            when others   => RegDst <= '1'; 
        end case;
        end process;



end Behavioral;