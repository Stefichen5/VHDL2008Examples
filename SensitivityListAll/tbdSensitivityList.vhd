library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tbdSensitivityList is
	port(
		SW : in std_ulogic_vector(3 downto 0);
		LEDR : out std_ulogic_vector(1 downto 0)
	);
end entity tbdSensitivityList;

architecture RTL of tbdSensitivityList is
	
begin
	UUT_new : entity work.SensitivityList(Rtl_New)
	port map(
		iA   => SW(0),
		iB   => SW(1),
		iC   => SW(2),
		oRes => LEDR(0)
	);

	UUT_old : entity work.SensitivityList(Rtl_Old)
		port map(
		iA   => SW(0),
		iB   => SW(1),
		iC   => SW(2),
		oRes => LEDR(1)
		);	
	
end architecture RTL;
