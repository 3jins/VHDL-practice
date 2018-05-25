library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_segment is
	port (
		clk, rst: in STD_LOGIC;
		seginput1, seginput2, seginput3, seginput4, seginput5, seginput6: in STD_LOGIC_VECTOR(3 downto 0);
		dig: out STD_LOGIC_VECTOR(5 downto 0);
		segment: out STD_LOGIC_VECTOR(7 downto 0)
	);
end seven_segment;

architecture Behavioral of seven_segment is

component count0to5 is port(
	clk, rst: in STD_LOGIC;
	cnt: out STD_LOGIC_VECTOR(2 downto 0)
);
end component;

signal seg_int: STD_LOGIC_VECTOR(7 downto 0);
signal display_data: STD_LOGIC_VECTOR(3 downto 0);
signal clk_count: STD_LOGIC_VECTOR(2 downto 0);
signal digit: STD_LOGIC_VECTOR(5 downto 0);

begin
	C5: count0to5 port map(
		clk => clk,
		rst => rst,
		cnt => clk_count
	);
	
	process(clk, rst)
	begin
		if rst='1' then
			digit <= "000001";
		else
			if rising_edge(clk) then
				case clk_count is
					when "000" => digit <= "000001";
					when "001" => digit <= "000010";
					when "010" => digit <= "000100";
					when "011" => digit <= "001000";
					when "100" => digit <= "010000";
					when "101" => digit <= "100000";
					when others => digit <= "000000";
				end case;
			end if;
		end if;			
	end process;

	process(digit, rst, seginput1, seginput2, seginput3, seginput4, seginput5, seginput6)
	begin
		case digit is
			when "000001" => display_data <= seginput1;
			when "000010" => display_data <= seginput2;
			when "000100" => display_data <= seginput3;
			when "001000" => display_data <= seginput4;
			when "010000" => display_data <= seginput5;
			when "100000" => display_data <= seginput6;
			when others => display_data <= "0000";
		end case;
	end process;

	process(display_data)
	begin
		case display_data is
			when X"0" => seg_int <= "11111101";
			when X"1" => seg_int <= "01100001";
			when X"2" => seg_int <= "11011011";
			when X"3" => seg_int <= "11110011";
			when X"4" => seg_int <= "01100111";
			when X"5" => seg_int <= "10110111";
			when X"6" => seg_int <= "10111111";
			when X"7" => seg_int <= "11100101";
			when X"8" => seg_int <= "11111111";
			when X"9" => seg_int <= "11110111";
			when X"a" => seg_int <= "11111011";
			when X"b" => seg_int <= "00111111";
			when X"c" => seg_int <= "10011101";
			when X"d" => seg_int <= "01111011";
			when X"e" => seg_int <= "10011111";
			when X"f" => seg_int <= "10001111";
			when others => seg_int <= (others => '0');
		end case;
	end process;
	
	dig <= digit;
	segment <= seg_int;
	
end Behavioral;
