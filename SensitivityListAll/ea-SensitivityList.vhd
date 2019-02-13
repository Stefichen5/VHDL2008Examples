library ieee;
use ieee.std_logic_1164.all;
use work.HelperPack.all;

entity SensitivityList is
	port(
		iA : in std_ulogic;
		iB : in std_ulogic;
		iC : in std_ulogic;
		oRes:out std_ulogic
	);
end entity SensitivityList;

--new way of doing it
architecture RTL_New of SensitivityList is
begin
	process (all) is
	begin
		oRes <= DoSomething(iA, iB, iC);
	end process;
end architecture RTL_New;

-- old way of doing it
architecture RTL_Old of SensitivityList is
begin
	-- don't forget any signals here or your result might be wrong
	process (iA, iB, iC) is
	begin
		oRes <= DoSomething(iA, iB, iC);
	end process;
end architecture RTL_Old;