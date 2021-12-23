library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity biphasel_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
biphasel: out  STD_LOGIC);
end biphasel_encode;
architecture Behavioral of biphasel_encode is
 
begin
process(clk)
begin
if falling_edge(clk) then
if data = '1' then
biphasel<= '0';
elsif data = '0' then 
biphasel<= '1';
end if;
elsif rising_edge(clk) then
if data = '1' then
biphasel<= '1';
else biphasel<= '0';
end if;
end if;
end process;
end Behavioral;
