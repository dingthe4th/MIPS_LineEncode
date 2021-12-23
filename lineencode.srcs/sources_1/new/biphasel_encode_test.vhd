LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY biphasel_encode_test IS
END biphasel_encode_test;
ARCHITECTURE behavior OF biphasel_encode_test IS 
--Component Declaration for the Unit Under Te st (UUT)
COMPONENT biphasel_encode
PORT(
clk: IN  std_logic;
data : IN  std_logic;
biphasel: OUT  std_logic
);
END COMPONENT;
--Inputs
signal stream : std_logic_vector(0 to 7);
signal clk: std_logic:= '0';
signal data : std_logic:= '0';
--Outputs
signal biphasel: std_logic;
--Clock period definitions
constant clk_period: time := 10 ns;
BEGIN
--Instantiate the Unit Under Test (UUT)
uut: biphasel_encode PORT MAP (
clk=> clk,
data => data,
biphasel=> biphasel
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
wait for 10 ns;
for i in 0 to 7 loop
data <= stream(i);
wait for 10 ns;
end loop;
wait;
end process;
END;
