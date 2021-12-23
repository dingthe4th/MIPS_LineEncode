----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 23:21:57
-- Design Name: 
-- Module Name: signExtend - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity signExtend is
    Port ( instruction : in STD_LOGIC_VECTOR (15 downto 0);
           extended : out STD_LOGIC_VECTOR (31 downto 0));
end signExtend;

architecture Behavioral of signExtend is

begin

    extended(31 downto 16) <= x"FFFF" when instruction(15) = '1' else x"0000";
    extended(15 downto 0) <= instruction;   
    
end Behavioral;
