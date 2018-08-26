LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity switchColour is
	port(	switch, redIn, greenIn, blueIn	: in 	std_logic;
			redOut, greenOut, blueOut				: out std_logic);
end entity switchColour;


--When dipswitch is on, the component will switch the colour displayed. (red becomes whatever was green, green becomes whatever was blue and blue is now whatever was red)
architecture beh of switchColour is
begin
	redOut <= redIn when switch = '0' else greenIn;
	greenOut <= greenIn when switch = '0' else blueIn;
	blueOut <= blueIn when  switch = '0' else redIn;
end architecture beh;
			