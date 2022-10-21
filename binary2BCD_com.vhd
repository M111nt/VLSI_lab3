library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity binary2BCD_com is
    port ( value_in     : in  std_logic_vector(17 downto 0);
          value_out   : out  std_logic_vector(17 downto 0)
        );
end binary2BCD_com;

architecture behavioral of binary2BCD_com is
signal value:std_logic_vector(17 downto 0);
begin
   process ( value_in)
   begin
     value<=value_in;
     if(value_in(15 downto 12)>4)then
     value(15 downto 12)<=value_in(15 downto 12)+3;
     end if;
     if(value_in(11 downto 8)>4)then
     value(11 downto 8)<=value_in(11 downto 8)+3;
     end if;    
   end process;
   process(value)
   begin
   value_out<=value(16 downto 0) & '0';
   end process;              
end behavioral;