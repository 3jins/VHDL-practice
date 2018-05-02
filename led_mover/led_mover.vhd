library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led_mover is
	port(
		power, clk: in STD_LOGIC;
		DIP: in STD_LOGIC_VECTOR(1 downto 0);
		LED: out STD_LOGIC_VECTOR(23 downto 0)
	);
end led_mover;

architecture Behavioral of led_mover is

COMPONENT reg
	port( 
		led_input: in STD_LOGIC_VECTOR(23 downto 0);
		clk, en: in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(23 downto 0)
	);
END COMPONENT;

COMPONENT clkdivider
	port (
		clk: in STD_LOGIC;
		mode: in STD_LOGIC_VECTOR(1 downto 0);
		dclk: out STD_LOGIC;
		cur_led: out STD_LOGIC_VECTOR(3 downto 0)
	);
END COMPONENT;
		

signal led_reg_in: STD_LOGIC_VECTOR(23 downto 0);
signal led_reg_out: STD_LOGIC_VECTOR(23 downto 0);
signal dclk: STD_LOGIC;
signal cur_led: STD_LOGIC_VECTOR(3 downto 0);

	

begin
	DVD: clkdivider port map (clk=>clk, mode=>DIP, dclk=>dclk, cur_led=>cur_led);
	
	process(power, DIP, led_reg_out, dclk, cur_led)
	begin
		if power = '1' then
			case DIP is
				when "00" => -- stay still
					case cur_led is
						when x"1" => led_reg_in <= x"BE1C08";
						when x"2" => led_reg_in <= x"7D3810";
						when x"3" => led_reg_in <= x"FB7120";
						when x"4" => led_reg_in <= x"F7E341";
						when x"5" => led_reg_in <= x"EFC782";
						when x"0" => led_reg_in <= x"DF8E04";
						when others => led_reg_in <= x"222222";	-- If there are a vertical LED line in the RIGHT side, it means dclk error
					end case;
				when "10" => -- shift right
					case cur_led is
						when x"1" => led_reg_in <= x"BE1C08";
						when x"2" => led_reg_in <= x"7D3810";
						when x"3" => led_reg_in <= x"FB7120";
						when x"4" => led_reg_in <= x"F7E341";
						when x"5" => led_reg_in <= x"EFC782";
						when x"0" => led_reg_in <= x"DF8E04";
						when others => led_reg_in <= x"222222";	-- If there are a vertical LED line in the RIGHT side, it means dclk error
					end case;
				when "01" => -- shift left
					case cur_led is
						when x"1" => led_reg_in <= x"BE1C08";
						when x"2" => led_reg_in <= x"7D3810";
						when x"3" => led_reg_in <= x"FB7120";
						when x"4" => led_reg_in <= x"F7E341";
						when x"5" => led_reg_in <= x"EFC782";
						when x"0" => led_reg_in <= x"DF8E04";
						when others => led_reg_in <= x"222222";	-- If there are a vertical LED line in the RIGHT side, it means dclk error
					end case;
				when "11" => -- blink
					if dclk = '0' then
						case cur_led is
							when x"1" => led_reg_in <= x"BE1C08";
							when x"2" => led_reg_in <= x"7D3810";
							when x"3" => led_reg_in <= x"FB7120";
							when x"4" => led_reg_in <= x"F7E341";
							when x"5" => led_reg_in <= x"EFC782";
							when x"0" => led_reg_in <= x"DF8E04";
							when others => led_reg_in <= x"222222";
						end case;
					else
						led_reg_in <= x"000000";
					end if;
				when others => led_reg_in <= x"101010";	-- If there are a vertical LED line in the LEFT side, it means dip switch error
			end case;
		else
			led_reg_in <= x"000000";
		end if;
			
	end process;
	
	LED_REG : reg port map(
						led_input => led_reg_in,
						clk => clk,
						en => '1',
						output => led_reg_out);
	LED <= led_reg_out;

end Behavioral;