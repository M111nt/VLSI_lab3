library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.ALU_components_pack.all;

entity binary2BCDsr is
   
   port ( binary_in : in  std_logic_vector(17 downto 0);
          BCD_out   : out std_logic_vector(15 downto 0)        
        );
end binary2BCDsr;

architecture structural of binary2BCDsr is 
   signal reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19: std_logic_vector(41 downto 0);
   signal bits : unsigned(3 downto 0);
   component binary2BCDsr_com
   port ( value_in     : in  std_logic_vector(41 downto 0);
          value_out   : out  std_logic_vector(41 downto 0)
        );
   end component; 

begin  
----------------------------------------------------------------------------------------------------------------------
    reg0<="000000000000000000000000" & binary_in;
       component1: binary2BCDsr_com
      port map(value_in =>reg0,
      value_out=>reg1
      );
      component2: binary2BCDsr_com
      port map(value_in =>reg1,
      value_out=>reg2
      );
       component3: binary2BCDsr_com
      port map(value_in =>reg2,
      value_out=>reg3
      );
       component4: binary2BCDsr_com
      port map(value_in =>reg3,
      value_out=>reg4
      );
       component5: binary2BCDsr_com
      port map(value_in =>reg4,
      value_out=>reg5
      );
       component6: binary2BCDsr_com
      port map(value_in =>reg5,
      value_out=>reg6
      );
       component7: binary2BCDsr_com
      port map(value_in =>reg6,
      value_out=>reg7
      );
       component8: binary2BCDsr_com
      port map(value_in =>reg7,
      value_out=>reg8
      );
      component9: binary2BCDsr_com
      port map(value_in =>reg8,
      value_out=>reg9
      );
       component10: binary2BCDsr_com
      port map(value_in =>reg9,
      value_out=>reg10
      );
      component11: binary2BCDsr_com
      port map(value_in =>reg10,
      value_out=>reg11
      );
      component12: binary2BCDsr_com
      port map(value_in =>reg11,
      value_out=>reg12
      );
       component13: binary2BCDsr_com
      port map(value_in =>reg12,
      value_out=>reg13
      );
       component14: binary2BCDsr_com
      port map(value_in =>reg13,
      value_out=>reg14
      );
       component15: binary2BCDsr_com
      port map(value_in =>reg14,
      value_out=>reg15
      );
       component16: binary2BCDsr_com
      port map(value_in =>reg15,
      value_out=>reg16
      );
       component17: binary2BCDsr_com
      port map(value_in =>reg16,
      value_out=>reg17
      );
       component18: binary2BCDsr_com
      port map(value_in =>reg17,
      value_out=>reg18
      );

      process(reg18) begin
      if reg18(25 downto 22)>4 then
        if reg18(29 downto 26)=9 then
          if reg18(33 downto 30)=9 then
            if reg18(37 downto 34)=9 then
               reg19(41 downto 38)<=reg18(41 downto 38)+1;
               reg19(37 downto 0)<="00000000000000000000000000000000000000";
             else
               reg19(41 downto 38)<=reg18(41 downto 38);
               reg19(37 downto 34)<=reg18(37 downto 34)+1;
               reg19(33 downto 0)<="0000000000000000000000000000000000";
             end if;
           else
             reg19(41 downto 34)<=reg18(41 downto 34);
             reg19(33 downto 30)<=reg18(33 downto 30)+1;
             reg19(29 downto 0)<="000000000000000000000000000000";
           end if;
         else
           reg19(41 downto 30)<=reg18(41 downto 30);
           reg19(29 downto 26)<=reg18(29 downto 26)+1;
           reg19(25 downto 0)<="00000000000000000000000000";
         end if;
       else
         reg19<=reg18;
       end if;
      end process;
               
       
      
     BCD_out <=reg19(41 downto 26);
----------------------------------------------------------------------------------------------------------------------

end structural;
