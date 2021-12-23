library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity nrzs_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
nrzs: out  STD_LOGIC;
prev: in STD_LOGIC);
end nrzs_encode;
architecture Behavioral of nrzs_encode is
function encode_nrzs(signal input, previous : STD_LOGIC)
return STD_LOGIC is
variable output : STD_LOGIC;
begin
if input = '0' then
output := not(previous);
elsif input = '1' then
output := previous;
end if;
return output;
end encode_nrzs;
 
begin
process(clk)
begin
if rising_edge(clk) then
nrzs<= encode_nrzs(data, prev);
end if;
end process;
end Behavioral;
