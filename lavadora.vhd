library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity lavadora is
   port
   (
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      stop : in std_logic;
      pause : in std_logic;
      buzzer : out std_logic
   );
end lavadora;

architecture arch_lavadora of lavadora is

   -- SEÑALES INTERNAS
   signal llenado, lavado, vaciado, enjuague, centrifugado, done : std_logic;	
   signal address : std_logic_vector(3 downto 0);
   signal data : std_logic_vector(7 downto 0);
    
   -- COMPONENTES
   component giro
      port(        
         vuelta : in std_logic_vector(1 downto 0);
         s : out std_logic_vector(6 downto 0)
      );
   end component;
   
   component FSM
      port(
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
   end component;
   
   component ROMsync
      port(
         clk : in std_logic;
         address : in std_logic_vector(3 downto 0); 
         data_out : out std_logic_vector(7 downto 0)
      );
   end component;
   
   component diviFreq
      port(
         clk : in std_logic;
         out1 : out std_logic;
         out2 : out std_logic
      );
   end component;
    
begin
   -- Instancia de la FSM
   MaquinaEstados : FSM port map (clk, reset, start, stop, pause, data, address, llenado, lavado, vaciado, enjuague, centrifugado, done);

   -- Instancia de la ROM
   ROM : ROMsync port map (clk, address, data);

end arch_lavadora;
