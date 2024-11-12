library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity motor_control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pwm_out : out STD_LOGIC;
           motor_dir : out STD_LOGIC);
end motor_control;

architecture Behavioral of motor_control is
    signal pwm_counter : INTEGER := 0;
    signal time_counter : INTEGER := 0;
    signal pwm_signal : STD_LOGIC := '0';
    signal direction : STD_LOGIC := '0';
    constant CLOCK_FREQ : INTEGER := 50000000; -- Frecuencia del reloj en Hz (ajustar según tu sistema)
    constant TIME_PERIOD : INTEGER := 15; -- Tiempo en segundos para cada dirección
begin
    process(clk, reset)
    begin
        if reset = '1' then
            pwm_counter <= 0;
            time_counter <= 0;
            pwm_signal <= '0';
            direction <= '0';
        elsif rising_edge(clk) then
            -- Contador de tiempo
            if time_counter < CLOCK_FREQ * TIME_PERIOD then
                time_counter <= time_counter + 1;
            else
                time_counter <= 0;
                direction <= not direction; -- Cambia la dirección cada 15 segundos
            end if;

            -- Contador PWM
            if pwm_counter < 100 then
                pwm_counter <= pwm_counter + 1;
            else
                pwm_counter <= 0;
            end if;

            -- Generación de la señal PWM
            if pwm_counter < 50 then -- 50% de ciclo de trabajo (ajustar para cambiar la velocidad)
                pwm_signal <= '1';
            else
                pwm_signal <= '0';
            end if;
        end if;
    end process;

    pwm_out <= pwm_signal;
    motor_dir <= direction;
end Behavioral;