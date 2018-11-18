library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbConditionalOperatorMux is
end entity tbConditionalOperatorMux;

architecture Bhv of tbConditionalOperatorMux is
	constant cWidth : natural := 8;
	signal iA, iB, oResOldStyle, oResNewStyle : std_ulogic_vector(cWidth-1 downto 0);
	signal iCtrl : std_ulogic;
begin
	UUT_muxOld : entity work.ConditionalOperatorMux(Multiplexer_Old)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA    => iA,
			iB    => iB,
			iCtrl => iCtrl,
			oRes  => oResOldStyle
		);
		
		UUT_muxNew : entity work.ConditionalOperatorMux(Multiplexer_New)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA    => iA,
			iB    => iB,
			iCtrl => iCtrl,
			oRes  => oResNewStyle
		);
		
	stimul: process is
	begin
		iA <= (others=>'0');
		iB <= (others=>'0');
		iCtrl <= '0';
		wait for 5 ns;
		
		iB <= (others=>'1');
		wait for 5 ns;
		
		assert oResOldStyle = oResNewStyle report "Old and new Mux have produced different results" severity failure;
		assert oResOldStyle = iB report "Output should be iB, but is not" severity failure;
		
		iCtrl <= '1';
		wait for 5 ns;
		assert oResOldStyle = oResNewStyle report "Old and new Mux have produced different results" severity failure;
		assert oResOldStyle = iA report "Output should be iA, but is not" severity failure;

		wait;
	end process;
end architecture Bhv;
