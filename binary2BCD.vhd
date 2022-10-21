library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

library work;
use work.ALU_components_pack.all;

entity binary2BCD is
   
   port ( binary_in : in  std_logic_vector(7 downto 0);
          BCD_out   : out std_logic_vector(9 downto 0)        
        );
end binary2BCD;

architecture structural of binary2BCD is 
   signal reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8: std_logic_vector(17 downto 0);
   component binary2BCD_com
   port ( value_in     : in  std_logic_vector(17 downto 0);
          value_out   : out  std_logic_vector(17 downto 0)
        );
   end component; 

begin  
----------------------------------------------------------------------------------------------------------------------
    reg0<="0000000000" & binary_in;
       component1: binary2BCD_com
      port map(value_in =>reg0,
      value_out=>reg1
      );
      component2: binary2BCD_com
      port map(value_in =>reg1,
      value_out=>reg2
      );
      component3: binary2BCD_com
      port map(value_in =>reg2,
      value_out=>reg3
      );
       component4: binary2BCD_com
      port map(value_in =>reg3,
      value_out=>reg4
      );
       component5: binary2BCD_com
      port map(value_in =>reg4,
      value_out=>reg5
      );
       component6: binary2BCD_com
      port map(value_in =>reg5,
      value_out=>reg6
      );
       component7: binary2BCD_com
      port map(value_in =>reg6,
      value_out=>reg7
      );
      component8: binary2BCD_com
      port map(value_in =>reg7,
      value_out=>reg8
      );
     BCD_out <=reg8(17 downto 8);
----------------------------------------------------------------------------------------------------------------------

end structural;

