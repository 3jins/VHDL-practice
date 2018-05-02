library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg1 is
	port( 
		input : in STD_LOGIC_VECTOR(7 downto 0);
		clk, reset, en : in STD_LOGIC;
		output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end reg1;

architecture Behavioral of reg1 is

COMPONENT dff
	port( 
		d, clk, reset, en : in STD_LOGIC;
		q: out STD_LOGIC
	);
END COMPONENT;

begin
	reg0: FOR n in 7 downto 0 GENERATE
		reg: dff port map(
						d=>input(n),
						clk=>clk,
						reset=>reset,
						en=>en,
						q=>output(n)
		);
	END GENERATE;
end Behavioral;