library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity nrzm_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
nrzm: out  STD_LOGIC;
prev: in STD_LOGIC);
end nrzm_encode;
architecture Behavioral of nrzm_encode is
function encode_nrzm(signal input, previous : STD_LOGIC)
return STD_LOGIC is
variable output : STD_LOGIC;
begin
if input = '1' then
output := not(previous);
elsif input = '0' then
output := previous;
end if;
return output;
end encode_nrzm;
begin
process(clk)
begin
if rising_edge(clk) then
nrzm <= encode_nrzm(data, prev);
end if;
end process;
end Behavioral;
