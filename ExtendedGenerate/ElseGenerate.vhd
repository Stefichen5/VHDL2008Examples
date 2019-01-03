-- In this example we use the Input-Generic to determine,
-- which entity we want to generate

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.packGenerateType.all;

entity ElseGenerate is
	generic(gToGenerate : aThingToGenerate);
	port(
		iA : in std_ulogic;
		iB : in std_ulogic;
		
		oRes : out std_ulogic
	);
end entity ElseGenerate;

architecture RTL of ElseGenerate is
begin
	MYComponentGenerator: if gToGenerate = ComponentA generate
		MyComponent : entity work.EntityToGenerate(RTL_And)
			port map(
				iA   => iA,
				iB   => iB,
				oRes => oRes
			);
	elsif gToGenerate = ComponentB generate
		MyComponent : entity work.EntityToGenerate(RTL_Or)
			port map(
				iA   => iA,
				iB   => iB,
				oRes => oRes
			);
	elsif gToGenerate = ComponentC generate
		MyComponent : entity work.EntityToGenerate(RTL_Nor)
			port map(
				iA   => iA,
				iB   => iB,
				oRes => oRes
			);
	elsif gToGenerate = ComponentD generate
		MyComponent : entity work.EntityToGenerate(RTL_Xor)
			port map(
				iA   => iA,
				iB   => iB,
				oRes => oRes
			);
	else generate
		oRes <= 'X';
	end generate;
end architecture RTL;
