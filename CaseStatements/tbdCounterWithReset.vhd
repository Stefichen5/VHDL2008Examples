library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdCounterWithReset is
	port(
	iClk         : in  std_ulogic; -- DE1-SoC: CLOCK_50
    inRstAsync   : in  std_ulogic; -- DE1-Soc: SW[9]
    --
    SW           : in  std_ulogic_vector(2 downto 0);
    --
    HEX0         : out std_ulogic_vector(6 downto 0);
    HEX1         : out std_ulogic_vector(6 downto 0)
	);
end entity tbdCounterWithReset;

architecture RTL of tbdCounterWithReset is
	constant cWidth : natural := 14;
begin
	UUT_new : entity work.CounterWithReset(Rtl_new)
		generic map(
			gWidth => cWidth/2
		)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iCtrl      => SW,
			oData      => HEX0
		);
		
	UUT_old : entity work.CounterWithReset(Rtl_old)
		generic map(
			gWidth => cWidth/2
		)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iCtrl      => SW,
			oData      => HEX1
		);
		
end architecture RTL;
