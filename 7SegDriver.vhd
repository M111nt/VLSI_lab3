library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_driver is
   port ( clk           : in  std_logic;
          reset         : in  std_logic;
          BCD_digit     : in  std_logic_vector(9 downto 0);   
          BCD_digit16   : in  std_logic_vector(15 downto 0);       
          sign          : in  std_logic;
          overflow      : in  std_logic;
          FN            : in std_logic_vector(3 downto 0);
          DIGIT_ANODE   : out std_logic_vector(3 downto 0);
          SEGMENT       : out std_logic_vector(7 downto 0)
        );
end seven_seg_driver;

architecture behavioral of seven_seg_driver is
component BCD_to_seg 
	 port (
	     binary_in : in std_logic_vector(3 downto 0);
	     sev_seg   : out std_logic_vector(7 downto 0)
	 );
	 end component;
-- SIGNAL DEFINITIONS HERE IF NEEDED
signal counter_current, counter_next : unsigned(19 downto 0);
signal BCD_4 : std_logic_vector(3 downto 0);
signal SEGMENT2 : std_logic_vector(7 downto 0);
begin

-- DEVELOPE YOUR CODE HERE
BCD2seg : BCD_to_seg
port map(binary_in=>BCD_4, sev_seg=>SEGMENT2);
process(reset,clk)
begin
if reset='1' then
counter_current <=(others=>'0');
elsif rising_edge(clk) then
counter_current<=counter_next;
end if;
end process;

process(counter_current,SEGMENT2)
begin
counter_next<=counter_current+1;
DIGIT_ANODE<=(others => '0');
BCD_4<="1100";
SEGMENT<=SEGMENT2;
      if FN="0101" then
      case counter_current(19 downto 18) is
      when "00" => 
                   BCD_4<=BCD_digit16(15 downto 12);
                    DIGIT_ANODE <= "0111";
       when "01" =>
                   BCD_4<=BCD_digit16(11 downto 8);
                    DIGIT_ANODE <= "1011";  
                    SEGMENT<='0'&SEGMENT2(6 downto 0);  
       when "10" =>
                    BCD_4<=BCD_digit16(7 downto 4);
                    DIGIT_ANODE <= "1101";
       when "11" =>
                   BCD_4<=BCD_digit16(3 downto 0);
                    DIGIT_ANODE <= "1110";
       when others =>
                    BCD_4<="0000";
                    DIGIT_ANODE <= "0111";
      end case;
      else
      case counter_current(19 downto 18) is
      when "00" => 
                   if sign='1' then
                   BCD_4<="1011";
                   elsif overflow='1' then
                   BCD_4<="1111";
                   end if;
                    DIGIT_ANODE <= "0111";
       when "01" =>
                   BCD_4<="00"&BCD_digit(9 downto 8);
                    DIGIT_ANODE <= "1011";    
       when "10" =>
                    BCD_4<=BCD_digit(7 downto 4);
                    DIGIT_ANODE <= "1101";
       when "11" =>
                   BCD_4<=BCD_digit(3 downto 0);
                    DIGIT_ANODE <= "1110";
       when others =>
                    BCD_4<="0000";
                    DIGIT_ANODE <= "0111";
      end case;
      end if;
end process;
end behavioral;
    
      
   
-------------------------------------------------------------------------------------------------    

