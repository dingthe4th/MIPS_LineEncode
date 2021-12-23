library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity biphasem_encode is
Port ( clk: in  STD_LOGIC;
prev: in STD_LOGIC;
data : in  STD_LOGIC;
biphasem: out  STD_LOGIC);
end biphasem_encode;
architecture Behavioral of biphasem_encode is
 
begin
process(clk)
begin
if falling_edge(clk) then
if data = '1' then
biphasem<= prev;
elsif data = '0' then 
biphasem<= not(prev);
end if;
elsif rising_edge(clk) then
biphasem<= not(prev);
end if;
end process;
end Behavioral;
