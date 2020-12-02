-- -------------------------------------------------------
-- This program is a running light, moving from D1 to D16
-- and back again. The frequency is best set around 50ms.
-- 12MHz clock: set breakpoint at 299999 (icebreaker)
-- 50MHz clock: set breakpoint at 124999 (de0-nano)
-- 25MHz clock: set breakpoint at 624999 (ulx3s)
-- -------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pmod_16led_2 is
port (
      clk: in STD_LOGIC;
  pmodled: out STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"
);
end pmod_16led_2;

architecture arch of pmod_16led_2 is
  signal clk_1hz: STD_LOGIC := '0';

  begin
    counter_p: process( clk, clk_1hz )
    variable  count: INTEGER := 0;
    variable countup: BIT := '1';
    variable lednum: INTEGER range 0 to 15 := 0;
    begin
      if( rising_edge(clk) ) then
	     count := count + 1;
        if( count = 624999 ) then
  	       count := 0;
	       clk_1hz <= NOT clk_1hz;
               if(countup = '1') then
                  lednum  := lednum + 1;
               end if;
               if(countup = '0') then
                  lednum := lednum -1;
               end if;
               if(lednum = 15) then
                  countup := '0';
               end if;
               if(lednum = 0) then
                  countup := '1';
               end if;
        end if;
     end if;
	 
     case lednum is
        when 0 => pmodled <= ( 0 => '1', others => '0');
        when 1 => pmodled <= ( 1 => '1', others => '0');
        when 2 => pmodled <= ( 2 => '1', others => '0');
        when 3 => pmodled <= ( 3 => '1', others => '0');
        when 4 => pmodled <= ( 4 => '1', others => '0');
        when 5 => pmodled <= ( 5 => '1', others => '0');
        when 6 => pmodled <= ( 6 => '1', others => '0');
        when 7 => pmodled <= ( 7 => '1', others => '0');
        when 8 => pmodled <= ( 8 => '1', others => '0');
        when 9 => pmodled <= ( 9 => '1', others => '0');
        when 10 => pmodled <= (10 => '1', others => '0');
        when 11 => pmodled <= ( 11 => '1', others => '0');
        when 12 => pmodled <= ( 12 => '1', others => '0');
        when 13 => pmodled <= ( 13 => '1', others => '0');
        when 14 => pmodled <= ( 14 => '1', others => '0');
        when 15 => pmodled <= ( 15 => '1', others => '0');
    end case;
  
  end process counter_p;
end arch;
