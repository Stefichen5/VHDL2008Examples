library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbForceRelease is
end entity tbForceRelease;

architecture Bhv of tbForceRelease is	
	constant cWidth : natural := 8;
	signal iA, oA,oB : std_ulogic_vector(cWidth-1 downto 0);
begin

	uut_InternalSignals : entity work.NeverChangeOutput(InternalSignals)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA => iA,
			oA => oA
		);
	
	uut_SimpleWire : entity work.NeverChangeOutput(SimpleWire)
		generic map(
			gWidth => cWidth
		)
		port map(
			iA => iA,
			oA => oB
		);

	stimul : process is
		alias internalChangeOutput is <<signal uut_InternalSignals.ChangeOutput : std_ulogic>>;
		alias internalNewOutput is <<signal uut_InternalSignals.NewOutput : std_ulogic_vector(cWidth-1 downto 0)>>;
		
		alias ForceOutput is <<signal uut_SimpleWire.oA : std_ulogic_vector(cWidth-1 downto 0)>>;
	begin
		iA <= (others=>'0');
		wait for 5 ns;
		
		assert oA=iA report "oA has to be the same as iA" severity failure;
		assert oB=iA report "oB has to be the same as iA" severity failure;
		
		--
		internalChangeOutput <= force '1';
		internalNewOutput <= force (others=>'1');
		--
		ForceOutput <= force out (others=>'1');
		wait for 5 ns;
		
		assert oA/=iA report "oA is no longer the same as iA" severity failure;
		assert oB/=iA report "oB is no longer the same as iA" severity failure;
		wait;
	end process;

end architecture Bhv;
