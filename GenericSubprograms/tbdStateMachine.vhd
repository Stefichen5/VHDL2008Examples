library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdStateMachine is
	port(
		iClk : in std_ulogic;
		inResAsync : in std_ulogic;
		SW : in std_ulogic_vector(9 downto 0);
		KEY : in std_ulogic_vector(2 downto 0);
		
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdStateMachine;

architecture RTL of tbdStateMachine is
	
begin
	UUT : entity work.StateMachine
		port map(
			iClk       => iClk,
			inResAsync => inResAsync,
			iData      => SW,
			iCtrl      => KEY,
			oData      => LEDR
		);
end architecture RTL;
