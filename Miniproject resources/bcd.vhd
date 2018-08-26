library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; 

entity BCD is 
	port(enable,direction,init,clk, isTens	: in std_logic;
			init_value 								: in std_logic_vector(3 downto 0);
			Q_Out 									: out std_logic_vector(3 downto 0) := "0010");
end entity BCD;

architecture beh of BCD is 


begin
	process(clk)
	variable s_Q: std_logic_vector(3 downto 0) := "0000";
	begin
		if rising_edge(clk) then 

			if direction = '0' then

				if init = '1' then
					s_Q := "0000";
				elsif init = '0'  and enable = '1' then

					if s_Q = "1001" then
						s_Q := "0000";
					else 
						s_Q := s_Q + 1;
					end if;

				end if;

			elsif direction = '1' then

				if init = '1' then
					s_Q := init_value;
				elsif init = '0' and enable = '1' then

					if s_Q = "0000" then
						if isTens = '0' then
							s_Q := "1001";
						else 
							s_Q := "0101";
						end if;
					else 
						s_Q := s_Q - 1;
					end if;

				end if;
		
			end if;
		end if;
		Q_Out <= s_Q; 
	end process;
	
end architecture;
	
	
					
				