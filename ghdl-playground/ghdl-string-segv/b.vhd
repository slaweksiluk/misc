library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb2 is
end entity;

architecture bench2 of tb2 is

	constant kill_size : positive := 50331648;

	type queue_t is array (0 to 1) of std_logic_vector(1 downto 0);

	impure function pop_fix_string(queue : queue_t; length : natural) return string is
		variable result : string(1 to length);
	begin
		return result;
	end;

	impure function pop_variable_string(queue : queue_t) return string is
		constant length : integer := kill_size;
		variable v : string(1 to length);
	begin
		return pop_fix_string(queue, length);
	end;

	constant queue : queue_t := ("00", "11");

	signal s : string(1 to 2);


begin

	proc: process begin
		wait for 1 ns;
		s <= pop_variable_string(queue);
		report "pass" severity failure;
	end process;

end bench2;
