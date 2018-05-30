library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is port(
	d, clk, rst, en: in std_logic;
	q: out std_logic
);
end dff;

architecture Behavioral of dff is
signal data: std_logic;

begin
	process(clk, rst, en)
	begin
		if rst = '1' then
			data <= '0';
		elsif en = '1' then
			if clk'event and clk = '1' then
				data <= d;
			else
				data <= data;
			end if;
		end if;
	end process;

	q <= data;

end Behavioral;
