entity unrelated is
	port(
		a : in string(1 to 1);
		b : out string(1 to 1)
	);
end entity unrelated;

architecture RTL of unrelated is

begin
	process is
	begin
		report "this is unrelated(RTL)";
		report unrelated'instance_name;
		report "a:" & a;
		report "b:" & b;
		wait;
	end process;
end architecture RTL;
