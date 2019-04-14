library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterSet is
	port(
		csi_clk          : in std_logic;
		rsi_reset_n      : in std_logic;
		
		avs_s0_address   : in  std_logic_vector(7 downto 0);
	    avs_s0_write     : in  std_logic;
   		avs_s0_writedata : in  std_logic_vector(7 downto 0);
    	avs_s0_read      : in  std_logic;
    	avs_s0_readdata  : out std_logic_vector(7 downto 0)
	);
end entity RegisterSet;

architecture RTL of RegisterSet is
	type aRegSet is array (natural range <>) of std_ulogic_vector(7 downto 0);
		
	signal readData, readDataNext : std_ulogic_vector(7 downto 0);
	signal MyRegister, MyRegisterNext : aRegSet(7 downto 0);
	signal address : natural;
begin
	process (csi_clk, rsi_reset_n) is
	begin
		if(rsi_reset_n = '0') then
			MyRegister <= (others => (others => '0'));
			readData <= (others => '0');
		elsif (rising_edge(csi_clk)) then
			MyRegister <= MyRegisterNext;
			readData <= readDataNext;
		end if;
	end process;
	
	Read: process (avs_s0_read, address, MyRegister, readData) is
	begin
		readDataNext <= readData;
		if(avs_s0_read = '1') then
			readDataNext <= MyRegister(address);
		end if;
	end process;
	
	Write: process (avs_s0_write, MyRegister, address, avs_s0_writedata) is
	begin
		MyRegisterNext <= MyRegister;
		if (avs_s0_write = '1') then
			MyRegisterNext(address) <= avs_s0_writedata;
		end if;
	end process;
	
	--here we assign a ulogic_vector to a logic_vector
	avs_s0_readdata <= readData;
	
	address <= to_integer(unsigned(avs_s0_address));	
end architecture RTL;
