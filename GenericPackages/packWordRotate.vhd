library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package packWordRotate is
	generic (gWordLen, gNrWords : natural);
	
	constant cWidth : natural := (gWordLen * gNrWords);
	
	function RotateLeft(signal InVect : std_ulogic_vector(cWidth-1 downto 0)) return std_ulogic_vector;
end package packWordRotate;

package body packWordRotate is
	/*
	 * This function rotates an array word-wise
	 * For example:
	 * In: AA_BB_CC_DD
	 * Out: BB_CC_DD_AA
	 */	
	function RotateLeft(signal InVect : std_ulogic_vector(cWidth-1 downto 0)) return std_ulogic_vector is
		variable vRetVect : std_ulogic_vector(InVect'RANGE);
	begin
		
		for i in (InVect'HIGH+1)/gWordLen downto 2 loop
			vRetVect(i*gWordLen-1 downto (i-1)*gWordLen) := InVect((i-1)*gWordLen-1 downto (i-2)*gWordLen);
		end loop;
		
		vRetVect(gWordLen-1 downto 0) := InVect(InVect'HIGH downto InVect'HIGH-gWordLen+1);
		
		return vRetVect;
	end function;
end package body packWordRotate;
