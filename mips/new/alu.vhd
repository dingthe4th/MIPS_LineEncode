----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 23:39:18
-- Design Name: 
-- Module Name: alu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( alucontrol : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (31 downto 0));
end alu ;

architecture Behavioral of alu is
signal res : STD_LOGIC_VECTOR (31 downto 0); 
begin
    process (alucontrol,a,b)
    begin
    case alucontrol is
      when "0000" =>
        res<= a and b;
      when "0001" =>
        res <= a or b;
      when "0010" =>
        res <= a + b;
      when "0110" =>
        res <= a - b;
      when "0111" => -- ste
          if (a<b) then
              res <= x"00000001";
          else 
             res <= x"00000000";
          end if;  
      when "1100" =>
         res <= a nor b;     
      when others =>
        res <= a;
     end case;
     end process;
     zero <= '1' when res = x"00000000" else '0';
     result <= res;
      
   
    
end Behavioral;
