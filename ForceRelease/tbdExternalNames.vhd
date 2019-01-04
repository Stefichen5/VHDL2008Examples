library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdExternalNames is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdExternalNames;

architecture RTL of tbdExternalNames is
begin
	UUT: entity work.NeverChangeOutput(InternalSignals)
		generic map(
			gWidth => SW'HIGH+1
		)
		port map(
			iA => SW,
			oA => LEDR
		);
		
	<<signal UUT.NewOutput : std_ulogic_vector(LEDR'RANGE)>> <= NOT SW;
	<<signal UUT.InternalSignals.ChangeOutput : std_ulogic>> <= '1';
		
end architecture RTL;
