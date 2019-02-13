library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package HelperPack is
	function DoSomething(argA : std_ulogic;
					argB : std_ulogic;
					argC : std_ulogic
	) return std_ulogic;
end HelperPack;

package body HelperPack is
	function DoSomething(argA : std_ulogic;
					argB : std_ulogic;
					argC : std_ulogic
	) return std_ulogic is
		variable vRes : std_ulogic;
	begin
		vRes := argA XOR argB XOR argC;
		return vRes;
	end function;	
end;