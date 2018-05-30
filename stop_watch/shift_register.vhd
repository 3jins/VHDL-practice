library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is port(
	shreg0, shreg1, shreg2, shreg3, shreg4, shreg5: out std_logic_vector(3 downto 0);
	input: in std_logic_vector(3 downto 0);
	clk, rst: in std_logic
);
end shift_register;

architecture Behavioral of shift_register is

component reg port(
	input: in std_logic_vector(3 downto 0);
	clk, rst, en: in std_logic;
	output: out std_logic_vector(3 downto 0)
);
end component;

signal shift_reg0, shift_reg1, shift_reg2, shift_reg3, shift_reg4, shift_reg5: std_logic_vector(3 downto 0);

begin
	REG0: reg port map(input=>input, clk=>clk, rst=>rst, en=>'1', output=>shift_reg0);
	REG1: reg port map(input=>shift_reg0, clk=>clk, rst=>rst, en=>'1', output=>shift_reg1);
	REG2: reg port map(input=>shift_reg1, clk=>clk, rst=>rst, en=>'1', output=>shift_reg2);
	REG3: reg port map(input=>shift_reg2, clk=>clk, rst=>rst, en=>'1', output=>shift_reg3);
	REG4: reg port map(input=>shift_reg3, clk=>clk, rst=>rst, en=>'1', output=>shift_reg4);
	REG5: reg port map(input=>shift_reg4, clk=>clk, rst=>rst, en=>'1', output=>shift_reg5);
	
	shreg0 <= shift_reg0;
	shreg1 <= shift_reg1;
	shreg2 <= shift_reg2;
	shreg3 <= shift_reg3;
	shreg4 <= shift_reg4;
	shreg5 <= shift_reg5;

end Behavioral;

