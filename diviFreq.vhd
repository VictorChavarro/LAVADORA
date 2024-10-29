library ieee;
use ieee.std_logic_1164.all;

entity diviFreq is
	port
	(
		-- Input ports
		clk	: in  std_logic;
		-- Output ports
		out1, out2	: buffer std_logic
	);
end diviFreq;


architecture arch_diviFreq of diviFreq is

	signal count1 : integer range 0 to 25000000;

begin

	-- Process Statement (optional)
	process (clk)
		variable count2 : integer range 0 to 25000000;
	begin
		if (clk'event and clk='1') then
				count1 <= count1 + 1;
				count2 := count2 + 1;
				
			if (count1 = 24999999) then
				 out1 <= not out1;
				 count1 <= 0;
			end if;
				
			if (count2 = 25000000) then
				 out2 <= not out2;
				 count2 := 0;
			end if;
		end if;
	end process;

end arch_diviFreq;
