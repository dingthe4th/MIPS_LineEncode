library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity biphases_encode is
Port ( clk: in  STD_LOGIC;
prev: in STD_LOGIC;
data : in  STD_LOGIC;
biphases: out  STD_LOGIC);
end biphases_encode;
architecture Behavioral of biphases_encode is
 
begin
process(clk)
begin
if falling_edge(clk) then
if data = '0' then
biphases<= prev;
elsif data = '1' then 
biphases<= not(prev);
end if;
elsif rising_edge(clk) then
biphases<= not(prev);
end if;
end process;
end Behavioral;
