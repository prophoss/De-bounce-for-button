library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Debounce_Switch is
port (
	i_clk  : in std_logic;
	i_Switch : in std_logic;
	o_Switch : out std_logic
	
);
end entity Debounce_Switch;

architecture RTL of Debounce_Switch is

	constant c_DEBOUNCE_LIMIT : integer := 250000;  -- this sets the de-bounce limit to 10ms @ 25MHz
	
	signal r_State : std_logic :='0';                 -- this will be the filtered state of the switch
	signal r_Count : integer range 0 to c_DEBOUNCE_LIMIT := 0;
	

begin
	p_Debounce: process (i_clk) is
	begin
	
	if rising_edge(i_clk) then
	
		if (i_Switch /= r_State and r_Count < c_DEBOUNCE_LIMIT) then
			r_Count <= r_Count +1;
		
		elsif r_Count = c_DEBOUNCE_LIMIT then
			r_State <= i_Switch;
			r_Count <= 0;
				
		else 
			r_Count <= 0;
		end if;
	
	end if;	
	
	end process p_Debounce;
	
	o_Switch <= r_State;


end architecture RTL;