library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity giro is
	port
	(		
		vuelta	: in  std_logic_vector(1 downto 0);
		s	: out std_logic_vector(6 downto 0)
	);
end giro;


architecture arch_giro of giro is

	-- Declarations (optional)

begin

	process (vuelta)	
		begin 	
			if (vuelta = "01") then 
				s <= "0000001";	--Muestra una D
			elsif (vuelta = "11") then
				s <= "1111001";	--Muestra una I
			else
				s <= "1111111";	--No muestra nada
			end if;	
	end process;

end arch_giro;