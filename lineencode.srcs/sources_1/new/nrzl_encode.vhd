library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity nrzl_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
nrzl: out  STD_LOGIC);
end nrzl_encode;
architecture Behavioral of nrzl_encode is
function encode_nrzl(signal input : STD_LOGIC)
return STD_LOGIC is
variable output : STD_LOGIC;
begin
output := input;
return output;
end encode_nrzl;
 
begin
process(clk)
begin
if rising_edge(clk) then
nrzl<= encode_nrzl(data);
end if;
end process;
end Behavioral;
