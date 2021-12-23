 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY biphasem_encode_test IS
END biphasem_encode_test;
ARCHITECTURE behavior OF biphasem_encode_test IS 
--Component Declaration for the Unit Under Test (UUT)
COMPONENT biphasem_encode
PORT(
clk: IN  std_logic;
prev: IN  std_logic;
data : IN  std_logic;
biphasem: OUT  std_logic
);
END COMPONENT;
--Inputs
signal stream : std_logic_vector(0 to 7);
signal temp : std_logic;
signal clk: std_logic:= '0';
signal prev: std_logic:= '0';
signal data : std_logic:= '0';
--Outputs
signal biphasem: std_logic;
--Clock period definitions
constant clk_period: time := 10 ns;
BEGIN
--Instantiate the Unit Under Test (UUT)
uut: biphasem_encode PORT MAP (
clk=> clk,
prev=> prev,
data => data,
biphasem=> biphasem
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
stim_proc: process
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
