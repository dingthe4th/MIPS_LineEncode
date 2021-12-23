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

entity mips_line is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           regout: out STD_LOGIC_VECTOR (31 downto 0); -- $1 for output
           serial: out STD_LOGIC;
           aluoutput : out STD_LOGIC_VECTOR (31 downto 0);
           pcoutput : out STD_LOGIC_VECTOR (31 downto 0)
           );
end mips_line;

architecture Behavioral of mips_line is

component mips_top is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           regout: out STD_LOGIC_VECTOR (31 downto 0); -- $1 for output
           aluoutput : out STD_LOGIC_VECTOR (31 downto 0);
           encode_sel: out STD_LOGIC_VECTOR (5 downto 0);
           Eencode: out STD_LOGIC;
           pcoutput : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component nrzl_encode is
Port (  clk: in  STD_LOGIC;
        data : in  STD_LOGIC;
        nrzl: out  STD_LOGIC);
end component;

component nrzm_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
nrzm: out  STD_LOGIC;
prev: in STD_LOGIC);
end component;

component nrzs_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
nrzs: out  STD_LOGIC;
prev: in STD_LOGIC);
end component;

component birz_encode is
Port ( clk: in  STD_LOGIC;
data : in STD_LOGIC;
birz: out SIGNED(1 downto 0));
end component;

component unirz_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
unirz: out  STD_LOGIC);
end component;

component biphasel_encode is
Port ( clk: in  STD_LOGIC;
data : in  STD_LOGIC;
biphasel: out  STD_LOGIC);
end component;

component biphasem_encode is
Port ( clk: in  STD_LOGIC;
prev: in STD_LOGIC;
data : in  STD_LOGIC;
biphasem: out  STD_LOGIC);
end component;

component biphases_encode is
Port ( clk: in  STD_LOGIC;
prev: in STD_LOGIC;
data : in  STD_LOGIC;
biphases: out  STD_LOGIC);
end component;

component bami_encode is
Port ( clk: in  STD_LOGIC;
prev: in STD_LOGIC;
data : in  STD_LOGIC;
bami: out SIGNED(1 downto 0));
end component;

component pseudoternary_encode is
Port ( clk: in  STD_LOGIC;
prev: in STD_LOGIC;
data : in  STD_LOGIC;
pseudoternary: out SIGNED(1 downto 0));
end component;

signal count : integer range 0 to 31;
signal encode_sel: std_logic_vector(5 downto 0);
signal Eencode: std_logic;
signal serial_in:std_logic;

-- prev signal
signal prev : std_logic := '0';
--variable prev_temp : std_logic := '0';
signal prev_entype : std_logic;

-- signal pass to actual serial out
signal serial_nrzl:std_logic; -- a -- no prev -- a = 1
signal serial_nrzm:std_logic; -- b -- with prev
signal serial_nrzs:std_logic; -- c -- with prev
signal serial_biphasel:std_logic; -- d -- no prev
signal serial_biphasem:std_logic; -- e -- with prev
signal serial_biphases:std_logic; -- f -- with prev
signal serial_unirz:std_logic; -- g -- no prev
signal serial_birz:std_logic; -- with negative
signal serial_bami:std_logic; -- -with negative
signal serial_pseudoternary:std_logic; -- with negative

function get_serial(
    encode_type : in STD_LOGIC_VECTOR(5 downto 0);
    a,b,c,d,e,f,g : in STD_LOGIC)
    return STD_LOGIC is
    variable output : STD_LOGIC;
        begin
            case encode_type is
                when "000001" =>
                    output := a;
                when "000010" =>
                    output := b;
                when "000011" =>
                    output := c;
                when "000100" =>
                    output := d;
                when "000101" =>
                    output := e;
                when "000110" =>
                    output := f;
                when "000111" =>
                    output := g;
                when others =>
                    output := '0';                                                                                     
            end case;
    return output;
end get_serial;

function get_prev(encode_type : in STD_LOGIC_VECTOR(5 downto 0); serial_in : in STD_LOGIC; previous : in STD_LOGIC) --serial_in dapat
    return STD_LOGIC is 
    variable temp : STD_LOGIC;
        begin
            case encode_type is
                when "000010" =>
                    if(serial_in = '1') then
                        temp := not(previous);
                          report("i got here!!!!");
                    else
                        temp := previous;
                    end if;                    
                when "000011" =>
                    if(serial_in = '0') then
                        temp := not(previous);
                    else
                        temp := previous;
                    end if;  
                when "000101" =>
                    if(serial_in = '0') then
                        temp := not(previous);
                    else
                        temp := previous;
                    end if;  
                when "000110" =>
                    if(serial_in = '1') then
                        temp := not(previous);
                    else
                        temp := previous;
                    end if;  
                when others =>
                    temp := previous;      
            end case;
    return temp;
end get_prev;

signal reg_sig : STD_LOGIC_VECTOR (31 downto 0);
begin
    mips : mips_top 
        Port map( 
           rst => rst,
           clk => clk,
           regout => reg_sig, -- $1 for output
           aluoutput => aluoutput,
           encode_sel => encode_sel,
           Eencode => Eencode,
           pcoutput => pcoutput);
    
    nrzl: nrzl_encode 
        Port map(clk => clk,
            data => serial_in,
            nrzl => serial_nrzl);
                
    nrzm: nrzm_encode
        Port map( clk => clk,
            data => serial_in,
            nrzm => serial_nrzm,
            prev => prev);                
            
     nrzs: nrzs_encode
        Port map( clk => clk,
            data => serial_in,
            nrzs => serial_nrzs,
            prev => prev);  

     biphasel: biphasel_encode
        Port map( clk => clk,
            data => serial_in,
            biphasel => serial_biphasel);
            
     biphasem: biphasem_encode
        Port map( clk => clk,
            prev => prev,
            data => serial_in,
            biphasem => serial_biphasem);
            
     biphases: biphases_encode
        Port map( clk => clk,
            prev => prev,
            data => serial_in,
            biphases => serial_biphases);      

     unirz: unirz_encode
        Port map(clk=>clk,
            data => serial_in,
            unirz => serial_unirz);
      
    -- result of serial out
    serial <= get_serial(encode_sel, serial_nrzl, serial_nrzm, serial_nrzs,
    serial_biphasel, serial_biphasem, serial_biphases, serial_unirz);

    process(rst,clk,count,Eencode)
    begin
        if(rst = '1') then 
            serial_in <= '0'; 
--            serial <= '0';
        end if; 
        
        if falling_edge(clk) then
            if(Eencode = '1') then
                count <= 0;
                serial_in <= '0';
            elsif (count < 32) then
                serial_in <= reg_sig(count);
                count <= count + 1;
            end if;
            
            -- get previous serial
--            prev_temp <= prev;
            prev <= get_prev(encode_sel, serial_in, prev);
        end if;
    end process;
    
    regout <= reg_sig;
end Behavioral;
