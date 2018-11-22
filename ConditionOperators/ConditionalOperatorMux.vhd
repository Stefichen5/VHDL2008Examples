library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ConditionalOperatorMux is
	generic (gWidth : natural := 8);
	port(
		iA : in std_ulogic_vector (gWidth-1 downto 0);
		iB : in std_ulogic_vector (gWidth-1 downto 0);
		iCtrl : in std_ulogic;
		oRes : out std_ulogic_vector(gWidth-1 downto 0)
	);
end entity ConditionalOperatorMux;

--Old way of doing it
architecture Multiplexer_Old of ConditionalOperatorMux is
begin
	Multiplex : process (iA, iB, iCtrl) is
	begin
		if iCtrl = '1' then
			oRes <= iA;
		else
			oRes <= iB;
		end if;
	end process;
end architecture Multiplexer_Old;

--New way of doing it
architecture Multiplexer_New of ConditionalOperatorMux is
begin
	Multiplex : process (iA, iB, iCtrl) is
	begin
		-- ??-operator will be applied implicitly for better readability
--		if ?? iCtrl then
		if iCtrl then
			oRes <= iA;
		else
			oRes <= iB;
		end if;
	end process;
end architecture Multiplexer_New;