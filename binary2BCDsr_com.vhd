library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity binary2BCDsr_com is
    port ( value_in     : in  std_logic_vector(41 downto 0);
          value_out   : out  std_logic_vector(41 downto 0)
        );
end binary2BCDsr_com;

architecture behavioral of binary2BCDsr_com is
signal value:std_logic_vector(41 downto 0);
begin
   process ( value_in)
   begin
     value<=value_in;
     if(value_in(41 downto 38)>4)then
     value(41 downto 38)<=value_in(41 downto 38)+3;
     end if;
     if(value_in(37 downto 34)>4)then
     value(37 downto 34)<=value_in(37 downto 34)+3;
     end if;    
     if(value_in(33 downto 30)>4)then
     value(33 downto 30)<=value_in(33 downto 30)+3;
     end if;
     if(value_in(29 downto 26)>4)then
     value(29 downto 26)<=value_in(29 downto 26)+3;
     end if;    
     if(value_in(25 downto 22)>4)then
     value(25 downto 22)<=value_in(25 downto 22)+3;
     end if;
     if(value_in(21 downto 18)>4)then
     value(21 downto 18)<=value_in(21 downto 18)+3;
     end if;    
   end process;
   process(value)
   begin
   value_out<=value(40 downto 0) & '0';
   end process;              
end behavioral;