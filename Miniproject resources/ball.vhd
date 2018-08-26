
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;

--The ball component contains the display logic and control logic of a ball.
--Ball logic includes: 	- Wall collisons from all sides.
--								- Ball and platform interaction.
--								- Display the ball by controlling rgb outputs when current pixel is in the ball radius.
--The ball will not be displayed if not on a level screen and will not move when paused.

ENTITY ball IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);

   PORT(SIGNAL Clock, Vert_sync,pause, en_ball		: 	IN std_logic;
			SIGNAL pixel_row, pixel_column							:	IN std_logic_vector(9 downto 0);
			signal rand_seed												: 	IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			signal mode_in 												: 	in std_logic_vector(2 downto 0);
			signal platformXPos, platformYPos, lengthPlatform	: 	in std_LOGIC_VECTOR(9 downto 0);
        SIGNAL Red,Green,Blue, addScore 							: 	OUT std_logic);
END ball;

architecture behavior of ball is

			-- Video Display Signals   
SIGNAL Red_Data, Green_Data, Blue_Data, reset, Ball_on 			: std_logic;
SIGNAL Size 								: std_logic_vector(9 DOWNTO 0);  
SIGNAL Ball_Y_motion 						: std_logic_vector(9 DOWNTO 0);
SIGNAL Ball_x_motion 						: std_logic_vector(9 DOWNTO 0):= CONV_STD_LOGIC_VECTOR(5,10);

--signal x_displacement,y_displacement: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(5,10);
signal y_displacement: std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(5,10);

SIGNAL Ball_Y_pos, Ball_X_pos				: std_logic_vector(9 DOWNTO 0) := "0000000000";


BEGIN           
--Radius of ball
Size <= CONV_STD_LOGIC_VECTOR(8,10);

-- Colors for pixel data on video signal
-- Turn off Green and Red when displaying ball
Blue <=  '1';
Red <=  NOT Ball_on or not en_ball;
Green <= NOT Ball_on or not en_ball;

--Change ball downwards speed based on level
y_displacement <= CONV_STD_LOGIC_VECTOR(8,10) when mode_in = "100" else 
						CONV_STD_LOGIC_VECTOR(6,10) when mode_in = "011" else CONV_STD_LOGIC_VECTOR(5,10);

--Turn on ball_on when pixel column and row are within the radius of the ball						
RGB_Display: Process (Ball_X_pos, Ball_Y_pos, pixel_column, pixel_row, Size)
BEGIN
	if ((((Ball_X_pos - pixel_column) * (Ball_X_pos - pixel_column)) + ((Ball_Y_pos - pixel_row) * (Ball_Y_pos - pixel_row))) <= size * size) THEN
		Ball_on <= '1';
	ELSE
		Ball_on <= '0';
	END IF;
END process RGB_Display;

--Ball movement logic
Move_Ball: process
variable rand_x: std_logIC_VECTOR(9 downto 0);
variable x_displacement: std_logIC_VECTOR(9 downto 0):= ball_x_motion;
BEGIN
	WAIT UNTIL vert_sync'event and vert_sync = '1';
			
			if pause = '1' then
				--Resets game parameters when leaving a level
				if en_ball = '0' then
					Ball_Y_pos	<= "0000000000";
					ball_y_motion <= CONV_STD_LOGIC_VECTOR(3,10);
				end if;
				
			elsif en_ball = '0' then
				--Resets game parameters when leaving a level
				Ball_Y_pos	<= "0000000000";
				ball_y_motion <= CONV_STD_LOGIC_VECTOR(3,10);

			else 
				--Compute next ball position
				Ball_x_pos <= Ball_x_pos + ball_x_motion;
				Ball_Y_pos <= Ball_Y_pos + ball_Y_motion;	
				
				--Reset addScore flag
				addScore <= '0';
				
				--Bounces ball when it reaches the floor
				IF ('0' & Ball_Y_pos) >= CONV_STD_LOGIC_VECTOR(480,10) - Size THEN
					Ball_Y_motion <= -y_displacement;
					
				--Catch ball on contact with the platform
				elsif (('0' & Ball_Y_pos + size) >= CONV_STD_LOGIC_VECTOR(480,10) - size) and (ball_Y_motion > 0) and (('0' & ball_X_pos + size) >= '0' & platformXPos - lengthPlatform) and (('0' & ball_X_pos - size) <= '0' & platformXPos + lengthPlatform) then 
					
					--Resets ball position
					ball_X_pos <= rand_seed(9 downto 0);
					ball_y_pos <= conV_STD_LOGIC_VECTOR(10,10);
					
					--Changes ball angle 
					rand_x := "0000000"&rand_seed(2 downto 1) & '1';
					x_displacement := rand_x;
					
					--Horizontal direction randomly decided
					if rand_seed(5) = '0' then
						ball_x_motion <= rand_x;
					else 
						ball_x_motion <= -rand_x;
					end if;
					
					--Reset ball for downwards motion
					ball_y_motion <= y_displacement;
					
					addScore <= '1';
				
				--Otherwise normal ball movement
				ELSIF '0' & Ball_Y_pos <= '0' & Size - ball_Y_motion THEN
					Ball_Y_motion <= y_displacement;
					ball_x_motion <= ball_x_motion;
					
				END IF;
					
					
				-- Bounce off left or right of screen 
				IF ("00" & Ball_x_pos) >= CONV_STD_LOGIC_VECTOR(640,11) - Size THEN 
					Ball_x_motion <= -x_displacement;
					
				ELSIF "00" & Ball_x_pos <= '0' & Size - ball_x_motion THEN 
					Ball_x_motion <= x_displacement;
					
				END IF;		
			end if;

END process Move_Ball;

END behavior;

