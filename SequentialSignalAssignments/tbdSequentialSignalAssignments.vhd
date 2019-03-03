library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdSequentialSignalAssignments is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdSequentialSignalAssignments;

architecture RTL of tbdSequentialSignalAssignments is
	constant cWidth : natural := 1;
begin
	UUT_New : entity work.SequentialSignalAssignment(MuxExample_New)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA(0)    => SW(0),
			iB(0)    => SW(1),
			iCtrl => SW(2),
			oRes(0)  => LEDR(0)
		);
		
	UUT_Old : entity work.SequentialSignalAssignment(MuxExample_Old)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA(0)    => SW(0),
			iB(0)    => SW(1),
			iCtrl => SW(2),
			oRes(0)  => LEDR(1)
		);
end architecture RTL;
