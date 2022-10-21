----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2021 10:50:45 PM
-- Design Name: 
-- Module Name: square_root_function - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity square_root is
    port(  clk     : in  std_logic;
           reset   : in  std_logic;
           A       : in  std_logic_vector(7 downto 0);
           FN      : in  std_logic_vector (3 downto 0);
           result  : out std_logic_vector (17 downto 0)
            );
end square_root;

architecture behavioral of square_root is

    signal A_r,A_o,A_minus:unsigned (7 downto 0 );
    signal A_4b           :unsigned (3 downto 0 );
    signal flag          :std_logic;
    signal Xn1,Xn2,Xn3   :unsigned(17 downto 0);
    signal Xn4           :unsigned(35 downto 0);
    signal Xn4_c         :unsigned(35 downto 0);
    signal Xn4_n         :unsigned(35 downto 0);
    signal Xn5           :unsigned(27 downto 0);
    signal Xn6           :unsigned(71 downto 0);
    signal Xn6_c,Xn6_c2         :unsigned(71 downto 0);
    signal Xn6_n         :unsigned(71 downto 0);
    signal counter1_out  :std_logic_vector(35 downto 0);
    signal counter1_out_n:std_logic_vector(35 downto 0);
    signal counter2_out  :std_logic_vector(35 downto 0);
    signal counter2_out_n:std_logic_vector(35 downto 0);
    signal counter2_begin:std_logic;
    signal Xout          :std_logic_vector(13 downto 0);
    signal result_temp1   :unsigned(35 downto 0);
    signal result_temp2   :unsigned(35 downto 0);
    signal Xout1,Xout2,Xout3,Xout4,Xout5,Xout6,Xout7,Xout8,Xout9,Xout10,Xout11,Xout12,Xout13,Xout14:std_logic_vector(17 downto 0);
    constant w1        :unsigned(17 downto 0) := "000000000000001001";--9
    constant w2        :unsigned(17 downto 0) := "000000000000010011";--19
    constant w3        :unsigned(17 downto 0) := "000000000000100111";--39
    constant w4        :unsigned(17 downto 0) := "000000000001001110";--78
    constant w5        :unsigned(17 downto 0) := "000000000010011100";--156
    constant w6        :unsigned(17 downto 0) := "000000000100111001";--313
    constant w7        :unsigned(17 downto 0) := "000000001001110001";--625
    constant w8        :unsigned(17 downto 0) := "000000010011100010";--1250
    constant w9        :unsigned(17 downto 0) := "000000100111000100";--2500
    constant w10       :unsigned(17 downto 0) := "000001001110001000";--5000
    constant w11       :unsigned(17 downto 0) := "000010011100010000";--10000
    constant w12        :unsigned(17 downto 0) :="000100111000100000";--20000
    constant w13       :unsigned(17 downto 0) := "001001110001000000";--40000
    constant w14      :unsigned(17 downto 0) :=  "010011100010000000";--80000
   
    
    
   begin
       A_r <= unsigned(A);
       counter1: process(clk, reset)  --the first newton method result
        begin
            if reset = '1' then
                counter1_out <= (others => '0');        
            elsif rising_edge(clk) then
                counter1_out <= counter1_out_n;
                Xn4          <= Xn4_n;
            end if;   
        end process;
        counter2: process(clk,reset)  --the second newton method result
        begin
            if  reset = '1' then
                counter2_out <= (others => '0');
            elsif rising_edge(clk) then
                counter2_out <= counter2_out_n;
                Xn6          <= Xn6_n;
                Xn6_c2       <=Xn6_c;
            end if;
        end process;
       square_root: process(A_r, A_o,Xn1,Xn2,Xn3,Xn5)
       begin
         --square root of A       
            if A_r = 0 then 
                A_o <= (others => '0');
            elsif A_r > 0 and A_r < 4 then
                A_o <= "00000001";
            elsif A_r > 3 and A_r < 9 then
                A_o <= "00000010";
            elsif A_r > 8 and A_r < 16 then
                A_o <= "00000011";
            elsif A_r > 15 and A_r < 25 then
                A_o <= "00000100";
            elsif A_r > 24 and A_r < 36 then
                A_o <= "00000101";
            elsif A_r > 35 and A_r < 49 then
                A_o <= "00000110";    
            elsif A_r > 48 and A_r < 64 then
                A_o <= "00000111";    
            elsif A_r > 63 and A_r < 81 then
                A_o <= "00001000";
            elsif A_r > 80 and A_r < 100 then
                A_o <= "00001001";    
            elsif A_r > 99 and A_r < 121 then
                A_o <= "00001010";
            elsif A_r > 120 and A_r < 144 then
                A_o <= "00001011";        
            elsif A_r > 143 and A_r < 169 then
                A_o <= "00001100";
            elsif A_r > 168 and A_r < 196 then
                A_o <= "00001101";    
            elsif A_r > 195 and A_r < 225 then
                A_o <= "00001110";        
            elsif A_r > 224 and A_r < 256 then
                A_o <= "00001111";
            end if;
            Xn1  <= A_o & "0000000000"; --1024Xn
            Xn2  <= "0000000000" & A_o;  --Xn
            Xn3  <=  A_r & "0000000000" ;   --1024a
            Xn4_c<= (Xn3 + Xn1*Xn2);
            Xn5  <= A_r & "00000000000000000000" ;
        end process;
        A_4b <= A_o(3 downto 0);
        A_minus <= A_r - A_4b*A_4b;
        flag <= '0' when (A_minus = "00000000") else '1';
        Xout <=  counter2_out(13 downto 0)  ;
        Xout1<= "00000000000000000" & Xout(0);
        Xout2<= "00000000000000000" & Xout(1);
        Xout3<= "00000000000000000" & Xout(2);
        Xout4<= "00000000000000000" & Xout(3);
        Xout5<= "00000000000000000" & Xout(4);
        Xout6<= "00000000000000000" & Xout(5);
        Xout7<= "00000000000000000" & Xout(6);
        Xout8<= "00000000000000000" & Xout(7);
        Xout9<= "00000000000000000" & Xout(8);
        Xout10<="00000000000000000" & Xout(9);
        Xout11<="00000000000000000" & Xout(10);
        Xout12<="00000000000000000" & Xout(11);
        Xout13<="00000000000000000" & Xout(12);
        Xout14<="00000000000000000" & Xout(13);   
        result_temp1 <= unsigned(Xout1)* w1 + unsigned(Xout2)* w2+ unsigned(Xout3)* w3+ unsigned(Xout4)* w4  --add the number together to recover the square root
                  + unsigned(Xout5)* w5+ unsigned(Xout6)* w6+ unsigned(Xout7)* w7+ unsigned(Xout8)* w8+ unsigned(Xout9)* w9
                  + unsigned(Xout10)* w10 + unsigned(Xout11)* w11 +unsigned(Xout12)* w12 +unsigned(Xout13)* w13 +unsigned(Xout14)* w14 when flag = '1' else
                   result_temp2; 
        result_temp2 <= Xn2 * w11; --if the square root result is an integer number 
        result <= "000011011100111110" when FN = "0101" and A= "00000010" else
                 "000100001110101000" when FN = "0101" and A= "00000011" else
                 "000101011101011000" when FN = "0101" and A= "00000101" else
                std_logic_vector(result_temp1(17 downto 0)) when FN = "0101" else "000000000000000000";-- output the result with 18 bits
           --counter part(division)------------------------------------------------------------
           
        counter1_out_n <= counter1_out + 1  when Xn4 >= (Xn2 + Xn2)  else counter1_out; -- using subtraction to instead of divide
        Xn4_n          <= Xn4_c             when (counter1_out < 2)  else
                          (Xn4 - Xn2 - Xn2)  when Xn4 >= (Xn2 + Xn2)  else 
                           Xn4;
        counter2_begin <= '0' when Xn4 >= (Xn2 + Xn2) else '1';
        Xn6_c          <= unsigned(counter1_out)*unsigned(counter1_out) + Xn5; -- (Xn4*Xn4 + Xn5)/(Xn4 + Xn4);                 
        Xn6_n          <= Xn6_c2                                                when (counter2_begin = '0')                                else
                          Xn6 - (unsigned(counter1_out)+unsigned(counter1_out)) when Xn6 >(unsigned(counter1_out)+unsigned(counter1_out))  else
                          Xn6;
        counter2_out_n <= (others => '0')  when (counter2_begin = '0')                               else
                          counter2_out + 1 when Xn6 >(unsigned(counter1_out)+unsigned(counter1_out)) else counter2_out;                  
                   
end behavioral;
