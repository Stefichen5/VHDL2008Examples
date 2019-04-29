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
	--Signal assignments within a process are only allowed in 08
	Multiplex : process (iA, iB, iCtrl) is
	begin
		oRes <= iA when iCtrl='1' else iB;
	end process;
end architecture MuxExample_New;

architecture MuxExample_Old of SequentialSignalAssignment is	
begin
	--in older versions of VHDL, sequential signal assignments
	--can not be within a process
--	oRes <= iA when iCtrl='1' else iB;
	
	--or within a process with if-else
	Multiplex: process(iA, iB, iCtrl) is
	begin
		if(iCtrl='1') then
			oRes <= iA;
		else
			oRes <= iB;
		end if;
	end process;
end architecture MuxExample_Old;
