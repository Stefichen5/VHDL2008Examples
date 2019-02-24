library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

use work.packGenerateType.all;

entity tbExtendedGenerate is
end entity tbExtendedGenerate;

architecture Bhv of tbExtendedGenerate is
	constant cWaitTime : time := 5 ns;
	
	signal iA, iB : std_ulogic := '0';
	
	signal ElseGenerateA, ElseGenerateB, ElseGenerateC, ElseGenerateD : std_ulogic;
	signal CaseGenerateA, CaseGenerateB, CaseGenerateC, CaseGenerateD : std_ulogic;
begin
	
	/*
	 * Create input-values
	 */
	
	Stimul: process is
	begin
		iA <= '0';
		iB <= '0';
		wait for cWaitTime;
		
		iA <= '0';
		iB <= '1';
		wait for cWaitTime;
		
		iA <= '1';
		iB <= '0';
		wait for cWaitTime;	
	
		iA <= '1';
		iB <= '0';
		wait for cWaitTime;
		
		report "Simulation finished" severity note;
		
		finish;
	end process;
	
	/*
	 * Check for correct results
	 */
	
	Checks : process is
	begin
		--we have to wait so the results can be correctly passed through
		wait for 1 ns;
		
		--should loop enough times for the testbench to finish
		for i in integer'low to integer'high loop
			assert (ElseGenerateA = CaseGenerateA) report "Result from generated Else differs from generated Case" severity failure;
			assert (ElseGenerateB = CaseGenerateB) report "Result from generated Else differs from generated Case" severity failure;
			assert (ElseGenerateC = CaseGenerateC) report "Result from generated Else differs from generated Case" severity failure;
			assert (ElseGenerateD = CaseGenerateD) report "Result from generated Else differs from generated Case" severity failure;
	
			assert ElseGenerateA = (iA AND iB) report "Unexpected result" severity failure;
			assert ElseGenerateB = (iA OR iB) report "Unexpected result" severity failure;
			assert ElseGenerateC = (iA NOR iB) report "Unexpected result" severity failure;
			assert ElseGenerateD = (iA XOR iB) report "Unexpected result" severity failure;
			
			assert CaseGenerateA = (iA AND iB) report "Unexpected result" severity failure;
			assert CaseGenerateB = (iA OR iB) report "Unexpected result" severity failure;
			assert CaseGenerateC = (iA NOR iB) report "Unexpected result" severity failure;
			assert CaseGenerateD = (iA XOR iB) report "Unexpected result" severity failure;
			
			wait until iA'EVENT or iB'EVENT;
			wait for 1 ns;
		end loop;
	end process;
	
	/*
	 * Our generated entities
	 */
	
	IfElseGeneratedAnd : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentA
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => ElseGenerateA
		);

	IfElseGeneratedOr : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentB
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => ElseGenerateB
		);

	IfElseGeneratedNor : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentC
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => ElseGenerateC
		);

	IfElseGeneratedXor : entity work.ElseGenerate
		generic map(
			gToGenerate => ComponentD
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => ElseGenerateD
		);
		
	CaseGeneratedAnd : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentA
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => CaseGenerateA
		);

	CaseGeneratedOr : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentB
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => CaseGenerateB
		);

	CaseGeneratedNor : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentC
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => CaseGenerateC
		);

	CaseGeneratedXor : entity work.CaseGenerate
		generic map(
			gToGenerate => ComponentD
		)
		port map(
			iA   => iA,
			iB   => iB,
			oRes => CaseGenerateD
		);
end architecture Bhv;
