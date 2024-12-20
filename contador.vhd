library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
   port
    (
      -- Input ports
      clock   : in  std_logic;
      reset   : in  std_logic;
      en      : in  std_logic_vector(2 downto 0);
      load    : in  std_logic;
      cnt_in  : in unsigned(6 downto 0);  -- Cambiado a 7 bits para igualar a cnt y cnt_temp

      -- Output ports
      cnt     : out unsigned(6 downto 0);
      decenas : out std_logic_vector(6 downto 0);  
      unidades : out std_logic_vector(6 downto 0)
   );
end contador;

architecture arch_contador of contador is

   -- Declarations
   signal cnt_temp : unsigned(6 downto 0) := (others => '0');  -- Inicialización de cnt_temp a 0

begin

   -- Process Statement
   counter : process (clock, reset)
   begin
      if (reset = '0') then
         cnt_temp <= "1100011";  -- Valor inicial en binario para cnt_temp (99 decimal)
      elsif (clock'event and clock = '1') then
         if (load = '1') then
            cnt_temp <= cnt_in;  -- Asignación directa de cnt_in a cnt_temp
         elsif (en = "000") then
            if (cnt_temp = "0000000") then
               cnt_temp <= "1100011";  
            else
               cnt_temp <= cnt_temp - 1;
            end if;
				
         elsif (en = "001") then
            if (cnt_temp = "0000000") then
               cnt_temp <= "0011110";  -- 30s
            else
               cnt_temp <= cnt_temp - 1;
            end if;
				
         elsif (en = "010") then
            if (cnt_temp = "0000000") then
               cnt_temp <= "1011010";  -- 90s
            else
               cnt_temp <= cnt_temp - 1;
            end if;
         elsif (en = "011") then
            if (cnt_temp = "0000000") then
               cnt_temp <= "0101101";  -- 45s
            else
               cnt_temp <= cnt_temp - 1;
            end if;
				
         elsif (en = "100") then
            if (cnt_temp = "0000000") then
               cnt_temp <= "0111100";  -- 60s
            else
               cnt_temp <= cnt_temp - 1;
            end if;
				
         elsif (en = "101") then
            if (cnt_temp = "0000000") then
               cnt_temp <= "1001011";  -- 75s
            else
               cnt_temp <= cnt_temp - 1;
            end if;
				
         end if;
      end if;
   end process;
   
   cnt <= cnt_temp;
   
   -- Decodificación de decenas
   with cnt_temp(6 downto 4) select
      decenas <= "1111110" when "000",  -- 0
                "0110000" when "001",  -- 1
                "1101101" when "010",  -- 2
                "1111001" when "011",  -- 3
                "0110011" when "100",  -- 4
                "1011011" when "101",  -- 5
                "1011111" when "110",  -- 6
                "1110000" when "111",  -- 7
                "0000000" when others; -- Apagar si no es válido

   -- Decodificación de unidades
   with cnt_temp(3 downto 0) select
      unidades <= "1111110" when "0000",  -- 0
                 "0110000" when "0001",  -- 1
                 "1101101" when "0010",  -- 2
                 "1111001" when "0011",  -- 3
                 "0110011" when "0100",  -- 4
                 "1011011" when "0101",  -- 5
                 "1011111" when "0110",  -- 6
                 "1110000" when "0111",  -- 7
                 "1111111" when "1000",  -- 8
                 "1111011" when "1001",  -- 9
                 "0000000" when others;  -- Apagar si no es válido

end arch_contador;
