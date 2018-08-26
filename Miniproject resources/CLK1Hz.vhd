library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLK1Hz is
    Port (
        clk_in : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end clk1Hz;

architecture Behavioral of CLK1Hz is
    signal temp: STD_LOGIC := '0';
    signal counter : integer range 0 to 25000000 := 0;
begin
		--Generates 1HZ Clk signal
    frequency_divider: process ( clk_in) begin
       
    if( rising_edge(clk_in)) then
		counter <= counter + 1;
            if (counter = 12500000) then 
                temp <= not(temp);
                counter <= 0;
            end if;
        end if;
    end process;
    
    clk_out <= temp;
end Behavioral;