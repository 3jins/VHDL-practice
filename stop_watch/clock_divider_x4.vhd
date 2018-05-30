library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider_x4 is port ( 
	clk, rst: in STD_LOGIC;
	dclk: out STD_LOGIC
);

end clock_divider_x4;

architecture Behavioral of clock_divider_x4 is

signal cnt_data: STD_LOGIC_VECTOR(3 downto 0);
signal d_clk	: std_logic;

begin
	process(clk, rst)
	begin
		if rst='1' then
			cnt_data<=(others=>'0');
			d_clk<='0';
		elsif clk'event and clk='1' then
			if cnt_data=x"F" then
				cnt_data<=(others=>'0');
				d_clk<=not d_clk;
			else
				d_clk<=d_clk;
				cnt_data<=cnt_data+'1';
			end if;
		end if;
	end process;
	
	dclk<=d_clk;

end Behavioral;
