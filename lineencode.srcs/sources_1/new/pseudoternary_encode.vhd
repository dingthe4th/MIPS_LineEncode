library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity pseudoternary_encode is
Port ( clk: in  STD_LOGIC;
prev: in STD_LOGIC;
data : in  STD_LOGIC;
pseudoternary: out SIGNED(1 downto 0));
end pseudoternary_encode;
architecture Behavioral of pseudoternary_encode is
 
begin
process(clk)
begin
if rising_edge(clk) then
if data = '0' then
if prev= '1' then
pseudoternary<= conv_signed(-1,2);
else pseudoternary<= conv_signed(1,2);
end if;
elsif data = '1' then
pseudoternary<= conv_signed(0,2);
end if;
end if;
end process;
end Behavioral;
