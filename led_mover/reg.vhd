library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
	port( 
		led_input : in STD_LOGIC_VECTOR(23 downto 0);
		clk, en : in STD_LOGIC;
		output : out STD_LOGIC_VECTOR(23 downto 0)
	);
end reg;

architecture Behavioral of reg is

COMPONENT dff
	port( 
		d, clk, en: in STD_LOGIC;
		q: out STD_LOGIC
	);
END COMPONENT;

begin
	reg0: FOR n in 23 downto 0 GENERATE
		reg: dff port map(
						d=>led_input(n),
						clk=>clk,
						en=>en,
						q=>output(n)
		);
	END GENERATE;
end Behavioral;