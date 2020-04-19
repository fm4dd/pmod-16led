library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pmod_16led_2 is
port (
       clk: in STD_LOGIC;
  pmodled1: out STD_LOGIC_VECTOR(0 to 7) := "00000000";
  pmodled2: out STD_LOGIC_VECTOR(0 to 7) := "00000000"
);
end pmod_16led_2;

architecture arch of pmod_16led_2 is
  signal clk_1hz: STD_LOGIC := '0';
  signal  lednum1: STD_LOGIC_VECTOR(6 downto 0) := "0000000";
  signal  lednum2: STD_LOGIC_VECTOR(7 downto 0) := "00000000";

  begin
    counter_p: process( clk, clk_1hz, lednum1, lednum2 )
    variable count: INTEGER := 0;
    begin
      if( rising_edge(clk) ) then
	     count := count + 1;
        if( count = 24999999 ) then
  	       count := 0;
	       clk_1hz <= NOT clk_1hz;
	   	 lednum1 <= std_logic_vector( unsigned(lednum1) + 1);
			 lednum2 <= std_logic_vector( unsigned(lednum2) + 1);
        end if;
	   end if;
	 
    pmodled1(0) <= clk_1hz;
    pmodled1(1) <= lednum1(6);
    pmodled1(2) <= lednum1(5);
    pmodled1(3) <= lednum1(4);
    pmodled1(4) <= lednum1(3);
    pmodled1(5) <= lednum1(2);
    pmodled1(6) <= lednum1(1);
    pmodled1(7) <= lednum1(0);
	 
	 pmodled2 <= lednum2;
  
  end process counter_p;
end arch;