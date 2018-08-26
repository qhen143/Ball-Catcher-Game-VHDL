LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

--Finite State Machine Controls the Game logic. 
entity fsm is
	port(		clk, reset, timeUp, modeSel, confirm, goalMet	: in	std_logic;
				mode_out		: out std_logic_vector(2 downto 0));
end entity fsm;

architecture beh of fsm is 
type usart_states is (menu, practice, level1, level2, level3, transitionLVL, win, lose);
	signal CS, NS : usart_states:= menu;
	signal prevState : usart_states:= level1;
begin

-------------------------------------------------------------------------------
--Set current state
Asynchronous_process: process (reset, clk)
 begin
	if reset = '1' then
	 CS <= menu;
	elsif clk'event and clk = '1' then
		CS <= NS;
	end if;
end process;

-------------------------------------------------------------------------------
--Determine next state
NextState_logic: process (CS, timeUp, confirm, goalMet, modeSel, prevState)
 begin
	case CS is
		when menu =>
			--Change to practice mode when button2 is pressed and dipswitch is off
			if confirm = '0' and modeSel = '0' then
				NS <= practice;
			
			--Change to singleplayer mode when button2 is pressed and dipswitch is on	
			elsif confirm = '0' and modeSel = '1' then
				NS <= level1;
				
			else 
				NS <= CS;
			end if;
			
		when practice =>
			--When time runs out change to game over phase
			if timeUp = '1' then
				NS <= lose;		
			else
				NS <= CS;
			end if;
		
		--When the goal is met then move on the transition to the next level
		--When the time runs out but score requirement is not met then transitions to game over	
		when level1 =>
			if (timeUp = '1' and goalMet = '1') or goalMet = '1' then 
				NS <= TransitionLVL;

			elsif timeUp = '1' and goalMet = '0' then
				NS <= lose;
			else 
				NS <= CS;
				prevState <= CS;
			end if;
			
		when level2 =>
			if (timeUp = '1' and goalMet = '1') or goalMet = '1' then 
				NS <= TransitionLVL;
			elsif timeUp = '1' and goalMet = '0' then
				NS <= lose;
			else 
				NS <= CS;
				prevState <= CS;
			end if;
			
		when level3 =>
			if (timeUp = '1' and goalMet = '1') or goalMet = '1' then 
				NS <= win;
				
			elsif timeUp = '1' and goalMet = '0' then
				NS <= lose;
				
			else 
				NS <= CS;
			end if;
		
		-- Transitions to the corresponding level when confirmation button is pressed
		when transitionLVL => 
			if confirm = '0' then
				if prevState = level1 then
					NS <= level2;
					
				elsif prevState = level2 then
					NS <= level3;
					
				else 
					NS <= CS;
				end if;
				
			else
				NS <= CS;
			end if;
		
		--Gives user option to play again or go back to the main menu
		when win =>
			if confirm = '0' then 
				NS <= level1;
				
			else
				NS <= CS;
			end if;
			
		when lose => 
			if confirm = '0' then 
				NS <= level1;
				
			else
				NS <= CS;
			end if;
			
	end case;
 end process;
 
-----------------------------------------
--Determine control signal outputs to datapath
Output_logic: process (CS, timeUp, prevState, confirm, goalMet, modeSel)
 begin

	case CS is
		when menu =>
				mode_out <= "000";
				
		when practice => 
				mode_out <= "001";
		
		--Changes output based on outcome of a level 
		when level1 =>
			if (timeUp = '1' and goalMet = '1') or goalMet = '1' then
				mode_out <= "101";
				
			elsif timeUp = '1' and goalMet = '0' then
				mode_out <= "110";
				
			else 
				mode_out <= "010";
			end if;
			
		when level2 =>
			if (timeUp = '1' and goalMet = '1') or goalMet = '1' then
				mode_out <= "101";
				
			elsif timeUp = '1' and goalMet = '0' then
				mode_out <= "110";
				
			else 
				mode_out <= "011";
			end if;
			
		when level3 =>
			if (timeUp = '1' and goalMet = '1') or goalMet = '1' then
				mode_out <= "111";
				
			elsif timeUp = '1' and goalMet = '0' then
				mode_out <= "110";
				
			else 
				mode_out <= "100";
			end if;
		
		--Changes output based on previous level completed
		when transitionLVL =>
			if confirm = '0' and prevState = level1 then
				mode_out <= "011";
					
			elsif confirm = '0' and prevState = level2 then
				mode_out <= "100";
		
			else
				mode_out <= "101";
			end if;
			
		when lose => 
			mode_out <= "110";
			
		when win =>
			mode_out <= "111";		
		
	end case;
 end process;

end architecture beh;