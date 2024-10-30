library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoBCD is
    Port ( bcd_in : in STD_LOGIC_VECTOR(3 downto 0);
           seg_out : out STD_LOGIC_VECTOR(6 downto 0));
end decoBCD;

architecture arch_decoBCD of decoBCD is
begin
    process(bcd_in)
    begin
        case bcd_in is
            when "0000" => seg_out <= "1111110"; -- 0
            when "0001" => seg_out <= "0110000"; -- 1
            when "0010" => seg_out <= "1101101"; -- 2
            when "0011" => seg_out <= "1111001"; -- 3
            when "0100" => seg_out <= "0110011"; -- 4
            when "0101" => seg_out <= "1011011"; -- 5
            when "0110" => seg_out <= "1011111"; -- 6
            when "0111" => seg_out <= "1110000"; -- 7
            when "1000" => seg_out <= "1111111"; -- 8
            when "1001" => seg_out <= "1111011"; -- 9
            when others => seg_out <= "0000000"; -- Blank
        end case;
    end process;
end arch_decoBCD;
