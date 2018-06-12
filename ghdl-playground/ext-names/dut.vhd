library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dut is
    Port (
    	clk		: in std_logic
    );
end dut;
architecture dut_arch of dut is
	signal local_sig : std_logic;
begin
	proc: process begin
		local_sig <= '0';
		wait for 50 ns;
		local_sig <= '1';
	end process;
end dut_arch;
