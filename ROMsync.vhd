library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROMsync is
	port
	(
		clk : in std_logic;
		address : in std_logic_vector(3 downto 0); 
		data_out : out std_logic_vector(7 downto 0) 
	);
end ROMsync;

architecture arch_ROMsync of ROMsync is
	type RW_TYPE is array (0 to 8) of std_logic_vector(7 downto 0);
	constant RW : RW_TYPE := (
		"00011110", 
		"01011010", 
		"00101101", 
		"00011110", 
		"00111100", 
		"00101101", 
		"01001011", 
		"00000000", 
		"00000000"  
	);
begin
	process (clk)
	begin
		if rising_edge(clk) then
			data_out <= RW(to_integer(unsigned(address)));
		end if;
	end process;
end arch_ROMsync;

