library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
	port (
		clk, rst	: in STD_LOGIC;
		key_in	: in std_logic_vector(3 downto 0);
		key_scan	: out std_logic_vector(3 downto 0);
		key_data	: out std_logic_vector(3 downto 0);
		dig		: out std_logic_vector(5 downto 0);
		segment	: out std_logic_vector(7 downto 0);
		seginput1, seginput2, seginput3, seginput4, seginput5, seginput6: in std_logic_vector(3 downto 0)
	);
end main;

architecture Behavioral of main is

component key_matrix is
	port (
		rst		: in std_logic;
		clk		: in std_logic;
		key_in	: in std_logic_vector(3 downto 0);
		key_scan	: out std_logic_vector(3 downto 0);
		key_data	: out std_logic_vector(3 downto 0)
	);
end component;

component seven_segment is
	port (
		clk, rst: in std_logic;
		seginput1, seginput2, seginput3, seginput4, seginput5, seginput6: in std_logic_vector(3 downto 0);
		dig: out std_logic_vector(5 downto 0);
		segment: out std_logic_vector(7 downto 0)
	);
end component;

component clock_divider_x4 is
	port ( 
		clk, rst	: in std_logic;
		dclk 		: out std_logic
	);
end component;

signal rst_inv, seg_clk	: std_logic;
type seg_in is 			  array(0 to 5) of std_logic_vector(3 downto 0);
signal seg_input			: seg_in;
signal key_data_sig			: std_logic_vector(3 downto 0);

begin
	rst_inv <= not rst;
	dvd1: clock_divider_x4 port map(
				clk => clk,
				rst => rst_inv,
				dclk => seg_clk
	);
	key_pad: key_matrix port map(
				rst => rst_inv,
				clk => seg_clk,
				key_in => key_in,
				key_scan => key_scan,
				key_data => key_data_sig
	);
	
	seg_input(0) <= key_data_sig;
	seg_input(1) <= key_data_sig;
	seg_input(2) <= key_data_sig;
	seg_input(3) <= key_data_sig;
	seg_input(4) <= key_data_sig;
	seg_input(5) <= key_data_sig;
	
	seg: seven_segment port map(
		clk => seg_clk,
		rst => rst_inv,
		seginput1 => seg_input(0),
		seginput2 => seg_input(1),
		seginput3 => seg_input(2),
		seginput4 => seg_input(3),
		seginput5 => seg_input(4),
		seginput6 => seg_input(5),
		dig => dig,
		segment => segment
	);

end Behavioral;
