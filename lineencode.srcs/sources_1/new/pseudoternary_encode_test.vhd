 
LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY pseudoternary_encode_test IS
END pseudoternary_encode_test;
ARCHITECTURE behavior OF pseudoternary_encode_test IS 
--Component Declaration for the Unit Under Test (UUT)
COMPONENT pseudoternary_encode
PORT(
clk: IN  std_logic;
prev: IN std_logic;
data : IN  std_logic;
pseudoternary: OUT  SIGNED(1 downto 0)
);
END COMPONENT;
--Inputs
signal stream : std_logic_vector(0 to 7);
signal temp : std_logic;
signal prev: std_logic:= '0';
signal clk: std_logic:= '0';
signal data : std_logic:= '0';
--Outputs
signal pseudoternary: SIGNED(1 downto 0);
--Clock period definitions
constant clk_period: time := 10 ns;
BEGIN
--Instantiate the Unit Under Test (UUT)
uut: pseudoternary_encode PORT MAP (
clk=> clk,
prev=> prev,
data => data,
pseudoternary=> pseudoternary
);
--Clock process definitions
clk_process:process
begin
clk<= '1';
wait for clk_period/2;
clk<= '0';
wait for clk_period/2;
end process;
--Stimulus process
stim_proc:process
begin
stream <= "10110001";
temp <= '0';
wait for 10 ns;
for i in 0 to 7 loop
data <= stream(i);
prev<= temp;
if stream(i) = '0' then
temp <= not(temp);
end if;
wait for 10 ns;
end loop;
wait;
end process;
END;
