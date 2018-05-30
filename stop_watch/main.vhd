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

component key_matrix is port (
	rst		: in std_logic;
	clk		: in std_logic;
	key_in	: in std_logic_vector(3 downto 0);
	key_scan	: out std_logic_vector(3 downto 0);
	key_data	: out std_logic_vector(3 downto 0);
	key_event : OUT STD_LOGIC
);
end component;

component seven_segment is port (
	clk, rst: in std_logic;
	seginput1, seginput2, seginput3, seginput4, seginput5, seginput6: in std_logic_vector(3 downto 0);
	dig: out std_logic_vector(5 downto 0);
	segment: out std_logic_vector(7 downto 0)
);
end component;

component clock_divider is port ( 
	clk, rst	: in std_logic;
	dclk 		: out std_logic
);
end component;

component shift_register is port(
	shreg0, shreg1, shreg2, shreg3, shreg4, shreg5: out std_logic_vector(3 downto 0);
	input: in std_logic_vector(3 downto 0);
	clk, rst: in std_logic
);
end component;

signal rst_inv, seg_clk, key_event: std_logic;
type seg_in is array(0 to 5) of std_logic_vector(3 downto 0);
signal seg_input, key_data_sig: seg_in;
signal key_pad_out: std_logic_vector(3 downto 0);

begin
	rst_inv <= not rst;
	dvd1: clock_divider port map(
		clk => clk,
		rst => rst_inv,
		dclk => seg_clk
	);
	key_pad: key_matrix port map(
		rst => rst_inv,
		clk => seg_clk,
		key_in => key_in,
		key_scan => key_scan,
		key_data => key_pad_out,
		key_event => key_event
	);
	shr: shift_register port map(
		clk => key_event,
		rst => rst_inv,
		input => key_pad_out,
		shreg0 => key_data_sig(0),
		shreg1 => key_data_sig(1),
		shreg2 => key_data_sig(2),
		shreg3 => key_data_sig(3),
		shreg4 => key_data_sig(4),
		shreg5 => key_data_sig(5)
	);
	
	seg_input(0) <= key_data_sig(0);
	seg_input(1) <= key_data_sig(1);
	seg_input(2) <= key_data_sig(2);
	seg_input(3) <= key_data_sig(3);
	seg_input(4) <= key_data_sig(4);
	seg_input(5) <= key_data_sig(5);
	
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
