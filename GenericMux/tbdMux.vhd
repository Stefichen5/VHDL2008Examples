library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdMux is
	port(
		SW : in std_ulogic_vector(9 downto 0);
		LEDR: out std_ulogic_vector(9 downto 0)
	);
end entity tbdMux;

architecture RTL of tbdMux is
	alias SelSwitch is SW(SW'HIGH);
	
	type aCustomType is (PossibleValueA, PossibleValueB, PossibleValueC, PossibleValueD);
	signal iA_custom, iB_custom, oRes_custom : aCustomType;
	
	signal iA_natural, iB_natural, oRes_natural : natural;
begin
	Mux_ulogic : entity work.GenericMux
		generic map(gaMuxType => std_ulogic)
		port map(
			iA   => SW(0),
			iB   => SW(1),
			oRes => LEDR(0),
			iSel => SelSwitch
		);
		
	Mux_Natural : entity work.GenericMux
		generic map(gaMuxType => natural)
		port map(
			iA   => iA_natural,
			iB   => iB_natural,
			oRes => oRes_natural,
			iSel => SelSwitch
		);
	
	Mux_Custom : entity work.GenericMux
		generic map(gaMuxType => aCustomType)
		port map(
			iA   => iA_custom,
			iB   => iB_custom,
			oRes => oRes_custom,
			iSel => SelSwitch
		);
		
	iA_natural <= 15;
	iB_natural <= 3;
	
	LEDR(4 downto 1) <= std_ulogic_vector(to_unsigned(oRes_natural,4));
		
	iA_custom <= PossibleValueA;
	iB_custom <= PossibleValueB;
		
	LEDR(8 downto 7) <= "00" when oRes_custom=PossibleValueA 
					else "01" when oRes_custom=PossibleValueB
					else "10" when oRes_custom=PossibleValueC
					else "11";
end architecture RTL;
