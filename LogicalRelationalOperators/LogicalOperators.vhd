library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LogicalOperators is
	generic(gWidth : natural := 8);
	port(
		iData : in std_ulogic_vector(gWidth-1 downto 0);
		oResult : out std_ulogic
	);
end entity LogicalOperators;

--Old way of doing it
architecture AND_Classic of LogicalOperators is
begin
	ANDProcess : process(iData) is
		variable vAndResult : std_ulogic := '1';
	begin
		--Old way of doing it
		--We needed to create a for-loop and go through all elements
		for i in iData'RANGE loop
			vAndResult := vAndResult AND iData(i);
		end loop;
		
		oResult <= vAndResult;
	end process;
		
end architecture AND_Classic;

--New way of doing it
architecture AND_Modern of LogicalOperators is
begin
	--Equal to iData(0) AND iData (1) ... AND iData(n)
	oResult <= AND iData;
end architecture AND_Modern;

--Old way of doing it
architecture OR_Classic of LogicalOperators is
begin
	ANDProcess : process(iData) is
		variable vAndResult : std_ulogic := '0';
	begin
		--Old way of doing it
		--We needed to create a for-loop and go through all elements
		for i in iData'RANGE loop
			vAndResult := vAndResult OR iData(i);
		end loop;
		
		oResult <= vAndResult;
	end process;
		
end architecture OR_Classic;

--New way of doing it
architecture OR_Modern of LogicalOperators is
begin
	--Equal to iData(0) OR iData (1) ... OR iData(n)
	oResult <= OR iData;
end architecture OR_Modern;

--Calculating parity bit
architecture XOR_Parity of LogicalOperators is
begin
	oResult <= XOR iData;
end architecture;