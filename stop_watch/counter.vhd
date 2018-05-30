library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter is port(
	start, clk: in std_logic;
	key_in: in std_logic_vector(3 downto 0);
	key_scan: out std_logic_vector(3 downto 0);
	key_data: out std_logic_vector(3 downto 0);
	key_event: OUT STD_LOGIC
);
end counter;

architecture Behavioral of counter is

begin


end Behavioral;

