library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.packGenericSubprogram.all;
use work.packStateMachine.all;

entity StateMachine is
	port(
		iClk : in std_ulogic;
		inResAsync : in std_ulogic;
		
		iData : in std_ulogic_vector(9 downto 0);
		
		iCtrl : in std_ulogic_vector(2 downto 0);
		
		oData : out std_ulogic_vector(9 downto 0)
	);
end entity StateMachine;

architecture RTL of StateMachine is

	-- Here we instanciate the generic function
	-- We pass it our current state, current data and the two functions
	function RunStateMachine is new work.packGenericSubprogram.RunStateMachine
		generic map(gAStateType => aFSMDType,
			gAParameter => aDataType,
			CheckConditionForNextState => CheckCondition,
			NextState => NextState
		);
		
	signal Data, DataNext : aDataType;
begin
	
	process(iClk, inResAsync) is
	begin
		if(inResAsync='0') then
			Data <= cInitVal;
		elsif (rising_edge(iClk)) then
			Data <= DataNext;
		end if;
	end process;

	FSMD : process(all) is
	begin
		
		DataNext.state <= Data.state;
		DataNext.outData <= Data.outData;
		
		case Data.state is
			when StateA => DataNext.outData <= std_ulogic_vector(shift_left(unsigned(Data.Data), 1));
			when StateB => DataNext.outData <= std_ulogic_vector(shift_right(unsigned(Data.Data), 2));
			when StateC => DataNext.outData <= std_ulogic_vector(shift_left(unsigned(Data.Data), 3));
			when others => DataNext.outData <= (others =>'0');
		end case;
		
		--run our generic function
		DataNext.state <= RunStateMachine(Data.state, Data);
	end process;

	DataNext.Data <= iData;
	DataNext.Ctrl <= iCtrl;
	
	oData <= Data.outData;

end architecture RTL;
