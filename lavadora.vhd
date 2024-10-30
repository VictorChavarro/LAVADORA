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
      cnt_in : in unsigned(6 downto 0);
      seg_out : out STD_LOGIC_VECTOR(6 downto 0));
      buzzer : buffer std_logic
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
-- Declaración del componente del contador
    component contador
        Port ( clock : in STD_LOGIC;
               reset : in STD_LOGIC;
               en : in STD_LOGIC;
               load : in STD_LOGIC;
               cnt_in : in unsigned(6 downto 0);
               cnt : out unsigned(6 downto 0));
    end component;

    -- Declaración del componente del decodificador BCD
    component decoBCD
        Port ( bcd_in : in STD_LOGIC_VECTOR(3 downto 0);
               seg_out : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    -- Señales internas
    signal contador_salida : unsigned(6 downto 0);
    signal bcd_input : STD_LOGIC_VECTOR(3 downto 0);
      
    
begin

    -- Instancia del contador
    contador_inst : contador Port map (
            clock => clk,
            reset => reset,
            en => en,
            load => load,
            cnt_in => cnt_in,
            cnt => contador_salida
        );

    -- Convertir la salida del contador a BCD (ejemplo simple)
    bcd_input <= std_logic_vector(contador_salida(3 downto 0));

    -- Instancia del decodificador BCD
    deco_inst : decoBCD  Port map (
            bcd_in => bcd_input,
            seg_out => seg_out
        );

   
   -- Instancia de la FSM
   MaquinaEstados : FSM port map (clk, reset, start, stop, pause, data, address, llenado, lavado, vaciado, enjuague, centrifugado, done);

   -- Instancia de la ROM
   ROM : ROMsync port map (clk, address, data);

end arch_lavadora;
