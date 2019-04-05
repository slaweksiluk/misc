
entity dut is
	port(
		a : in string(1 to 1);
		b : out string(1 to 1);
		c : in string(1 to 1)
	);
end entity dut;
architecture rtl of dut is
	component dut_internal
	port(a : in string(1 to 1);
		 b : out string(1 to 1);
		 c : in string(1 to 1);
		 d : out string(1 to 1)
		 );
	end component dut_internal;
	signal	d :  string(1 to 1);
begin
	process is begin
		report "this is dut(rtl)";
		report dut'instance_name;
		report "port a:" & a;
		report "port b:" & b;
		report "port c:" & c;
		wait;
	end process;

	dut_internal_inst : dut_internal
	port map (
		a => a,
		b => b,
		c => c,
		d => d
	);
end architecture rtl;

configuration dut_sim_config of dut is
for rtl
	for dut_internal_inst : dut_internal
		use entity work.unrelated(rtl)
		port map(
			a => a,
			b => b
		);
	end for;
end for;
end dut_sim_config;
