library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbSequentialSignalAssignments is
end entity tbSequentialSignalAssignments;

architecture RTL of tbSequentialSignalAssignments is
	constant cWidth : natural := 8;
	signal iA, iB, oResA, oResB : std_ulogic_vector (cWidth-1 downto 0);
	signal iCtrl : std_ulogic;
begin
	UUT_New : entity work.SequentialSignalAssignment(MuxExample_New)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA    => iA,
			iB    => iB,
			iCtrl => iCtrl,
			oRes  => oResA
		);
		
	UUT_Old : entity work.SequentialSignalAssignment(MuxExample_Old)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA    => iA,
			iB    => iB,
			iCtrl => iCtrl,
			oRes  => oResB
		);
		
	stimul : process is
	begin
		iA <= (others=>'0');
		iB <= (others=>'0');
		iCtrl <= '0';
		wait for 5 ns;
		
		iA <= (others=>'1');
		wait for 5 ns;
		
		assert oResA = oResB report "Old and new implementation have different outputs" severity failure;
		wait;
	end process;
end architecture RTL;
