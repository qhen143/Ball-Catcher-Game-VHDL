LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

--The text_gen component controls the address of characters sent to char rom. The text on each state varies which are updated based on the inputs.
--
entity text_gen is
	port(	pixel_row, pixel_col																: In std_logic_vector(9 downto 0);
			mode 																					: in std_logic_vector(2 downto 0);
			sel, pause 																			: in std_logic;
			min10s, min1s, sec10s, sec1s, score1_in, score10_in, score100_in	: in std_logic_vector(3 downto 0);
			char_address																		: out std_logic_vector(5 downto 0);
			row_size, col_size																: out std_logic_vector(2 downto 0));
end entity text_gen;

architecture beh of text_gen is

begin
	process(pixel_col, pixel_row, sec1s, sec10s, min1s, min10s, mode, sel, score100_in, score10_in, score1_in, pause)
		variable char: std_logic_vector(5 downto 0);

		begin
		--000 menu
		--001 prac
		--010	LV1
		--011 LV2
		--100 LV3
		--101	T
		--110 Lose
		--111 Win
		char:= conv_std_logic_vector(32,6);
		row_size <= pixel_row(3 downto 1);
		col_size <= pixel_col(3 downto 1);
		-- Main menu text: Ball Catcher, Practice, SinglePlayer and [the Selector arrow]
		if mode = "000" then  
			if (pixel_row >= conv_std_logic_vector(64,10) and pixel_row <= conv_std_logic_vector(95,10)) then
				if (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(2,6); 		-- B
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(1,6); 		-- A
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(12,6);		-- L		
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(12,6);		-- L
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(3,6);			-- C
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(1,6); 		-- A
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(3,6); 		-- C
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(8,6); 		-- H
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				else
					char := conv_std_logic_vector(32,6);
				end if;
				row_size <= pixel_row(4 downto 2);
				col_size <= pixel_col(4 downto 2);
			elsif (pixel_row >= conv_std_logic_vector(192,10) and pixel_row <= conv_std_logic_vector(207,10)) then
			
				if (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) and sel = '0' then
					char := conv_std_logic_vector(62,6); 		-- >
					
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(16,6);		-- P
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(18,6);		-- R
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(1,6);			-- A
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(3,6); 		-- C
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(9,6); 		-- I
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(3,6); 		-- C
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(5,6);			-- E
				else
					char := conv_std_logic_vector(32,6);
				end if;
				
			elsif (pixel_row >= conv_std_logic_vector(208,10) and pixel_row <= conv_std_logic_vector(223,10)) then 
				
				if (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) and sel = '1' then
					char := conv_std_logic_vector(62,6);		-- >
				
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(9,6); 		-- I
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(7,6); 		-- G
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(16,6); 		-- P
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(1,6); 		-- A
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(25,6); 		-- Y
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				else
					char := conv_std_logic_vector(32,6);
				end if;
			elsif (pixel_row >= conv_std_logic_vector(240,10) and pixel_row <= conv_std_logic_vector(255,10)) then 
				
				if (pixel_col >= conv_std_logic_vector(64,10) and pixel_col <= conv_std_logic_vector(79,10)) then
					char := conv_std_logic_vector(16,6); 		-- P
				elsif (pixel_col >= conv_std_logic_vector(80,10) and pixel_col <= conv_std_logic_vector(95,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				elsif (pixel_col >= conv_std_logic_vector(96,10) and pixel_col <= conv_std_logic_vector(111,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(144,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(175,10)) then
					char := conv_std_logic_vector(2,6);			-- B
				elsif (pixel_col >= conv_std_logic_vector(176,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(21,6);		-- U
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(207,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(50,6);		-- 2		
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(15,6);		-- O
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(1,6); 		-- A
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(7,6); 		-- G
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(463,10)) then
					char := conv_std_logic_vector(1,6); 		-- A
				elsif (pixel_col >= conv_std_logic_vector(464,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(13,6); 		-- M
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
					char := conv_std_logic_vector(13,6); 		-- M
				elsif (pixel_col >= conv_std_logic_vector(528,10) and pixel_col <= conv_std_logic_vector(543,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(544,10) and pixel_col <= conv_std_logic_vector(559,10)) then
					char := conv_std_logic_vector(4,6); 		-- D
				elsif (pixel_col >= conv_std_logic_vector(560,10) and pixel_col <= conv_std_logic_vector(575,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				else
					char := conv_std_logic_vector(32,6);
				end if;
			elsif (pixel_row >= conv_std_logic_vector(256,10) and pixel_row <= conv_std_logic_vector(271,10)) then 
				
				if (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
					char := conv_std_logic_vector(21,6); 		-- U
				elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(144,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(175,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(176,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(19,6);		-- S
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(207,10)) then
					char := conv_std_logic_vector(23,6);		-- W
				elsif (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(9,6); 		-- I
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(3,6); 		-- C
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(8,6);			-- H		
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(54,6);		-- SIX
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(3,6); 		-- C
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(463,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(464,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(13,6); 		-- M
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(4,6); 		-- D
				elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				else
					char := conv_std_logic_vector(32,6);
				end if;
			else 
				char := conv_std_logic_vector(32,6);
			end if;
			
		-- Level Screen text: Score, [score value], State description (eg. level1 or practice), time, [time value] and paused.	
		elsif mode = "001" or mode = "010" or mode = "011" or mode = "100" then
		
			if (pixel_row >= conv_std_logic_vector(0,10) and pixel_row <= conv_std_logic_vector(15,10)) then
			
				if (pixel_col >= conv_std_logic_vector(0,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					if mode = "001" then
						char := conv_std_logic_vector(32,6);
					else
						if (pixel_col >= conv_std_logic_vector(0,10) and pixel_col <= conv_std_logic_vector(15,10)) then
							char := conv_std_logic_vector(19,6); 		-- S
						elsif (pixel_col >= conv_std_logic_vector(16,10) and pixel_col <= conv_std_logic_vector(31,10)) then
							char := conv_std_logic_vector(3,6); 		-- C
						elsif (pixel_col >= conv_std_logic_vector(32,10) and pixel_col <= conv_std_logic_vector(47,10)) then
							char := conv_std_logic_vector(15,6); 		-- O
						elsif (pixel_col >= conv_std_logic_vector(48,10) and pixel_col <= conv_std_logic_vector(63,10)) then
							char := conv_std_logic_vector(18,6);		-- R
						elsif (pixel_col >= conv_std_logic_vector(64,10) and pixel_col <= conv_std_logic_vector(79,10)) then
							char := conv_std_logic_vector(5,6);			-- E
						elsif (pixel_col >= conv_std_logic_vector(80,10) and pixel_col <= conv_std_logic_vector(95,10)) then
							char := conv_std_logic_vector(32,6);		-- (space)
						
						elsif (pixel_col >= conv_std_logic_vector(96,10) and pixel_col <= conv_std_logic_vector(111,10)) then
							char := conv_std_logic_vector(48,6) + score100_in;		-- 0
						elsif (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
							char := conv_std_logic_vector(48,6) + score10_in;		-- 0
						elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
							char := conv_std_logic_vector(48,6) + score1_in;		-- 0
						else
							char := conv_std_logic_vector(32,6);
						end if;
					end if;
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					if mode = "001" then
						if (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
							char := conv_std_logic_vector(16,6);		-- P
						elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
							char := conv_std_logic_vector(18,6);		-- R
						elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
							char := conv_std_logic_vector(1,6);			-- A
						elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
							char := conv_std_logic_vector(3,6); 		-- C
						elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
							char := conv_std_logic_vector(20,6); 		-- T
						elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
							char := conv_std_logic_vector(9,6); 		-- I
						elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
							char := conv_std_logic_vector(3,6); 		-- C
						elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
							char := conv_std_logic_vector(5,6);			-- E
						else
							char := conv_std_logic_vector(32,6);
						end if;
					elsif mode = "010" or mode = "011" or mode = "100" then
						if (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
							char := conv_std_logic_vector(12,6);		-- L
						elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
							char := conv_std_logic_vector(5,6);			-- E
						elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
							char := conv_std_logic_vector(22,6); 		-- V
						elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
							char := conv_std_logic_vector(5,6);			-- E
						elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
							char := conv_std_logic_vector(12,6);		-- L
						elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
							char := conv_std_logic_vector(32,6); 		-- (space)
						elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
							char := conv_std_logic_vector(32,6); 		-- (space)
						elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
							char := conv_std_logic_vector(48,6) + mode -1;		-- (Level parameter)
						else
							char := conv_std_logic_vector(32,6);
						end if;
					else 
						char := char;
					end if;
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(639,10)) then
						if (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
							char := conv_std_logic_vector(20,6); 		-- T
						elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
							char := conv_std_logic_vector(9,6); 		-- I	
						elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
							char := conv_std_logic_vector(13,6); 		-- M
						elsif (pixel_col >= conv_std_logic_vector(528,10) and pixel_col <= conv_std_logic_vector(543,10)) then
							char := conv_std_logic_vector(5,6);			-- E
						elsif (pixel_col >= conv_std_logic_vector(544,10) and pixel_col <= conv_std_logic_vector(559,10)) then
							char := conv_std_logic_vector(32,6);		-- (space)
							
						elsif (pixel_col >= conv_std_logic_vector(560,10) and pixel_col <= conv_std_logic_vector(574,10)) then
							char := conv_std_logic_vector(48,6) + min10s;	-- Min 10s
						elsif (pixel_col >= conv_std_logic_vector(576,10) and pixel_col <= conv_std_logic_vector(591,10)) then
							char := conv_std_logic_vector(48,6) + min1s;		-- Min 1s
						elsif (pixel_col >= conv_std_logic_vector(592,10) and pixel_col <= conv_std_logic_vector(607,10)) then
							char := conv_std_logic_vector(63,6);				-- :
						elsif (pixel_col >= conv_std_logic_vector(608,10) and pixel_col <= conv_std_logic_vector(623,10)) then
							char := conv_std_logic_vector(48,6) + sec10s;	-- Sec 10s
						elsif (pixel_col >= conv_std_logic_vector(624,10) and pixel_col <= conv_std_logic_vector(639,10)) then
							char := conv_std_logic_vector(48,6) + sec1s;		-- Sec 1s
						else
							char := conv_std_logic_vector(32,6);
						end if;				
				else
					char := conv_std_logic_vector(32,6);
				end if;
				
			elsif (pixel_row >= conv_std_logic_vector(224,10) and pixel_row <= conv_std_logic_vector(239,10)) then
				if (pause = '1') then
					if (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
						char := conv_std_logic_vector(16,6); 		-- P
					elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
						char := conv_std_logic_vector(1,6); 		-- A
					elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
						char := conv_std_logic_vector(21,6); 		-- U
					elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
						char := conv_std_logic_vector(19,6); 		-- S
					elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
						char := conv_std_logic_vector(5,6); 		-- E
					elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
						char := conv_std_logic_vector(4,6); 		-- D
					else 
						char := conv_std_logic_vector(32,6);
					end if;	
				else 
					char := conv_std_logic_vector(32,6);
				end if;	
				
			else
				char := conv_std_logic_vector(32,6);
				
			end if;
		
		--Transition screen text: Level Completed, Instructions to continue
		elsif mode = "101" then
			
			if (pixel_row >= conv_std_logic_vector(208,10) and pixel_row <= conv_std_logic_vector(223,10)) then
					
				if (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(12,6);		-- L
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(5,6);			-- E
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(22,6);		-- V
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(3,6); 		-- C
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(15,6);		-- O		
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(13,6);		-- M
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(16,6);		-- P
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(12,6);		-- L
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(5,6);			-- E
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(5,6);			-- E	
				else
					char := conv_std_logic_vector(32,6);
				end if;
				
			elsif (pixel_row >= conv_std_logic_vector(224,10) and pixel_row <= conv_std_logic_vector(239,10)) then
				if (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
					char := conv_std_logic_vector(16,6);		-- P
				elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					char := conv_std_logic_vector(18,6);		-- R
				elsif (pixel_col >= conv_std_logic_vector(144,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(5,6);			-- E
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(175,10)) then
					char := conv_std_logic_vector(19,6);		-- S
				elsif (pixel_col >= conv_std_logic_vector(176,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(19,6);		-- S
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(207,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(2,6);			-- B
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(21,6);		-- U
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(50,6);			-- 2		
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(32,6);			-- space
					
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(20,6);			-- T
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(15,6);			-- O
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(32,6);			-- space
					
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(3,6);				-- C
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(15,6);			-- O	
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(14,6);			-- N	
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(463,10)) then
					char := conv_std_logic_vector(20,6);			-- T	
				elsif (pixel_col >= conv_std_logic_vector(464,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(9,6);				-- I	
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
					char := conv_std_logic_vector(14,6);			-- N	
				elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(21,6);			-- U	
				elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
					char := conv_std_logic_vector(5,6);				-- E	
				else
					char := conv_std_logic_vector(32,6);
				end if;
			else 
				char := conv_std_logic_vector(32,6);
			end if;
		
		--Game over text; game over, instructions to move on
		elsif mode = "110" then
			if (pixel_row >= conv_std_logic_vector(192,10) and pixel_row <= conv_std_logic_vector(223,10)) then
					
				if (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(7,6);			-- G
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(1,6);			-- A
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(13,6);		-- M
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(22,6); 		-- V
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(5,6);			-- E
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(18,6);		-- R
				else
					char := conv_std_logic_vector(32,6);
				end if;
				row_size <= pixel_row(4 downto 2);
				col_size <= pixel_col(4 downto 2);
				
			elsif (pixel_row >= conv_std_logic_vector(240,10) and pixel_row <= conv_std_logic_vector(255,10)) then
				if (pixel_col >= conv_std_logic_vector(64,10) and pixel_col <= conv_std_logic_vector(79,10)) then
					char := conv_std_logic_vector(16,6); 		-- P
				elsif (pixel_col >= conv_std_logic_vector(80,10) and pixel_col <= conv_std_logic_vector(95,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				elsif (pixel_col >= conv_std_logic_vector(96,10) and pixel_col <= conv_std_logic_vector(111,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(144,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(175,10)) then
					char := conv_std_logic_vector(2,6);			-- B
				elsif (pixel_col >= conv_std_logic_vector(176,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(21,6);		-- U
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(207,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(48,6);		-- 0		
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(15,6);		-- O
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(7,6); 		-- G
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(13,6); 		-- M
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(463,10)) then
					char := conv_std_logic_vector(1,6); 		-- A
				elsif (pixel_col >= conv_std_logic_vector(464,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(9,6); 		-- I
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
					char := conv_std_logic_vector(13,6); 		-- M
				elsif (pixel_col >= conv_std_logic_vector(528,10) and pixel_col <= conv_std_logic_vector(543,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(544,10) and pixel_col <= conv_std_logic_vector(559,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(560,10) and pixel_col <= conv_std_logic_vector(575,10)) then
					char := conv_std_logic_vector(21,6); 		-- U
				else 
					char := conv_std_logic_vector(32,6);
				
				end if;
			elsif (pixel_row >= conv_std_logic_vector(256,10) and pixel_row <= conv_std_logic_vector(271,10)) then
				if (pixel_col >= conv_std_logic_vector(80,10) and pixel_col <= conv_std_logic_vector(95,10)) then
					char := conv_std_logic_vector(16,6); 		-- P
				elsif (pixel_col >= conv_std_logic_vector(96,10) and pixel_col <= conv_std_logic_vector(111,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				elsif (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(144,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(175,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(176,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(2,6);			-- B
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(207,10)) then
					char := conv_std_logic_vector(21,6);		-- U
				elsif (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(14,6);		-- N		
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(50,6);		-- 2
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(7,6); 		-- G
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(463,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(464,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
					char := conv_std_logic_vector(22,6); 		-- V
				elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(528,10) and pixel_col <= conv_std_logic_vector(543,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(544,10) and pixel_col <= conv_std_logic_vector(559,10)) then
					char := conv_std_logic_vector(49,6); 		-- 1
				else 
					char := conv_std_logic_vector(32,6);
				end if;
			else 
				char := conv_std_logic_vector(32,6);
			end if;
		
		--Win screen text: Winner, instrcutions to move on
		elsif mode = "111" then
			if (pixel_row >= conv_std_logic_vector(192,10) and pixel_row <= conv_std_logic_vector(223,10)) then
				
				if (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(23,6);		-- W
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(9,6);			-- I
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(14,6);		-- N
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				else
					char := conv_std_logic_vector(32,6);
				end if;
				row_size <= pixel_row(4 downto 2);
				col_size <= pixel_col(4 downto 2);
				
			elsif (pixel_row >= conv_std_logic_vector(240,10) and pixel_row <= conv_std_logic_vector(255,10)) then
				if (pixel_col >= conv_std_logic_vector(64,10) and pixel_col <= conv_std_logic_vector(79,10)) then
					char := conv_std_logic_vector(16,6); 		-- P
				elsif (pixel_col >= conv_std_logic_vector(80,10) and pixel_col <= conv_std_logic_vector(95,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				elsif (pixel_col >= conv_std_logic_vector(96,10) and pixel_col <= conv_std_logic_vector(111,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(144,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(175,10)) then
					char := conv_std_logic_vector(2,6);			-- B
				elsif (pixel_col >= conv_std_logic_vector(176,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(21,6);		-- U
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(207,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(48,6);		-- 0		
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(15,6);		-- O
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(7,6); 		-- G
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(13,6); 		-- M
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(463,10)) then
					char := conv_std_logic_vector(1,6); 		-- A
				elsif (pixel_col >= conv_std_logic_vector(464,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(9,6); 		-- I
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
					char := conv_std_logic_vector(13,6); 		-- M
				elsif (pixel_col >= conv_std_logic_vector(528,10) and pixel_col <= conv_std_logic_vector(543,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(544,10) and pixel_col <= conv_std_logic_vector(559,10)) then
					char := conv_std_logic_vector(14,6); 		-- N
				elsif (pixel_col >= conv_std_logic_vector(560,10) and pixel_col <= conv_std_logic_vector(575,10)) then
					char := conv_std_logic_vector(21,6); 		-- U
				else 
					char := conv_std_logic_vector(32,6);
				end if;
				
			elsif (pixel_row >= conv_std_logic_vector(256,10) and pixel_row <= conv_std_logic_vector(271,10)) then
				if (pixel_col >= conv_std_logic_vector(80,10) and pixel_col <= conv_std_logic_vector(95,10)) then
					char := conv_std_logic_vector(16,6); 		-- P
				elsif (pixel_col >= conv_std_logic_vector(96,10) and pixel_col <= conv_std_logic_vector(111,10)) then
					char := conv_std_logic_vector(18,6); 		-- R
				elsif (pixel_col >= conv_std_logic_vector(112,10) and pixel_col <= conv_std_logic_vector(127,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(128,10) and pixel_col <= conv_std_logic_vector(143,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(144,10) and pixel_col <= conv_std_logic_vector(159,10)) then
					char := conv_std_logic_vector(19,6); 		-- S
				elsif (pixel_col >= conv_std_logic_vector(160,10) and pixel_col <= conv_std_logic_vector(175,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(176,10) and pixel_col <= conv_std_logic_vector(191,10)) then
					char := conv_std_logic_vector(2,6);			-- B
				elsif (pixel_col >= conv_std_logic_vector(192,10) and pixel_col <= conv_std_logic_vector(207,10)) then
					char := conv_std_logic_vector(21,6);		-- U
				elsif (pixel_col >= conv_std_logic_vector(208,10) and pixel_col <= conv_std_logic_vector(223,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(224,10) and pixel_col <= conv_std_logic_vector(239,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(240,10) and pixel_col <= conv_std_logic_vector(255,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(256,10) and pixel_col <= conv_std_logic_vector(271,10)) then
					char := conv_std_logic_vector(14,6);		-- N		
				elsif (pixel_col >= conv_std_logic_vector(272,10) and pixel_col <= conv_std_logic_vector(287,10)) then
					char := conv_std_logic_vector(50,6);		-- 2
				elsif (pixel_col >= conv_std_logic_vector(288,10) and pixel_col <= conv_std_logic_vector(303,10)) then
					char := conv_std_logic_vector(32,6);		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(304,10) and pixel_col <= conv_std_logic_vector(319,10)) then
					char := conv_std_logic_vector(20,6);		-- T
				elsif (pixel_col >= conv_std_logic_vector(320,10) and pixel_col <= conv_std_logic_vector(335,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(336,10) and pixel_col <= conv_std_logic_vector(351,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(352,10) and pixel_col <= conv_std_logic_vector(367,10)) then
					char := conv_std_logic_vector(7,6); 		-- G
				elsif (pixel_col >= conv_std_logic_vector(368,10) and pixel_col <= conv_std_logic_vector(383,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(384,10) and pixel_col <= conv_std_logic_vector(399,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(400,10) and pixel_col <= conv_std_logic_vector(415,10)) then
					char := conv_std_logic_vector(20,6); 		-- T
				elsif (pixel_col >= conv_std_logic_vector(416,10) and pixel_col <= conv_std_logic_vector(431,10)) then
					char := conv_std_logic_vector(15,6); 		-- O
				elsif (pixel_col >= conv_std_logic_vector(432,10) and pixel_col <= conv_std_logic_vector(447,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(448,10) and pixel_col <= conv_std_logic_vector(463,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(464,10) and pixel_col <= conv_std_logic_vector(479,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(480,10) and pixel_col <= conv_std_logic_vector(495,10)) then
					char := conv_std_logic_vector(22,6); 		-- V
				elsif (pixel_col >= conv_std_logic_vector(496,10) and pixel_col <= conv_std_logic_vector(511,10)) then
					char := conv_std_logic_vector(5,6); 		-- E
				elsif (pixel_col >= conv_std_logic_vector(512,10) and pixel_col <= conv_std_logic_vector(527,10)) then
					char := conv_std_logic_vector(12,6); 		-- L
				elsif (pixel_col >= conv_std_logic_vector(528,10) and pixel_col <= conv_std_logic_vector(543,10)) then
					char := conv_std_logic_vector(32,6); 		-- space
					
				elsif (pixel_col >= conv_std_logic_vector(544,10) and pixel_col <= conv_std_logic_vector(559,10)) then
					char := conv_std_logic_vector(49,6); 		-- 1
				else
					char := conv_std_logic_vector(32,6);
				end if;
			else 
				char := conv_std_logic_vector(32,6);
			end if;
		else
			char := conv_std_logic_vector(32,6);
		end if;
	
		char_address <= char;
	end process;
end architecture beh;
			