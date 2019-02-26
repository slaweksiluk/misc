library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package const_pkg is
	constant REGULAR_PKG_CONST : natural := 12;
end package const_pkg;

package test_p is
	generic ( G_TEST  : natural := 111 );
	constant DEF_INIT : natural := 35;
	-- Below generic is syntax error, has to be placed as first line in pkg
	-- generic ( G_TEST  : natural := DEF_INIT );
  procedure test(id : string);
end package test_p;

package body test_p is
  procedure test(id : string)
  is begin
    report "id: "&id;
  	report test'path_name;
  	report test'instance_name;
  	report test'simple_name;
    report "G_TEST: " & integer'image(G_TEST);
  end procedure test;
end package body;

entity test_e is
	generic ( constant G_ENTITY : natural := 77 );
end entity test_e;

-- Error as genric is not seen here...
-- package MyTestPkg is new work.test_p generic map (G_TEST => G_ENTITY);

-- Below declaration is visible by ALL entities in design with name MyTestPkg
-- it also uses constant from regular package as initializer. It seems using
-- constant from entity generic as generic value is not possible
package MyTestPkg is new work.test_p generic map (G_TEST => work.const_pkg.REGULAR_PKG_CONST);
package MyTestPkg2 is new work.test_p generic map (G_TEST => 333333);

architecture sim of test_e is
  use work.MyTestPkg.all;
begin
  test("entity 1");
end architecture sim;

use work.MyTestPkg.all;
entity test_e2 is
end entity test_e2;
architecture sim of test_e2 is
begin
  test("entity 2");
end architecture sim;
