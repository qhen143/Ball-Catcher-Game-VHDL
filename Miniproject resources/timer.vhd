library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity timer is 
	port(	clk_in,load_in,start_in , pause, en_platform : in  std_logic;
			timeUp 													: out std_logic;
			out_min10s, out_min1s, out_sec10s, out_sec1s : out std_logic_vector(3 downto 0));
end entity timer;


architecture struc of timer is 

signal min10s, min1s, sec10s, sec1s 			: std_logic_vector(3 downto 0):= x"0";
signal enM10s, enM1s, enS10s, enS1s 			: std_logic							:= '0';
signal direction_in									: std_logic							:= '1';
signal new_clk											: std_logic;
signal a 												: std_logic 						:= '1';
signal initM10s, initM1s, initS10s, initS1s	: std_logic							:= '0';

component BCD is 
	port(enable,direction,init,clk, isTens	: in std_logic;
			init_value 								: in std_logic_vector(3 downto 0);
			Q_Out 									: out std_logic_vector(3 downto 0));
end component BCD;

component CLK1Hz is
    Port (clk_in : in  STD_LOGIC;
			clk_out: out STD_LOGIC);
end component CLK1Hz;

begin

	--BCD for minutes(tens)
	Minutes_tens: BCD
		port map( 	enable => enM10s, direction => direction_in,
					init => initM10s, clk => new_clk, isTens => '1', init_value => x"0", Q_Out => min10s);
					
	--BCD for minutes(ones)
	Minutes_ones: BCD
		port map( 	enable => enM1s, direction => direction_in,
					init => initM1s, clk => new_clk, isTens => '0', init_value => x"2", Q_Out => min1s);

	--BCD for seconds(tens)
	Seconds_tens: BCD
		port map( 	enable => enS10s, direction => direction_in,
					init => initS10s, clk => new_clk, isTens => '1', init_value => x"0", Q_Out => sec10s);
					
	--BCD for seconds(ones)
	Seconds_ones: BCD
		port map( 	enable => enS1s, direction => direction_in,
					init => initS1s, clk => new_clk, isTens => '0', init_value => x"0", Q_Out => sec1s);
					
	--Clock divider to count 1 second
	clkdivider: CLK1Hz
		port map( clk_in =>clk_in, clk_out => new_clk);
	
	
	out_min10s <= min10s;
	out_min1s <= min1s;
	out_sec10s <= sec10s;
	out_sec1s <= sec1s;

	--Control resets signals (Resets whenver not on a level screen)
	initS1s <= '1' when load_in = '1' or en_platform = '0' or a= '0' else '0';
	
	initS10s <= '1' when load_in = '1' or en_platform = '0' or a = '0' else  '0'; 
	
	initM1s <= '1' when load_in = '1' or en_platform = '0' or a = '0' else '0';
	
	initM10s <= '1' when load_in = '1' or en_platform = '0' or a = '0' else '0'; 

	--Control enables of BCDs (Allows counting when on a game screen or not paused
	enS1s <= 	'1' when a = '1' and pause = '0' 	and en_platform = '1' 	else '0';
	
	enS10s <= 	'1' when a = '1' and sec1s = "1001" and direction_in = '0' 	else 																						-- counting up logic
					'1' when a = '1' and pause = '0' 	and direction_in = '1' 	and 	sec1s = "0000" else '0'; 													-- counting down logic
	
	enM1s <= 	'1' when a = '1' and sec10s = "0101" and sec1s = "1001" and direction_in = '0' else																-- counting up logic
					'1' when a = '1' and pause  = '0' 	 and sec1s = "0000" and sec10s = "0000"  	and direction_in = '1' else '0'; 						-- counting down logic
	
	enM10s <= 	'1' when a = '1' and min1s = "1001" and sec10s = "0101" and sec1s = "1001"  and direction_in = '0' else 									-- counting up logic
					'1' when a = '1' and pause = '0' 	and sec1s = "0000"  and sec10s = "0000" and min1s = "0000" and direction_in = '1' else '0'; 	-- counting down logic

	timeUp <= '1' when min10s = "0000" and min1s = "0000" and sec10s = "0000" and sec1s = "0000" else '0'; 													-- Time limit
	
	a <= '0' when min10s = "0000" and min1s = "0000" and sec10s = "0000" and sec1s = "0000" else '1';
end architecture struc;