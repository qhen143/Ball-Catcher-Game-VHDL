LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

--This component initilises each LFSR with its own unique starting value
entity lfsr_init is
	port(data_out1, data_out2, data_out3: out std_logic_vector(9 downto 0));
end entity lfsr_init;

architecture beh of lfsr_init is
begin 
data_out1 <= "0100010110";
data_out2 <= "0101011110";
data_out3 <= "0011101011";
	
end architecture beh; 