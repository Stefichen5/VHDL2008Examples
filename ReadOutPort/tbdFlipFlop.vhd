library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdFlipFlop is
	port(
		iClk : in std_ulogic;
		inRstAsync : in std_ulogic;
		SW : in std_ulogic;
		LEDR : out std_ulogic_vector(3 downto 0)
	);
end entity tbdFlipFlop;

architecture RTL of tbdFlipFlop is
	
begin
	UUT_new : entity work.FlipFlop(RTL_new)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iD         => SW,
			oQ         => LEDR(0),
			onQ        => LEDR(1)
		);
		
	UUT_old : entity work.FlipFlop(RTL_old)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iD         => SW,
			oQ         => LEDR(2),
			onQ        => LEDR(3)
		);
end architecture RTL;
