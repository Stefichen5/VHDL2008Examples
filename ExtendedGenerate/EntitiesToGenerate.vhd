library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EntityToGenerate is
	port(
		iA : in std_ulogic;
		iB : in std_ulogic;
		oRes:out std_ulogic
	);
end entity EntityToGenerate;

architecture RTL_And of EntityToGenerate is
begin
	oRes <= iA AND iB;
end architecture RTL_And;

architecture RTL_Or of EntityToGenerate is
begin
	oRes <= iA OR iB;
end architecture RTL_Or;

architecture RTL_Nor of EntityToGenerate is
begin
	oRes <= iA NOR iB;
end architecture RTL_Nor;

architecture RTL_Xor of EntityToGenerate is
begin
	oRes <= iA XOR iB;
end architecture RTL_XOR;