library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.MyTestPkg2.all;
entity test_e3 is
end entity test_e3;
architecture sim of test_e3 is
begin
  test("entity 3");
end architecture sim;
