----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2021 01:02:24
-- Design Name: 
-- Module Name: regfile - Behavioral
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

entity regfile is
    Port ( reg1 : in STD_LOGIC_VECTOR (4 downto 0);
           reg2 : in STD_LOGIC_VECTOR (4 downto 0);
           writeReg : in STD_LOGIC_VECTOR (4 downto 0);
           writedata : in STD_LOGIC_VECTOR (31 downto 0);
           RegWrite : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk: in STD_LOGIC;
           rd1 : out STD_LOGIC_VECTOR (31 downto 0);
           regout: out STD_LOGIC_VECTOR (31 downto 0);
           rd2 : out STD_LOGIC_VECTOR (31 downto 0));
end regfile;

architecture Behavioral of regfile is

 type reg_array_type is array (0 to 255) of std_logic_vector(31 downto 0); -- change this for 
 
 signal reg_array : reg_array_type:=(
   others => (others => '1')
  );

begin
process (clk,rst)
begin
    if(rst='1') then
       reg_array(0) <= x"00000000"; --zero
       reg_array(1) <= x"0000008d"; --line encode 
       reg_array(2) <= x"0000007b";
       reg_array(3) <= x"00000005";
       reg_array(4) <= x"00000004";
       reg_array(5) <= x"00000005";
       reg_array(6) <= x"00000006";
       reg_array(7) <= x"00000007";
       reg_array(8) <= x"00000008";
       reg_array(9) <= x"00000009";
       reg_array(10) <= x"0000000A";
       reg_array(11) <= x"0000000B";       
       reg_array(12) <= x"0000000C";       
       reg_array(13) <= x"0000000D";       
       reg_array(14) <= x"0000000E";
       reg_array(15) <= x"0000000F";       
       reg_array(16) <= x"00000010";       
       reg_array(17) <= x"00000011";       
       reg_array(18) <= x"00000012";
       reg_array(19) <= x"00000013";       
       reg_array(20) <= x"00000014";       
       reg_array(21) <= x"00000015";       
       reg_array(22) <= x"00000016";
       reg_array(23) <= x"00000017";       
       reg_array(24) <= x"00000018";       
       reg_array(25) <= x"00000019";       
       reg_array(26) <= x"0000001A";
       reg_array(27) <= x"0000001B";       
       reg_array(28) <= x"0000001C";       
       reg_array(29) <= x"0000001D";       
       reg_array(30) <= x"0000001E";
       reg_array(31) <= x"0000001F";
         
    elsif rising_edge(clk) then
        if RegWrite = '1' then
            reg_array(to_integer(unsigned(writeReg)))<=writedata;
        end if;
    end if;
    
end process;
    regout<= reg_array(1);
    rd1 <= (others=>'0') when reg1=x"00000" else reg_array(to_integer(unsigned(reg1)));
    rd2 <= (others=>'0') when reg2=x"00000" else reg_array(to_integer(unsigned(reg2)));

end Behavioral;
