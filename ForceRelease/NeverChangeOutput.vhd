library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NeverChangeOutput is
	generic (gWidth : natural := 8);
	port(
		iA : in std_ulogic_vector(gWidth-1 downto 0);
		oA : out std_ulogic_vector(gWidth-1 downto 0)
	);
end entity NeverChangeOutput;

architecture InternalSignals of NeverChangeOutput is
	signal ChangeOutput : std_ulogic := '0';
	signal NewOutput	: std_ulogic_vector(gWidth-1 downto 0);
begin
	SignalToOutput : process (all) is
	begin
		if ChangeOutput='1' then
			oA <= NewOutput;
		else
			oA <= iA;
		end if;
	end process;
end architecture InternalSignals;

architecture SimpleWire of NeverChangeOutput is
begin
	oA <= iA;
end architecture SimpleWire;