library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package packGenericSubprogram is
	--Checks if conditions for next state were met
	--and changes to the next state (if conditions are met)
	function RunStateMachine
		generic (type gAStateType;
				type gAParameter;
			function CheckConditionForNextState (param : in gAParameter) return std_ulogic;
			function NextState(curState : in gAStateType) return gAStateType
		)
	(CurState : in gAStateType; Data : gAParameter) return gAStateType;
end package packGenericSubprogram;

package body packGenericSubprogram is
	function RunStateMachine
		generic (type gAStateType;
			type gAParameter;
			function CheckConditionForNextState (param : in gAParameter) return std_ulogic;
			function NextState(curState : in gAStateType) return gAStateType
		)
		(CurState : in gAStateType; Data : gAParameter) return gAStateType is
		
		variable vNextState : gAStateType;
	begin
		vNextState := CurState;
		
		if CheckConditionForNextState(Data) = '1'  then
			vNextState := NextState(CurState);
		end if;
		
		return vNextState;
	end function;

end package body packGenericSubprogram;
