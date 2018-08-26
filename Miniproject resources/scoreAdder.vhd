LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

--The score added component stores the score for the current level. The score is incremented whenever a ball is caught.
--Score is seperated in to 100s, 10s and 1s so text generation is easier.
entity scoreAdder is
	port(		vert_sync, en_add1, ball_1_en, en_add2, en_add3		: in std_logic;
				score100_in, score10_in, score1_in						: in std_logic_vector(3 downto 0);
				goalMet															: out std_logic;
				score100_out, 	score10_out, 	score1_out				: out std_logic_vector(3 downto 0));
				
end entity scoreAdder;

architecture beh of scoreAdder is 
begin

process
variable current100: std_logic_vector(3 downto 0) 	:= score100_in;
variable current10: std_logic_vector(3 downto 0)	:= score10_in;
variable current1: std_logic_vector(3 downto 0)		:= score1_in;

begin
WAIT UNTIL vert_sync'event and vert_sync = '1';
	if ball_1_en = '0' then
		current100 	:= "0000";
		current10 	:= "0000";
		current1		:= "0000";
		goalMet <= '0';
	else
		
		goalMet <= '0';
		--Checks for score requirement
		if current1 = "0000"  and current10 = "0011" then 
			goalMet <= '1';
			current100 := "0000";
			current10 := "0000";
			current1 := "0000";
		else
				goalMet <= '0';
		end if;
		
		--Ball 1 incrementer
		if current10 = "1001"  and current1 = "1001" and (en_add1 = '1') then
			current10 := "0000";
			current1 := "0000";
			current100 := current100 + 1;	
		elsif current1 = "1001" and (en_add1 = '1') then   
			current1 := "0000";
			current10 := current10  +1;
		elsif en_add1 = '1' then
			current1 := current1 +1;
		end if;
		
		--Ball 2 incrementer
		if current10 = "1001"  and current1 = "1001" and (en_add2 = '1') then
			current10 := "0000";
			current1 := "0000";
			current100 := current100 + 1;
			
		elsif current1 = "1001" and (en_add2 = '1') then  
			current1 := "0000";
			current10 := current10  +1;
		elsif en_add2 = '1' then
			current1 := current1 +1;
		end if;
		
		--Ball 3 incrementer
		if current10 = "1001"  and current1 = "1001" and (en_add3 = '1') then
			current10 := "0000";
			current1 := "0000";
			current100 := current100 + 1;	
		elsif current1 = "1001" and (en_add3 = '1') then   
			current1 := "0000";
			current10 := current10  +1;
		elsif en_add3 = '1' then
			current1 := current1 +1;
		end if;
	end if;
	
	score100_out 	<= current100;
	score10_out 	<= current10;
	score1_out 		<= current1;

end process;
end architecture beh;