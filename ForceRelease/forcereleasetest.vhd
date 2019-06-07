library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity forcereleasetest is
end entity forcereleasetest;

architecture Bhv of forcereleasetest is
	signal mySignal : std_ulogic := '0';
begin
	
	Stimul : process is
	begin
		mySignal <= '1' after 5 ns, '0' after 10 ns, '1' after 20 ns;
		wait for 50 ns;
		finish;
	end process;

	ForceTest: process is
	begin
		wait for 6 ns;
		mySignal <= force 'X';
		wait for 1 ns;
		mySignal <= release;
		wait;
	end process;

end architecture Bhv;
