library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SequentialSignalAssignment is
	generic (gWidth : natural := 8);
	port(
		iA : in std_ulogic_vector(gWidth-1 downto 0);
		iB : in std_ulogic_vector(gWidth-1 downto 0);
		iCtrl : in std_ulogic;
		oRes : out std_ulogic_vector(gWidth-1 downto 0)
	);
end entity SequentialSignalAssignment;

architecture MuxExample_New of SequentialSignalAssignment is	
begin
	Multiplex : process (iA, iB, iCtrl) is
	begin
		--Signal assignments within a process are only allowed in 08
		oRes <= iA when iCtrl else iB;
	end process;
end architecture MuxExample_New;

architecture MuxExample_Old of SequentialSignalAssignment is	
begin
	--in older versions of VHDL, sequential signal assignments
	--can not be within a process
	oRes <= iA when iCtrl='1' else iB;
end architecture MuxExample_Old;
