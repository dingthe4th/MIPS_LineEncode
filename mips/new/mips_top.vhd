----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2021 01:39:26
-- Design Name: 
-- Module Name: mips_top - Behavioral
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



entity mips_top is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           regout: out STD_LOGIC_VECTOR (31 downto 0); -- $1 for output
           aluoutput : out STD_LOGIC_VECTOR (31 downto 0);
           encode_sel: out STD_LOGIC_VECTOR (5 downto 0);
           Eencode: out STD_LOGIC;
           pcoutput : out STD_LOGIC_VECTOR (31 downto 0));
end mips_top;

architecture Behavioral of mips_top is

component alu is
    Port ( alucontrol : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (31 downto 0));
end component ;

component alucontrol is
    Port ( aluop : in STD_LOGIC_VECTOR (1 downto 0);
           funct : in STD_LOGIC_VECTOR (5 downto 0);
           alucontroller : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component control_unit is
    Port ( 
            op: in std_logic_vector(5 downto 0);
            regDst :out std_logic;
            jump : out std_logic;
            ALUSrc: out std_logic;
            MemtoReg: out std_logic;
            RegWrite: out std_logic;
            MemRead: out std_logic;
            MemWrite: out std_logic;
            Branch: out std_logic;
            ALUop: out std_logic_vector (1 downto 0)
            );
end component;

component dataMemory is
    Port ( address : in STD_LOGIC_VECTOR (31 downto 0);
           writeData : in STD_LOGIC_VECTOR (31 downto 0);
           memRead: in STD_LOGIC;
           memWrite: in STD_LOGIC;
           clk : in STD_LOGIC;
           readData : out STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

component instMem is
    Port ( readAdd : in STD_LOGIC_VECTOR (31 downto 0);
           instruction : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux32x1 is
    Port ( in0 : in STD_LOGIC_VECTOR (31 downto 0);
           in1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           outsig : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux5x1 is
    Port ( in0 : in STD_LOGIC_VECTOR (4 downto 0);
           in1 : in STD_LOGIC_VECTOR (4 downto 0);
           sel : in STD_LOGIC;
           outsig : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component regfile is
    Port ( reg1 : in STD_LOGIC_VECTOR (4 downto 0);
           reg2 : in STD_LOGIC_VECTOR (4 downto 0);
           writeReg : in STD_LOGIC_VECTOR (4 downto 0);
           writedata : in STD_LOGIC_VECTOR (31 downto 0);
           RegWrite : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk: in STD_LOGIC;
           regout: out STD_LOGIC_VECTOR (31 downto 0);
           rd1 : out STD_LOGIC_VECTOR (31 downto 0);
           rd2 : out STD_LOGIC_VECTOR (31 downto 0));
           
end component;

component shiftleft2_32 is
    Port ( sigin : in STD_LOGIC_VECTOR (31 downto 0);
           sigout : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component signExtend is
    Port ( instruction : in STD_LOGIC_VECTOR (15 downto 0);
           extended : out STD_LOGIC_VECTOR (31 downto 0));
end component;
component pc is
    Port ( pcin : in STD_LOGIC_VECTOR (31 downto 0);
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           pcout : out STD_LOGIC_VECTOR (31 downto 0));
end component;   
--signal list
signal pcout:std_logic_vector(31 downto 0);
signal pcin:std_logic_vector(31 downto 0);
signal pcplus4:std_logic_vector(31 downto 0);
signal jmpad28 : std_logic_vector(31 downto 0);
signal jmpad32 : std_logic_vector(31 downto 0);
signal inst31_26 : std_logic_vector(5 downto 0);
signal inst25_21 : std_logic_vector(4 downto 0);
signal inst20_16 : std_logic_vector(4 downto 0);
signal inst15_11 : std_logic_vector(4 downto 0);
signal inst15_0 : std_logic_vector(15 downto 0);
signal inst31_0 : std_logic_vector(31 downto 0);
signal inst15_0ext : std_logic_vector(31 downto 0);
signal inst15_0extsl2 :  std_logic_vector(31 downto 0);
signal inst25_0  : std_logic_vector(31 downto 0);
signal rddata1 : std_logic_vector(31 downto 0);
signal rddata2 : std_logic_vector(31 downto 0);
signal aluresult : std_logic_vector(31 downto 0);
signal datamem_rddata : std_logic_vector(31 downto 0);
signal inst15_0extsl2sl2pluspcplus4 : std_logic_vector(31 downto 0);
signal mux2mux: std_logic_vector(31 downto 0);
signal regDst : std_logic;
signal jump: std_logic;
signal ALUSrc:  std_logic;
signal MemtoReg: std_logic;
signal RegWrite: std_logic;
signal MemRead: std_logic;
signal MemWrite: std_logic;
signal Branch: std_logic;
signal ALUop: std_logic_vector (1 downto 0);
signal alucontroller : std_logic_vector (3 downto 0);
signal funct : std_logic_vector (5 downto 0);
signal prev_funct: std_logic_vector (5 downto 0); -- new addition, ding
signal b : std_logic_vector (31 downto 0);
signal zero : std_logic;
signal writedata : std_logic_vector(31 downto 0);
signal zeroandbranch : std_logic;
signal writereg : std_logic_vector(4 downto 0);

begin

alucompoent: alu 
    Port map( alucontrol => alucontroller,
           a => rddata1,
           b => b,
           zero => zero,
           result => aluresult);
           
 pcalu: alu 
    Port map( alucontrol => "0010",
           a => pcout,
           b => x"00000004",
           zero => open,
           result => pcplus4);   
           
 jmpalu: alu 
    Port map( alucontrol => "0010",
           a => pcplus4,
           b => inst15_0extsl2,
           zero => open,
           result => inst15_0extsl2sl2pluspcplus4 );                     
           
alucontrollercomponent : alucontrol 
    Port map( aluop => ALUop,
           funct => funct,
           alucontroller => alucontroller);  
 
controlunit_c : control_unit 
    Port map( 
            op => inst31_26,
            regDst => regDst,
            jump => jump,
            ALUSrc => ALUSrc,
            MemtoReg => MemtoReg,
            RegWrite => RegWrite,
            MemRead => MemRead,
            MemWrite => MemWrite,
            Branch => Branch,
            ALUop =>  ALUop
            );

datamem : dataMemory
    Port map( address => aluResult,
           writeData => rddata2,
           memRead => MemRead,
           memWrite => memWrite,
           clk => clk,
           readData => dataMem_rddata
           );
          
instMem_c: instMem
    Port map( readAdd => pcout,
           instruction => inst31_0);
           
reg2alu_mux: mux32x1 
    Port map( in0 => rddata2,
           in1 => inst15_0ext,
           sel => ALUSrc,
           outsig => b);
     

mem2reg_mux: mux32x1 
    Port map( in0 => aluresult,
           in1 => dataMem_rddata,
           sel => MemtoReg,
           outsig => writedata);
           
branch_mux: mux32x1 
    Port map( in0 => pcplus4,
           in1 => inst15_0extsl2sl2pluspcplus4 ,
           sel => zeroandbranch,
           outsig => mux2mux);

jump_mux: mux32x1 
    Port map( in0 => mux2mux,
           in1 => jmpad32,
           sel => jump,
           outsig => pcin);   
           
regdst_mux: mux5x1
    Port map( in0 => inst20_16,
           in1 => inst15_11,
           sel => regdst,
           outsig => writereg);
                
regfile_component : regfile
    Port map( reg1 => inst25_21,
           reg2 => inst20_16,
           writeReg => writereg,
           writedata => writedata,
           RegWrite => regwrite,
           rst => rst,
           clk => clk,
           regout => regout,
           rd1 => rddata1,
           rd2 => rddata2);    
                
extendsl2alu:  shiftleft2_32 
    Port map( sigin => inst15_0ext,
           sigout => inst15_0extsl2);
           
inst2jump : shiftleft2_32 
    Port map( sigin => inst25_0,
           sigout => jmpad28); 

extend: signExtend
    Port map( instruction => inst15_0,
           extended => inst15_0ext);

pcz :pc 
    Port map( pcin => pcin,
           rst =>rst,
           clk => clk,
           pcout => pcout);
           
inst25_21 <= inst31_0(25 downto 21);
inst20_16 <= inst31_0(20 downto 16);
inst15_11 <= inst31_0(15 downto 11);
inst15_0 <= inst31_0(15 downto 0);
inst31_26 <= inst31_0(31 downto 26);
funct <= inst31_0(5 downto 0);
inst25_0 <= "000000"&inst31_0(25 downto 0);           
jmpad32(31 downto 28) <= pcplus4(31 downto 28);
jmpad32(27 downto 0) <= jmpad28(27 downto 0);
zeroandbranch <= zero and branch;
aluoutput <= aluresult;
pcoutput <= pcout;

--encode_sel<= funct;
prev_funct <= funct when inst31_26 = "111111";
Eencode <= '1' when inst31_26 = "111111" else '0';
encode_sel <= funct when inst31_26 = "111111" else prev_funct;
end Behavioral;
