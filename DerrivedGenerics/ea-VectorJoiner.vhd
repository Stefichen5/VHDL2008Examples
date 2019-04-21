library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VectorJoiner is
	generic(gInLength : natural;
			gOutLength : natural := 2*gInLength;
			cResetVal : std_ulogic_vector(gOutLength-1 downto 0) := (others=> '0')
	);
	port(
		inReset : in std_ulogic;
		iA : in std_ulogic_vector(gInLength-1 downto 0);
		iB : in std_ulogic_vector(gInLength-1 downto 0);
		oAB: out std_ulogic_vector(gOutlength-1 downto 0)
	);
end entity VectorJoiner;

architecture RTL of VectorJoiner is	
begin
	oAB <= iA & iB when inReset else cResetVal;
end architecture RTL;
