library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
	port
	(
		-- Input ports
		clock, reset, en, load 	: in  std_logic;
		cnt_in : in unsigned(6 downto 0);

		-- Output ports
		cnt	: out unsigned (6 downto 0)
	);
end contador;

architecture arch_contador of contador is

	-- Declarations (optional)
	signal cnt_temp : unsigned(6 downto 0);

begin

	-- Process Statement (optional)
	counter : process (clock, reset)
		begin
			if (reset = '0') then
				cnt_temp <= "1100011";
			elsif (clock'event and clock = '1') then
				
				if ( load ='1') then
			
					cnt_temp<= cnt_in;
				else
						if(en='1') then
							if(cnt_temp="0000000") then
								cnt_temp <= "1100011";            
							else 
							cnt_temp <= cnt_temp - 1;
						end if;
					end if;
				end if;
			end if;
			
			
	end process;
	
	cnt <= cnt_temp;

end arch_contador;

