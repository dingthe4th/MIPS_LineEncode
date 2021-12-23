----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2021 03:10:23
-- Design Name: 
-- Module Name: pc - Behavioral
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

entity pc is
    Port ( pcin : in STD_LOGIC_VECTOR (31 downto 0);
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           pcout : out STD_LOGIC_VECTOR (31 downto 0));
end pc;

architecture Behavioral of pc is
signal pcreg: std_logic_vector(31 downto 0);
begin
   process(clk,rst)
   begin
   if rst = '1' then
   pcreg<=x"00000000";
   elsif rising_edge(clk) then
   pcreg <= pcin;
   end if;
   end process;
   pcout <= pcreg;
   
   
end Behavioral;
