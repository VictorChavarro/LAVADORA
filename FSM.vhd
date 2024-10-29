library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM is
   Port (
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      stop : in std_logic;
      pause : in std_logic;
      rom_data : in std_logic_vector(7 downto 0);  
      address : out std_logic_vector(3 downto 0);  
      llenado : out std_logic;
      lavado : out std_logic;
      vaciado : out std_logic;
      enjuague : out std_logic;
      centrifugado : out std_logic;
      done : out std_logic
   );
end FSM;

architecture ARK of FSM is
   type estado_type is (INICIO, LLENADO1, LAVADO1, VACIADO1, LLENADO2, ENJUAGUE1, VACIADO2, CENTRIFUGADO1, FIN);
   signal estado, siguiente_estado : estado_type;
   signal contador : integer := 0;
begin

   proceso_maquina: process(clk, reset)
   begin
      if reset = '1' or stop = '1' then
         estado <= INICIO;
         contador <= 0;
         done <= '0';
      elsif rising_edge(clk) then
         if start = '1' and pause = '0' then   -- Iniciar sólo si `pause` está desactivado
            estado <= siguiente_estado;
         end if;

         -- Control del avance de los estados
         case estado is
            when INICIO =>
               contador <= 0;
               siguiente_estado <= LLENADO1;
               address <= "0000"; -- Dirección en la ROM para INICIO (opcional si no lo usa)

            when LLENADO1 =>
               address <= "0001"; -- Dirección en la ROM para LLENADO1
               if contador < to_integer(unsigned(rom_data)) and pause = '0' then
                  contador <= contador + 1;
               elsif contador >= to_integer(unsigned(rom_data)) then
                  siguiente_estado <= LAVADO1;
                  contador <= 0;
               end if;

            when LAVADO1 =>
               address <= "0010"; -- Dirección en la ROM para LAVADO1
               if contador < to_integer(unsigned(rom_data)) and pause = '0' then
                  contador <= contador + 1;
               elsif contador >= to_integer(unsigned(rom_data)) then
                  siguiente_estado <= VACIADO1;
                  contador <= 0;
               end if;

            when VACIADO1 =>
               address <= "0011"; -- Dirección en la ROM para VACIADO1
               if contador < to_integer(unsigned(rom_data)) and pause = '0' then
                  contador <= contador + 1;
               elsif contador >= to_integer(unsigned(rom_data)) then
                  siguiente_estado <= LLENADO2;
                  contador <= 0;
               end if;

            when LLENADO2 =>
               address <= "0100"; -- Dirección en la ROM para LLENADO2
               if contador < to_integer(unsigned(rom_data)) and pause = '0' then
                  contador <= contador + 1;
               elsif contador >= to_integer(unsigned(rom_data)) then
                  siguiente_estado <= ENJUAGUE1;
                  contador <= 0;
               end if;

            when ENJUAGUE1 =>
               address <= "0101"; -- Dirección en la ROM para ENJUAGUE1
               if contador < to_integer(unsigned(rom_data)) and pause = '0' then
                  contador <= contador + 1;
               elsif contador >= to_integer(unsigned(rom_data)) then
                  siguiente_estado <= VACIADO2;
                  contador <= 0;
               end if;

            when VACIADO2 =>
               address <= "0110"; -- Dirección en la ROM para VACIADO2
               if contador < to_integer(unsigned(rom_data)) and pause = '0' then
                  contador <= contador + 1;
               elsif contador >= to_integer(unsigned(rom_data)) then
                  siguiente_estado <= CENTRIFUGADO1;
                  contador <= 0;
               end if;

            when CENTRIFUGADO1 =>
               address <= "0111"; -- Dirección en la ROM para CENTRIFUGADO1
               if contador < to_integer(unsigned(rom_data)) and pause = '0' then
                  contador <= contador + 1;
               elsif contador >= to_integer(unsigned(rom_data)) then
                  siguiente_estado <= FIN;
                  contador <= 0;
               end if;

            when FIN =>
               done <= '1';
               siguiente_estado <= INICIO;

         end case;
      end if;
   end process;

   -- Asignación de señales de salida
   llenado <= '1' when estado = LLENADO1 or estado = LLENADO2 else '0';
   lavado <= '1' when estado = LAVADO1 else '0';
   vaciado <= '1' when estado = VACIADO1 or estado = VACIADO2 else '0';
   enjuague <= '1' when estado = ENJUAGUE1 else '0';
   centrifugado <= '1' when estado = CENTRIFUGADO1 else '0';

end ARK;
