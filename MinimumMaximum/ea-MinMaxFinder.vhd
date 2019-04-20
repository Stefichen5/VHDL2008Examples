library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MinMaxFinder is
	generic(gWidth : natural := 7);
	port(
		iA : in std_ulogic_vector(gWidth-1 downto 0);
		iB : in std_ulogic_vector(gWidth-1 downto 0);
		oRes: out std_ulogic_vector(gWidth-1 downto 0)
	);
end entity MinMaxFinder;

architecture Min of MinMaxFinder is
begin
	process (all) is
	begin
		oRes <= minimum(iA,iB);
	end process;
end architecture Min;

architecture Max of MinMaxFinder is
begin
	process (all) is
	begin
		oRes <= maximum(iA,iB);
	end process;
end architecture Max;
