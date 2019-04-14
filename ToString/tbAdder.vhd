library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbAdder is
end entity tbAdder;

architecture Bhv of tbAdder is
	constant cWaitTime : time := 5 ns;
	
	signal iClk, inResAsync : std_ulogic := '0';
	signal iA, iB, oRes : natural := 0;
	
	type aCustomType is (ValueA, ValueB, ValueC);
	signal CustomSignal: aCustomType := ValueA;
	signal ulogicbit : std_ulogic := '1';
	signal ulogicvect : std_ulogic_vector(7 downto 0) := "11111111";
begin
	UUT: entity work.Adder
		port map(
			iA   => iA,
			iB   => iB,
			oRes => oRes
		);
		
	Stimul : process is
	begin
		iA <= 123;
		iB <= 456;
		wait until oRes'EVENT;
		
		report to_string(iA) & " + " & to_string(iB) & " = " & to_string(oRes);
		
		iA <= 1;
		iB <= 2;
		wait until oRes'EVENT;
		
		assert oRes = 3 report to_string(iA) & " + " & to_string(iB) & " is " & to_string(oRes) & " but should be 3" severity error;
			
		finish;
	end process;
	
	--use to_string for different data types
	print: process is
	begin
		report to_string(CustomSignal);
		report to_string(ulogicbit);
		report to_string(ulogicvect);
		report to_hstring(ulogicvect);
		report to_ostring(ulogicvect);		
		wait;
	end process;
end architecture Bhv;
