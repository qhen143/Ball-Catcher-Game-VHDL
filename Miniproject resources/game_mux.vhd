LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

--Determines which game component to display. When in a level screen then enable the correct components. eg. ball 3 only dispalyed on level 3
entity game_mux is
	port(		mode 										:in std_logic_vector(2 downto 0);
				 en_platform, en_ball_1, en_ball_2, en_ball_3		: out std_logic);
				
	
end entity game_mux;

architecture beh of game_mux is 

begin
--000 menu
--001 prac
--010	LV1
--011 LV2
--100 LV3
--101	T
--110 Lose
--111 Win
en_platform <= '1' when mode = "001" or mode = "010" or mode = "011" or mode = "100" else '0'; --all levels +prac
en_ball_1 	<= '1' when mode = "001" or mode = "010" or mode = "011" or mode = "100" else '0'; --all levels +prac
en_ball_2 	<= '1' when 					 					  mode = "011" or mode = "100" else '0'; --just lv2 and 3
en_ball_3 	<= '1' when 										 						mode = "100" else '0'; --just lv3

end architecture beh;