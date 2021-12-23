library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity birz_encode is
Port ( clk: in  STD_LOGIC;
data : in STD_LOGIC;
birz: out SIGNED(1 downto 0));
end birz_encode;
architecture Behavioral of birz_encode is
 
begin
process(clk)
begin
if falling_edge(clk) then
birz<= conv_signed(0, 2);
elsif rising_edge(clk) then
if data = '1' then
birz<= conv_signed(1,2);
else birz<= conv_signed(-1,2);
end if;
end if;
end process;
end Behavioral;
