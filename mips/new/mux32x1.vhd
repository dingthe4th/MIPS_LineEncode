----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 22:13:12
-- Design Name: 
-- Module Name: mux31x1 - Behavioral
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

entity mux32x1 is
    Port ( in0 : in STD_LOGIC_VECTOR (31 downto 0);
           in1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           outsig : out STD_LOGIC_VECTOR (31 downto 0));
end mux32x1;

architecture Behavioral of mux32x1 is

begin
    outsig <= in0 when sel = '0' else in1;
end Behavioral;
