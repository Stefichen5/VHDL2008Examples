library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnconstrainedMatrix is
	generic(gNrCols : natural;
		gNrRows : natural
	);
	port(
		iClk : in std_ulogic;
		inResAsync : in std_ulogic;

		iSelRow : in natural;
		iSelCol : in natural;

		iWrEn : in std_ulogic;

		iBit : in std_ulogic;
		oBit : out std_ulogic
	);
end entity UnconstrainedMatrix;

architecture RTL of UnconstrainedMatrix is
	type aMatrixRow is array (natural range <>) of std_ulogic;
	type aMatrix is array (natural range <>) of aMatrixRow;
	
	signal Matrix, MatrixNext : aMatrix(gNrRows-1 downto 0)(gNrCols-1 downto 0);
	
begin
	process (iClk, inResAsync) is
	begin
		if(inResAsync = '0') then
			Matrix <= (others=>(others=>'0'));
		elsif (rising_edge(iClk)) then
			Matrix <= MatrixNext;
		end if;
	end process;
	
	MatrixWrite : process(all) is
	begin
		MatrixNext <= Matrix;
		
		if(iWrEn) then
			MatrixNext(iSelRow)(iSelCol) <= iBit;		
		end if;
	end process;
	
	oBit <= Matrix(iSelRow)(iSelCol);
	
end architecture RTL;
