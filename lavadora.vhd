library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lavadora is
   port (
      clk      : in std_logic;
      reset    : in std_logic;
      start    : in std_logic;
      stop     : in std_logic;
      pause    : in std_logic;
      buzzer   : buffer std_logic;
      display1 : out std_logic_vector(6 downto 0); -- Decenas  
      display2 : out std_logic_vector(6 downto 0); -- Unidades
      display3 : out std_logic_vector(6 downto 0); -- Velocidad
      display4 : out std_logic_vector(6 downto 0)  -- Dirección
   );
end lavadora;

architecture arch_lavadora of lavadora is

   -- SEÑALES INTERNAS
   signal Freq1, Freq2, llenado, lavado, vaciado, enjuague, centrifugado, done : std_logic;
   signal cout : integer;
   signal enable : std_logic_vector(2 downto 0);
   signal address : std_logic_vector(3 downto 0);
   signal data : std_logic_vector(7 downto 0);
    
   -- COMPONENTES
   component giro
      port (        
         vuelta : in std_logic_vector(1 downto 0);
         s : out std_logic_vector(6 downto 0)
      );
   end component;
   
   component FSM
      port (
         clk           : in std_logic;
         reset         : in std_logic;
         start         : in std_logic;
         stop          : in std_logic;
         pause         : in std_logic;
         rom_data      : in std_logic_vector(7 downto 0);  
         address       : out std_logic_vector(3 downto 0);  
         llenado       : out std_logic;
         lavado        : out std_logic;
         vaciado       : out std_logic;
         enjuague      : out std_logic;
         centrifugado  : out std_logic;
         done          : out std_logic
      );
   end component;
   
   component ROMsync
      port (
         clk      : in std_logic;
         address  : in std_logic_vector(3 downto 0); 
         data_out : out std_logic_vector(7 downto 0)
      );
   end component;
   
   component diviFreq
      port (
         clk  : in std_logic;
         out1 : out std_logic;
         out2 : out std_logic
      );
   end component;
	
   component contador
      port (
         clock     : in std_logic;
         reset     : in std_logic;
         en        : in std_logic_vector(2 downto 0);
         load      : in std_logic;
         cnt_in    : in unsigned(6 downto 0); 
         cnt       : out unsigned(6 downto 0);
         decenas   : out std_logic_vector(6 downto 0);  
         unidades  : out std_logic_vector(6 downto 0)
      );
   end component;
    
begin
   -- Divisor de frecuencia
   Frecuencia : diviFreq port map (clk, Freq1, Freq2);

   -- Instancia de la FSM
   MaquinaEstados : FSM port map (Freq2, reset, start, stop, pause, data, address, llenado, lavado, vaciado, enjuague, centrifugado, done);

   -- Instancia de la ROM
   ROM : ROMsync port map (Freq2, address, data);
	
   -- Instancia del contador
   Temporizador : contador port map (Freq1, reset, '0', enable, unsigned(data(6 downto 0)),  to_unsigned(cout, 7), display1, display2);

   -- Lógica de habilitación
   process (llenado, lavado, vaciado, enjuague, centrifugado)
   begin
      if (llenado = '1' and lavado = '0' and vaciado = '0' and enjuague = '0' and centrifugado = '0') then
         enable <= "001";
      elsif (lavado = '1' and vaciado = '0' and enjuague = '0' and centrifugado = '0') then
         enable <= "010";
      elsif (vaciado = '1' and lavado = '0' and enjuague = '0' and centrifugado = '0') then
         enable <= "011";
      elsif (enjuague = '1' and lavado = '0' and vaciado = '0' and centrifugado = '0') then
         enable <= "100";
      elsif (centrifugado = '1' and lavado = '0' and vaciado = '0' and enjuague = '0') then
         enable <= "101";
      end if;    
   end process;

end arch_lavadora;
