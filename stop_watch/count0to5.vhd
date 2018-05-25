library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity count0to5 is port(
	clk, rst: in STD_LOGIC;
	cnt: out STD_LOGIC_VECTOR(2 downto 0)
);
end count0to5;

architecture Behavioral of count0to5 is
signal cnt_data: STD_LOGIC_VECTOR(2 downto 0);
begin
	process(CLK, RST)
	begin
		if rst = '1' then
			cnt_data <= (others => '0');
		elsif clk'event and clk = '1' then
			if cnt_data = "101" then
				cnt_data <= (others => '0');
			else
				cnt_data <= cnt_data + 1;
			end if;
		end if;
	end process;
	
	cnt <= cnt_data;
	
end Behavioral;

