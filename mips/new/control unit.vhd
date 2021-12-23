----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2021 00:45:29
-- Design Name: 
-- Module Name: control unit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
    Port ( 
            op: in std_logic_vector(5 downto 0);
            regDst :out std_logic;
            Jump: out std_logic;
            ALUSrc: out std_logic;
            MemtoReg: out std_logic;
            RegWrite: out std_logic;
            MemRead: out std_logic;
            MemWrite: out std_logic;
            Branch: out std_logic;
            ALUop: out std_logic_vector (1 downto 0)
            );

end control_unit;

architecture Behavioral of control_unit is

begin
    
   process(op)
   begin
        case op is
        when "000000" => -- r type?
          regDst <= '1';
          jump <='0';
          ALUSrc <= '0';
          MemtoReg <= '0';
          MemRead <= '0';
          RegWrite <= '1';
          MemWrite  <= '0';
          Branch  <= '0';
          ALUop  <= "10";
          
        when "100011" => -- lw 
          regDst <= '0';
          jump <='0';
          ALUSrc <= '1';
          MemtoReg <= '1';
          MemRead <= '1';
          RegWrite <= '1';
          MemWrite  <= '0';
          Branch  <= '0';
          ALUop  <= "00";
          
        when "101011" => -- sw
         -- regDst <= '0';
         jump <='0';
          ALUSrc <= '1';
          --MemtoReg <= '1';
          MemRead <= '0';
          RegWrite <= '0';
          MemWrite  <= '1';
          Branch  <= '0';
          ALUop  <= "00";
        when "000100" => --beq
           
          --regDst <= '0';
          jump <='0';
          ALUSrc <= '0';
          --MemtoReg <= '1';
          MemRead <= '0';
          RegWrite <= '0';
          MemWrite  <= '0';
          Branch  <= '1';
          ALUop  <= "01";
        when   "000010" => --jmp
          --egDst <= '0';
          jump <='1';
          --ALUSrc <= '0';
          --MemtoReg <= '1';
          MemRead <= '0';
          RegWrite <= '0';
          MemWrite  <= '0';
          Branch  <= '0';
          --ALUop  <= "01";
        when "001000" => -- addi
          regDst <= '0';
          jump <='0';
          ALUSrc <= '1';
          MemtoReg <= '0';
          MemRead <= '0';
          RegWrite <= '1';
          MemWrite  <= '0';
          Branch  <= '0';
          ALUop  <= "00";
        when others=> --xdd
          regDst <= '0';
          jump <= '0';
          ALUSrc <= '0';
          MemtoReg <= '0';
          MemRead <= '0';
          RegWrite <= '0';
          MemWrite  <= '0';
          Branch  <= '0';
          ALUop  <= "00";
          end case;
   end process;
    

end Behavioral;
