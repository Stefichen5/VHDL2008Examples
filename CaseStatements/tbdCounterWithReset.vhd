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
	signal Data : std_ulogic_vector(cWidth-1 downto 0);
begin
	UUT : entity work.CounterWithReset
		generic map(
			gWidth => 14
		)
		port map(
			iClk       => iClk,
			inRstAsync => inRstAsync,
			iCtrl      => SW,
			oData      => Data
		);
		
		HEX0 <= Data(6 downto 0);
		HEX1 <= Data(13 downto 7);
end architecture RTL;
