----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2021 00:01:10
-- Design Name: 
-- Module Name: alucontrol - Behavioral
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

entity alucontrol is
    Port ( aluop : in STD_LOGIC_VECTOR (1 downto 0);
           funct : in STD_LOGIC_VECTOR (5 downto 0);
           alucontroller : out STD_LOGIC_VECTOR (3 downto 0));
end alucontrol;

architecture Behavioral of alucontrol is

begin


    alucontroller <= "0010" when aluop="00" or (aluop="10" and funct = "100000") else 
             "0110" when aluop="01" or (aluop="10" and funct = "100010") else --subtraction
             "0000" when (aluop="10" and funct = "100100" )else
             "0001" when (aluop="10" and funct = "100101") else 
             "0111" when (aluop="10" and funct = "101010") else
             "1111";



end Behavioral;
