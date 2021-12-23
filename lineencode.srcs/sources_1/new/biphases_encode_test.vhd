LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY biphases_encode_test IS
END biphases_encode_test;
ARCHITECTURE behavior OF biphases_encode_test IS 
--Component Declaration for the Unit Under Test (UUT)
COMPONENT biphases_encode
PORT(
clk: IN  std_logic;
prev: IN  std_logic;
data : IN  std_logic;
biphases: OUT  std_logic
);
END COMPONENT;
--Inputs
signal stream : std_logic_vector(0 to 7);
signal temp : std_logic;
signal clk: std_logic:= '0';
signal prev: std_logic:= '0';
signal data : std_logic:= '0';
--Outputs
signal biphases: std_logic;
--Clock period definitions
constant clk_period: time := 10 ns;
BEGIN
--Instantiate the Unit Under Test (UUT)
uut: biphases_encode PORT MAP (
clk=> clk,
prev=> prev,
data => data,
biphases=> biphases
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
if stream(i) = '1' then
temp <= not(temp);
end if;
wait for 10 ns;
end loop;
wait;
end process;
END;

