library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is port(
	input: in std_logic_vector(3 downto 0);
	clk, rst, en: in std_logic;
	output: out std_logic_vector(3 downto 0)
);
end reg;

architecture Behavioral of reg is

component dff port(
	d, clk, rst, en: in std_logic;
	q: out std_logic
);
end component;

begin
	reg0: for n in  3 downto 0 generate
		reg: dff port map(
			d => input(n),
			clk => clk,
			rst => rst,
			en => en,
			q => output(n)
		);
	end generate;
end Behavioral;
