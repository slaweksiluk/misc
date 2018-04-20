library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity range_addr_decoder is
Generic (
	TARGETS_ADDR : std_logic_vector
);
end range_addr_decoder;
architecture comb of range_addr_decoder is

	signal slv : std_logic_vector(31 downto 0);

	type slv_arr_t is array (0 to 1) of std_logic_vector(slv'range);

	function addr_arr_init (
		arg : std_logic_vector
	) return slv_arr_t is
		variable v : slv_arr_t;
	begin
		report "arg'length="&positive'image(arg'length);
		report "v(0)'length="&positive'image(v(0)'length);

		-- Bound check error
		v(0) := arg(31 downto 0);

		-- No bound error?
		--v(0) := addresses;
		return v;
	end function;

	constant ADDR_ARR : slv_arr_t := addr_arr_init(TARGETS_ADDR);
begin

end comb;
