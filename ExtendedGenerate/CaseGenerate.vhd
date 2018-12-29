-- In this example we use the Input-Generic to determine,
-- which entity we want to generate

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.packGenerateType.all;

entity CaseGenerate is
	generic(gToGenerate : aThingToGenerate);
	port(
		iA : in std_ulogic;
		iB : in std_ulogic;
		
		oRes : out std_ulogic
	);
end entity CaseGenerate;

architecture RTL of CaseGenerate is
begin
	MYComponentGenerator : case gToGenerate generate
		when ComponentA =>
			MyComponent : entity work.EntityToGenerate(RTL_And)
				port map(
					iA   => iA,
					iB   => iB,
					oRes => oRes
				);
		when ComponentB =>
			MyComponent : entity work.EntityToGenerate(RTL_Or)
			port map(
				iA   => iA,
				iB   => iB,
				oRes => oRes
			);
		when ComponentC =>
			MyComponent : entity work.EntityToGenerate(RTL_Nor)
			port map(
				iA   => iA,
				iB   => iB,
				oRes => oRes
			);
		when ComponentD =>
			MyComponent : entity work.EntityToGenerate(RTL_Xor)
			port map(
				iA   => iA,
				iB   => iB,
				oRes => oRes
			);
		when others => oRes <= 'X';
	end generate;
end architecture RTL;
