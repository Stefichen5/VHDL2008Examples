library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FunctionApplier is
	generic(type gaType;
			function my_generic_function(iA: gaType; iB: gaType) return gaType
	);
	port(
		iDataA: in gaType;
		iDataB: in gaType;
		oData: out gaType
	);
end entity FunctionApplier;

architecture RTL of FunctionApplier is
	
begin
	oData <= my_generic_function(iDataA, iDataB);
end architecture RTL;
