library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mips_line_tb is
end;

architecture bench of mips_line_tb is

  component mips_line
      Port ( rst : in STD_LOGIC;
             clk : in STD_LOGIC;
             regout: out STD_LOGIC_VECTOR (31 downto 0);
             serial: out STD_LOGIC;
             aluoutput : out STD_LOGIC_VECTOR (31 downto 0);
             pcoutput : out STD_LOGIC_VECTOR (31 downto 0)
             );
  end component;

  signal rst: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal regout: STD_LOGIC_VECTOR (31 downto 0);
  signal serial: STD_LOGIC;
  signal aluoutput: STD_LOGIC_VECTOR (31 downto 0);
  signal pcoutput: STD_LOGIC_VECTOR (31 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: mips_line port map ( rst       => rst,
                            clk       => clk,
                            regout    => regout,
                            serial    => serial,
                            aluoutput => aluoutput,
                            pcoutput  => pcoutput );

  stimulus: process
  begin
  
    -- Put initialisation code here
    rst <= '1';
    wait for 10ns;
    rst <= '0';
    wait for 1000ns;
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;