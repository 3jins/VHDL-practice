library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity key_matrix is
	port (
		rst		: in std_logic;
		clk		: in std_logic;
		key_in	: in std_logic_vector(3 downto 0);
		key_scan	: out std_logic_vector(3 downto 0);
		key_data	: out std_logic_vector(3 downto 0);
		key_event : OUT STD_LOGIC
	);
end key_matrix;

architecture Behavioral of key_matrix is

component clock_divider_x4 is
	port(
		clk, rst	: in std_logic;
		dclk		: out std_logic
	);
end component;

signal scan_cnt		: std_logic_vector(3 downto 0);		-- input
signal key_data_int	: std_logic_vector(3 downto 0);		-- output
signal key_in_int		: std_logic_vector(3 downto 0);		-- input
signal seg_clk			: std_logic;
signal key_temp		: std_logic_vector(15 downto 0);
--signal key_event		: std_logic;

begin
	dvd0: clock_divider_x4 port map(clk=>clk, rst=>rst, dclk=>seg_clk);
	
	process(rst, seg_clk)
	begin
		if rst = '1' then
			scan_cnt <= "1110";
		elsif rising_edge(seg_clk) then
			scan_cnt <= scan_cnt(2 downto 0) & scan_cnt(3);
		end if;
	end process;
	
	process(rst, clk)
	begin
		if rst = '1' then
			key_in_int <= (others => '1');
		elsif rising_edge (clk) then
			key_in_int <= key_in;
		end if;
	end process;
	
	-- keypad push check
	process(rst, key_in_int, scan_cnt, seg_clk)
	begin
		if rst = '1' then
			key_temp <= (others => '1');
		elsif rising_edge(seg_clk) then
			case scan_cnt is
				when "1110" => key_temp(15 downto 12) <= key_in_int;
				when "1101" => key_temp(11 downto 8) <= key_in_int;
				when "1011" => key_temp(7 downto 4) <= key_in_int;
				when "0111" => key_temp(3 downto 0) <= key_in_int;
				when others => key_temp <= key_temp;
			end case;
		end if;
	end process;
	
	process(key_temp)
	begin
		if key_temp = X"FFFF" then
			key_event <= '0';
		else
			key_event <= '1';
		end if;
	end process;
		
	process(scan_cnt, key_in_int, seg_clk)
	begin
		if rising_edge(seg_clk) then
			case scan_cnt is
				when "1110" =>
					if key_in_int = "1110" then
						key_data_int(3 downto 0) <= X"1";
					elsif key_in_int = "1101" then
						key_data_int(3 downto 0) <= X"4";
					elsif key_in_int = "1011" then
						key_data_int(3 downto 0) <= X"7";
					elsif key_in_int = "0111" then
						key_data_int(3 downto 0) <= X"0";
					end if;
				when "1101" =>
					if key_in_int = "1110" then
						key_data_int(3 downto 0) <= X"2";
					elsif key_in_int = "1101" then
						key_data_int(3 downto 0) <= X"5";
					elsif key_in_int = "1011" then
						key_data_int(3 downto 0) <= X"8";
					elsif key_in_int = "0111" then
						key_data_int(3 downto 0) <= X"A";
					end if;
				when "1011" =>
					if key_in_int = "1110" then
						key_data_int(3 downto 0) <= X"3";
					elsif key_in_int = "1101" then
						key_data_int(3 downto 0) <= X"6";
					elsif key_in_int = "1011" then
						key_data_int(3 downto 0) <= X"9";
					elsif key_in_int = "0111" then
						key_data_int(3 downto 0) <= X"B";
					end if;
				when "0111" =>
					if key_in_int = "1110" then
						key_data_int(3 downto 0) <= X"F";
					elsif key_in_int = "1101" then
						key_data_int(3 downto 0) <= X"E";
					elsif key_in_int = "1011" then
						key_data_int(3 downto 0) <= X"D";
					elsif key_in_int = "0111" then
						key_data_int(3 downto 0) <= X"C";
					end if;
				when others =>
					key_data_int <= key_data_int;
			end case;
		end if;
	end process;
	
	key_data <= key_data_int;
	key_scan <= scan_cnt;
	
end Behavioral;
