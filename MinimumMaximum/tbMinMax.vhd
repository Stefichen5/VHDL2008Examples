library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbMinMax is
end entity tbMinMax;

architecture Bhv of tbMinMax is
	constant cWaitTime : time := 5 ns;
	
	signal iA, iB, oResMin, oResMax : std_ulogic_vector(7 downto 0) := (others =>'0');
begin
	UUTMin : entity work.MinMaxFinder(Min)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => oResMin
		);
		
	UUTMax : entity work.MinMaxFinder(Max)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => oResMax
		);
	
	Stimul : process is
	begin
		iA  <= (others => '0');
		iB <= (others  => '0');
		wait for cWaitTime;
		
		assert oResMin = oResMax report "Outputs should be the same because inputs are the same" severity warning;
		
		iA <= "00000010";
		
		wait until oResMax'EVENT;
		
		assert oResMax = iA report "oResMax is wrong value" severity failure;
		assert oResMin = iB  report "oResMin is wrong value" severity failure;
		
		iB <= "10000000" after cWaitTime;
		
		wait until oResMax'EVENT;
		
		assert oResMax = iB report "oResMax is wrong value" severity failure;
		assert oResMin = iA  report "oResMin is wrong value" severity failure;
		
		wait for cWaitTime;
		
		finish;
	end process;

end architecture Bhv;
