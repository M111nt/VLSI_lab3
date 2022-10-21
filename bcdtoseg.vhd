library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity BCD_to_seg is
    port (
	     binary_in : in std_logic_vector(3 downto 0);
	     sev_seg   : out  std_logic_vector(7 downto 0)
	 );
end BCD_to_seg;

architecture binary_to_sg_arch of BCD_to_seg is
signal sev_seg_value :   std_logic_vector( 7 downto 0):=(others => '0');
begin

combinational : process (binary_in)
begin 
  case binary_in is
    when "0000" =>
      sev_seg_value<="11000000";
    when "0001" =>
      sev_seg_value<="11111001";
    when "0010" =>
      sev_seg_value<="10100100";
   when "0011" =>
      sev_seg_value<="10110000";
    when "0100" =>
      sev_seg_value<="10011001";
    when "0101" =>
      sev_seg_value<="10010010";
    when "0110" =>
      sev_seg_value<="10000010";
    when "0111" =>
      sev_seg_value<="11111000";
    when "1000" =>
      sev_seg_value<="10000000";
    when "1001" =>
      sev_seg_value<="10010000";
    when "1010" =>
      sev_seg_value<="10000110";
    when "1011" =>
      sev_seg_value<="10111111";
    when "1111" =>
      sev_seg_value<="10001110";
    when others =>
      sev_seg_value<="11111111";
end case;
end process;    


sev_seg <= sev_seg_value;
end binary_to_sg_arch;
