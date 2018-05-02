library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clkdivider is
	port (
		clk: in STD_LOGIC;
		mode: in STD_LOGIC_VECTOR(1 downto 0);
		dclk: out STD_LOGIC;
		cur_led: out STD_LOGIC_VECTOR(3 downto 0)
	);
end clkdivider;

architecture Behavioral of clkdivider is
	signal cnt_data: STD_LOGIC_VECTOR(23 downto 0);
	signal dcnt_data: STD_LOGIC_VECTOR(3 downto 0);
begin
	process(clk)
	begin
		if clk'event and clk='1' then
			if cnt_data = x"ffffff" then
				cnt_data <= (others=> '0');
				dclk <= '0';
				if mode = "10" then -- shift right
					if dcnt_data = x"5" then
						dcnt_data <= x"0";
					else
						dcnt_data <= dcnt_data + '1';
					end if;
					cur_led <= dcnt_data;
				elsif mode = "01" then -- shift left
					if dcnt_data = x"0" then
						dcnt_data <= x"5";
					else
						dcnt_data <= dcnt_data - '1';
					end if;
					cur_led <= dcnt_data;
				end if;
			elsif cnt_data = x"7fffff" then
				dclk <= '1';
				if mode = "10" then -- shift right
					if dcnt_data = x"5" then
						dcnt_data <= x"0";
					else
						dcnt_data <= dcnt_data + '1';
					end if;
					cur_led <= dcnt_data;
				elsif mode = "01" then -- shift left
					if dcnt_data = x"0" then
						dcnt_data <= x"5";
					else
						dcnt_data <= dcnt_data - '1';
					end if;
					cur_led <= dcnt_data;
				end if;
				cnt_data <= cnt_data + '1';
			else
				cnt_data <= cnt_data + '1';
			end if;
		end if;
	end process;
end Behavioral;