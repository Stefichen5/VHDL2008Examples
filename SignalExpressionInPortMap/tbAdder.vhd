library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.all;

entity tbAdder is
end entity tbAdder;

architecture Bhv of tbAdder is
	constant cWidth : natural := 10;
	
	signal iA, iB : std_ulogic_vector (cWidth-1 downto 0) := (others =>'0');
	signal iAReady, iBReady : std_ulogic := '0';
	signal oRes : integer;
begin
	UUT : entity work.InstanceOfAdder
		generic map(
			gWidth => cWidth
		)
		port map(
			iA      => iA,
			iB      => iB,
			iAReady => iAReady,
			iBReady => iBReady,
			oRes    => oRes
		);
		
	stimul : process
	begin
		wait for 0 ns;
		
		assert oRes = 0 report "Result should be 0" severity failure;
		
		iA <= std_ulogic_vector(to_unsigned(10,cWidth));
		iAReady <= '1';
		
		wait for 5 ns;
		
		assert oRes = 0 report "Result should be 0" severity failure;

		iB <= std_ulogic_vector(to_unsigned(20,cWidth));		

		wait for 5 ns;
		
		assert oRes = 0 report "Result should be 0" severity failure;
		
		iBReady <= '1';
		wait until oRes'EVENT;
		
		assert oRes = 10+20 report "Result is wrong" severity failure;
		
		iA <= std_ulogic_vector(to_unsigned(123,cWidth));
		iB <= std_ulogic_vector(to_unsigned(456,cWidth));
		
		wait until oRes'EVENT;
		
		assert oRes = 123+456 report "Result is wrong" severity failure;
		
		report "Simulation finished" severity note;
		finish;
	end process;

end architecture Bhv;
