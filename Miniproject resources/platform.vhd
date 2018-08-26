LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

--The platform component contains the display logic and control logic of the platform. The platform is controlled by a PS2 mouse.
--Platform logic includes:	-Controlling the position of platform on the screen
--									-Displaying the platform by controlling rgb values based on current pixel
--The platform will not be displayed if not on a level screen and will not move when paused.

ENTITY platform IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);

   PORT(SIGNAL Clock, Vert_sync, pause, en_platform				: IN std_logic;
			signal mouse_col													: In std_LOGIC_VECTOR(9 downto 0);
			SIGNAL pixel_row, pixel_column								: IN std_logic_vector(9 downto 0);
			signal mode_in 													: in std_logic_vector(2 downto 0);
        SIGNAL Red,Green,Blue 											: OUT std_logic;
		  signal platformXPos, platformYPos, lengthPlatform		: out std_LOGIC_VECTOR(9 downto 0));
END platform;

architecture behavior of platform is
 
SIGNAL Red_Data, Green_Data, Blue_Data, reset, platform_on 		: std_logic;
SIGNAL Size, len 																: std_logic_vector(9 DOWNTO 0);  
SIGNAL platform_Y_pos, platform_X_pos									: std_logic_vector(9 DOWNTO 0) := "0000000000";

BEGIN           

--Height of platform
Size <= CONV_STD_LOGIC_VECTOR(8,10);

--Length of one side of the platform (dependant on level)
len <= 	CONV_STD_LOGIC_VECTOR(10,10) when mode_in = "100" else
			CONV_STD_LOGIC_VECTOR(20,10) when mode_in = "011" else CONV_STD_LOGIC_VECTOR(30,10);
			
--Position of platform from ground			
platform_Y_pos <= CONV_STD_LOGIC_VECTOR(480,10) - size;

--Output signals for other components
platformXPos <= platform_X_pos;
platformYPos <= platform_Y_pos;
lengthPlatform <= len;

-- Colors for pixel data on video signal --black platform
Red <=  NOT platform_on or not en_platform;
Green <= NOT platform_on or not en_platform;
Blue <=  NOT platform_on or not en_platform;

--Turns on platform display flag
RGB_Display: Process (platform_X_pos, platform_Y_pos, pixel_column, pixel_row, Size, len)
BEGIN 
		IF ("00" & platform_X_pos <= '0' & pixel_column + Size + len) AND
			("00" & platform_X_pos + Size + len >= '0' & pixel_column) AND
			('0' & platform_Y_pos <= pixel_row + size) AND
			(platform_Y_pos + size >= '0' & pixel_row ) THEN
			
				platform_on <= '1';
		ELSE
			platform_on <= '0';
			
		END IF;
		
END process RGB_Display;

--Platform movement logic
process(mouse_col, pause, en_platform, platform_X_pos)
begin
	--Do nothing if paused or platform is not being displayed
	if pause = '1' then
		platform_X_pos <= "0100000000";
	elsif en_platform = '0' then
		platform_X_pos <= "0100000001";
	else
		platform_X_pos <= mouse_col;
	end if;
end process;

END behavior;

