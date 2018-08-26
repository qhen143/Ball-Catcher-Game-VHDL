LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

--9 bit Linear Feedback Shift Register (First bit is just concatenated). Used to generated psuedo-random values for the ball spawn and angle.
entity LFSR is
	port(	clk: in std_logic;
			init_val: in std_logic_vector(9 downto 0);
			data_out: out std_logic_vector(9 downto 0));
end entity LFSR;

architecture beh of lfsr is
signal seed: std_logic_vector(9 downto 0):= "0101110101";
signal init: std_logic:= '1';

begin
	--Generate psuedo-random number
	process(clk,init, init_val)
		begin
		if init = '1' then
			seed <= init_val;
			
		elsif rising_edge(clk) then
			seed <= '0' & (seed(8) xor seed(3)) & seed(8) & seed(7) & seed(6) & seed(5) & seed(4) & seed(3) & seed(2) & seed(1);
		end if;
		init <= '0';
	end process;
	
	data_out <= seed;
	
end architecture beh; 