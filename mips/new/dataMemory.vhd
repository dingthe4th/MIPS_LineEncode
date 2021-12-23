----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 21:47:18
-- Design Name: 
-- Module Name: dataMemory - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dataMemory is
    Port ( address : in STD_LOGIC_VECTOR (31 downto 0);
           writeData : in STD_LOGIC_VECTOR (31 downto 0);
           memRead: in STD_LOGIC;
           memWrite: in STD_LOGIC;
           clk : in STD_LOGIC;
           readData : out STD_LOGIC_VECTOR (31 downto 0)
           );
end dataMemory;

architecture Behavioral of dataMemory is

type data_mem is array (0 to 255 ) of std_logic_vector (31 downto 0);
signal RAM: data_mem :=(
        1=>x"00000001",
        2=>x"00000001",
        3=>x"00000008",
        4=>x"00000004",
        5=>x"00000007",
        6=>x"00000001",
        7=>x"00000001",
        8=>x"00000005",
        others => (others => '1')
  );

begin
    process(clk)
    begin
    if (falling_edge(clk)) then 
        if memWrite = '1' then
            ram(to_integer(unsigned(address)))<=writeData;

        end if;
    end if;
    if memRead = '1' then
            readData<=ram(to_integer(unsigned(address)));
     end if;
    end process;
end Behavioral;
