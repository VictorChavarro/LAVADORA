library ieee;
use ieee.std_logic_1164.all;

entity decoBCD is

	port
	(
		-- Input ports
		A, B, C, D	: in  std_logic;

		-- Output ports
		sa, sb, sc, sd, se, sf, sg	: out std_logic
	);
end decoBCD;



architecture arch_decoBCD of decoBCD is

	-- Declarations (optional)
	

begin

	-- Process Statement (optional)
	sa <= '0' when (A='0' and B='0' and C='0' and D='0') else
			'0' when (A='0' and B='0' and C='1' and D='0') else
			'0' when (A='0' and B='0' and C='1' and D='1') else
			'0' when (A='0' and B='1' and C='0' and D='1') else
			'0' when (A='0' and B='1' and C='1' and D='0') else
			'0' when (A='0' and B='1' and C='1' and D='1') else
			'0' when (A='1' and B='0' and C='0' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='1') else
			'1';
			
	sb <= '0' when (A='0' and B='0' and C='0' and D='0') else
			'0' when (A='0' and B='0' and C='0' and D='1') else
			'0' when (A='0' and B='0' and C='1' and D='0') else
			'0' when (A='0' and B='0' and C='1' and D='1') else
			'0' when (A='0' and B='1' and C='0' and D='0') else
			'0' when (A='0' and B='1' and C='1' and D='1') else
			'0' when (A='1' and B='0' and C='0' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='1') else
			'1';
	
	sc <= '0' when (A='0' and B='0' and C='0' and D='0') else
			'0' when (A='0' and B='0' and C='0' and D='1') else
			'0' when (A='0' and B='0' and C='1' and D='1') else
			'0' when (A='0' and B='1' and C='0' and D='0') else
			'0' when (A='0' and B='1' and C='0' and D='1') else
			'0' when (A='0' and B='1' and C='1' and D='0') else
			'0' when (A='0' and B='1' and C='1' and D='1') else
			'0' when (A='1' and B='0' and C='0' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='1') else
			'1';
	
	sd <= '0' when (A='0' and B='0' and C='0' and D='0') else
			'0' when (A='0' and B='0' and C='1' and D='0') else
			'0' when (A='0' and B='0' and C='1' and D='1') else
			'0' when (A='0' and B='1' and C='0' and D='1') else
			'0' when (A='0' and B='1' and C='1' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='0') else
			'1';

	se <= '0' when (A='0' and B='0' and C='0' and D='0') else
			'0' when (A='0' and B='0' and C='1' and D='0') else
			'0' when (A='0' and B='1' and C='1' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='0') else
			'1';
	
	sf <= '0' when (A='0' and B='0' and C='0' and D='0') else
			'0' when (A='0' and B='1' and C='0' and D='0') else
			'0' when (A='0' and B='1' and C='0' and D='1') else
			'0' when (A='0' and B='1' and C='1' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='1') else
			'1';
	
	sg <= '0' when (A='0' and B='0' and C='1' and D='0') else
			'0' when (A='0' and B='0' and C='1' and D='1') else
			'0' when (A='0' and B='1' and C='0' and D='0') else
			'0' when (A='0' and B='1' and C='0' and D='1') else
			'0' when (A='0' and B='1' and C='1' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='0') else
			'0' when (A='1' and B='0' and C='0' and D='1') else
			'1';

	
end arch_decoBCD;

