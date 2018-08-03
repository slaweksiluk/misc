library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity;

architecture bench of tb is

	signal clk : std_logic := '0';
	signal pulse : std_logic := '0';
	signal cnt : natural := 0;
	constant CLK_PERIOD : time := 10 ns;

begin

	main: process
	begin
		wait until rising_edge(clk);
		pulse <= '1';
		wait until rising_edge(clk);
		pulse <= '0';

		-- oneline pulse generation
		wait until rising_edge(clk);
		pulse <= '1', '0' after CLK_PERIOD;

		wait for 20 ns;
	wait;
	end process;

	count: process
	begin
		wait until rising_edge(clk) and pulse = '1';
		cnt <= cnt +1;
		report "pulse detected";
	end process;

	clk <= not clk after CLK_PERIOD / 2;

end bench;
