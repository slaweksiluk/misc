library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity range_addr_decoder_tb is
--generic (
--	runner_cfg : string
--);
end entity;

architecture bench of range_addr_decoder_tb is

	--constant TARGETS_ADDR : std_logic_vector := x"00000000";

begin

	dut : entity work.range_addr_decoder
	generic map	(
		TARGETS_ADDR => x"00000000"
	);

	stimulus : process
	begin
	report "pass";
	wait;
	end process;

end architecture;

