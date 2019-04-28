library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdLogicUlogic is
	port(
		CLOCK_50 : in std_logic;
		RST : in std_logic;
		SW : in std_logic_vector(9 downto 0);
		LEDR : out std_logic_vector(9 downto 0);
		BTN : in std_logic_vector(9 downto 0)
	);
end entity tbdLogicUlogic;

architecture RTL of tbdLogicUlogic is
	
begin
	DUT: entity work.RegisterSet
		port map(
			csi_clk          => CLOCK_50,
			rsi_reset_n      => RST,
			avs_s0_address   => SW(7 downto 0),
			avs_s0_write     => SW(8),
			avs_s0_writedata => BTN(7 downto 0),
			avs_s0_read      => SW(9),
			avs_s0_readdata  => LEDR(7 downto 0)
		);
end architecture RTL;
