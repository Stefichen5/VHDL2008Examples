entity testcomparison is
end entity testcomparison;

architecture Bhv of testcomparison is
	signal my_signal : std_ulogic := '0';
begin
	stimul: process is
	begin
		my_signal <= '-';
	end process;

	regular_case: process is
	begin
		case my_signal is
			when "-" => report "matching case: don't care detected";
			when others => report "matching case: other value detected";
		end case;

		wait;
	end process;

	matching_case: process is
	begin
		case? my_signal is
			when "-" => report "matching case: don't care detected";
			when others => report "matching case: other value detected";
		end case?;

		wait;
	end process;

end architecture Bhv;