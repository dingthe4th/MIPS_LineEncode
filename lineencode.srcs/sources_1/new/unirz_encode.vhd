library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity unirz_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
unirz: out  STD_LOGIC);
end unirz_encode;
architecture Behavioral of unirz_encode is
 
begin
process(clk)
begin
if rising_edge(clk) then
if data = '1' then
unirz<= '1';
else unirz<= '0';
end if;
elsif falling_edge(clk) then
if data = '1' then
unirz<= '0';
end if;
end if;
end process;
end Behavioral;
