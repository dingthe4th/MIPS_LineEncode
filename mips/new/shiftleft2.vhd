----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2021 01:20:32
-- Design Name: 
-- Module Name: shiftleft2_32 - Behavioral
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

entity shiftleft2_32 is
    Port ( sigin : in STD_LOGIC_VECTOR (31 downto 0);
           sigout : out STD_LOGIC_VECTOR (31 downto 0));
end shiftleft2_32;

architecture Behavioral of shiftleft2_32 is

begin
    sigout(31 downto 2) <=sigin(29 downto 0);
    sigout(1 downto 0) <= "00";
end Behavioral;
