library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.packGenerateType.all;

entity tbdExtendedGenerate is
	port(
		SW : in std_ulogic_vector(1 downto 0);
		LEDR : out std_ulogic_vector(9 downto 0)
	);
end entity tbdExtendedGenerate;

architecture RTL of tbdExtendedGenerate is
begin
	/*
	 * Our generated entities
	 */
	
	IfElseGeneratedAnd : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentA
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(0)
		);

	IfElseGeneratedOr : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentB
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(1)
		);

	IfElseGeneratedNor : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentC
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(2)
		);

	IfElseGeneratedXor : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentD
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(3)
		);
		
	CaseGeneratedAnd : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentA
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(4)
		);

	CaseGeneratedOr : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentB
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(5)
		);

	CaseGeneratedNor : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentC
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(6)
		);

	CaseGeneratedXor : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentD
		)
		port map(
			iA   => SW(1),
			iB   => SW(0),
			oRes => LEDR(7)
		);

	LEDR(9 downto 8) <= SW(1 downto 0);
end architecture RTL;
