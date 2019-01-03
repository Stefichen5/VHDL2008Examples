library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package packStateMachine is
	type aFSMDType is (StateA, StateB, StateC);
	type aDataType is record
		Data : std_ulogic_vector(9 downto 0);
		Ctrl : std_ulogic_vector(2 downto 0);
		state: aFSMDType;
		outData : std_ulogic_vector(9 downto 0);
	end record;
	
	constant cInitVal : aDataType := (
		Data => (others =>'0'),
		Ctrl => (others => '0'),
		state => StateA,
		outData => (others => '0')
	);
	
	--Check if we can go to the next state
	function CheckCondition (Data : aDataType) return std_ulogic;
	
	--Return the next state
	function NextState (state : aFSMDType) return aFSMDType;
end package packStateMachine;

package body packStateMachine is
	function CheckCondition (Data : aDataType) return std_ulogic is
		variable vResult : std_ulogic;
	begin
		vResult := '0';
		
		if (Data.state = StateA) AND (Data.Ctrl = "001") then
			vResult := '1';
		elsif (Data.state = StateB) AND (Data.Ctrl = "010") then
			vResult := '1';
		elsif (Data.state = StateC) AND (Data.Ctrl = "100") then
			vResult := '1';
		end if;
		
		return vResult;
	end function;
	
	function NextState (state : aFSMDType) return aFSMDType is
		variable vResult : aFSMDType;
	begin
		case state is
			when StateA => vResult := StateB;
			when StateB => vResult := StateC;
			when StateC => vResult := StateA;
			when others => vResult := StateA;
		end case;
		
		return vResult;
	end function;	
end package body packStateMachine;
