library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testcomparison is
end entity testcomparison;

architecture Bhv of testcomparison is
	signal my_signal : std_ulogic := '0';
begin
	stimul: process is
	begin
		my_signal <= '-';
		wait;
	end process;

regular_case: process is
begin
	case my_signal is
		when '-' => report "regular case: don't care detected";
		when others => report "regular case: other value detected";
	end case;

	wait until my_signal'EVENT;
end process;

matching_case: process is
begin
	case? my_signal is
		when '-' => report "matching case: don't care detected";
		when others => report "matching case: other value detected";
	end case?;

	wait until my_signal'EVENT;
end process;

end architecture Bhv;
