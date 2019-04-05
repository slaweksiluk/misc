library vunit_lib;
context vunit_lib.vunit_context;

entity testbench is
	generic (runner_cfg : string);
end entity testbench;
architecture bench of testbench is
	signal a : string(1 to 1) := "A";
	signal b : string(1 to 1) := "B";
	signal c : string(1 to 1) := "C";
begin
	main : process
	begin
		test_runner_setup(runner, runner_cfg);
		report "Hello world!";
		test_runner_cleanup(runner);
	end process;
	dut_inst : configuration work.dut_sim_config
		port map(a => a,
			     b => b,
			     c => c);
end architecture bench;
