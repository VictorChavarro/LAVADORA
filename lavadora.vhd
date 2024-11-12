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
      buzzer : buffer std_logic
		
		display1	: out std_logic_vector(6 downto 0); --Decenas  
      display2	: out std_logic_vector(6 downto 0)  --Unidades
   );
end lavadora;

architecture arch_lavadora of lavadora is

   -- SEÑALES INTERNAS
   signal Freq1, Freq2, enable, llenado, lavado, vaciado, enjuague, centrifugado, done : std_logic;	
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
	
	component contador
		port(
			clock, reset, en, load 	: in  std_logic;
			cnt_in : in unsigned(6 downto 0);
			cnt	: out unsigned (6 downto 0);			
			decenas    : out std_logic_vector(6 downto 0);  
			unidades    : out std_logic_vector(6 downto 0)
		);
    
begin
   -- Instancia de la FSM
   MaquinaEstados : FSM port map (Freq2, reset, start, stop, pause, data, address, llenado, lavado, vaciado, enjuague, centrifugado, done);

   -- Instancia de la ROM
   ROM : ROMsync port map (Freq2, address, data);
	
	-- Instancia del contador
	Frecuencia : diviFreq port map (clk, Freq1, Freq2);
	enable <=llenado or lavado or vaciado or enjuague or centrifugado or done; --This will not work, I know
	Temporizador : contador port map (Freq1, reset, en, load, data, display1, display2);
	

end arch_lavadora;
