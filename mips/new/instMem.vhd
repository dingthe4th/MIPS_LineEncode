----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 21:30:40
-- Design Name: 
-- Module Name: instMem - Behavioral
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

entity instMem is
    Port ( readAdd : in STD_LOGIC_VECTOR (31 downto 0);
           instruction : out STD_LOGIC_VECTOR (31 downto 0));
end instMem;

architecture Behavioral of instMem is
 type ROM_type is array (0 to 255) of std_logic_vector(31 downto 0); -- change this for 
 constant rom_data: ROM_type:=(

--a is $s1, b is $2
--gcd code 
--0=>"000100"&"00010"&"00001"&"0000000000000111",
--1=>"000000"&"00010"&"00001"&"00011"&"00000"&"101010",--if b<a then $3 =1
--2=>"000100"&"00000"&"00011"&"0000000000000010",--if b>a then go to the thing is whis wrong
--3=>"000000"&"00001"&"00010"&"00001"&"00000"&"100010",--b>a 
--4=>"000010"&"00000000000000000000000000",
--5=>"000000"&"00010"&"00001"&"00010"&"00000"&"100010", -- a-b = a
--6=>"000010"&"00000000000000000000000000",
--7=>"00000000000000000000000000000000",

    0=>"111111"&"00000"&"00000"&"0000000000000111",                                   




--8=>"001000"&"00000"&"00100"&"0000000000000010", 

--9=>"000000"&"00100"&"00010"&"00011"&"00000"&"101010",
--10=>"000100"& "00011"&"00000"&"0000000000000010",
--11=>"001000"&"00010"&"00010"&"1111111111111110",
--12=>"000010"&"00000000000000000000001001",


       others => (others => '0') 
);
begin
    instruction <= rom_data(to_integer(unsigned(readAdd(31 downto 2))));
end Behavioral;
