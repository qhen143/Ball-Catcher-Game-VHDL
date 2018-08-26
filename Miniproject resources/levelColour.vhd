LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

--This component changes the non-level screen colour.

entity levelColour is
	port(	redIn, greenIn, blueIn	: in 	std_logic;
			mode 							: in std_logic_vector(2 downto 0);
			redOut, greenOut, blueOut		: out std_logic);
end entity levelColour;

architecture beh of levelColour is
begin
	redOut <= not 	redIn  when mode = "000" or mode = "101" or mode = "111" else redIn;
						
	greenOut <= greenIn;
	
	blueOut <= redIn  when mode = "000" or mode = "101" or mode = "111" else blueIn;

end architecture beh;
			