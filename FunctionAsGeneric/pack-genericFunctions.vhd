library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package PackGenericFunctions is
	function std_ulogic_and(iA: std_ulogic; iB: std_ulogic) return std_ulogic;
	function natural_plus(iA: natural; iB: natural) return natural;
end package PackGenericFunctions;

package body PackGenericFunctions is
	function std_ulogic_and(iA: std_ulogic; iB: std_ulogic) return std_ulogic is
	begin
		return iA AND iB;
	end;
	
	function natural_plus(iA: natural; iB: natural) return natural is
	begin
		return iA + iB;
	end;
end package body PackGenericFunctions;
