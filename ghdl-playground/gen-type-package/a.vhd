package pkg1 is
    generic ( type gen_t );
    procedure test(e : gen_t);
end package;
package body pkg1 is
    procedure test(e : gen_t)
	is begin
        report "type image is: "&gen_t'image(e);
	end procedure;
end package body;

package pkg2 is
    type enum0 is (RED, GREEN, BLUE);
    package pkg1_inst is new work.pkg1 generic map (gen_t => enum0);
end;

use work.pkg2.all;
use pkg1_inst.all;
entity test_e is
end entity test_e;
architecture sim of test_e is
begin
    main : process begin
        test(RED);
        std.env.finish;
    end process;
end architecture sim;
