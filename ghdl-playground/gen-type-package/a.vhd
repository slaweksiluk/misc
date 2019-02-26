package pkg1 is
    generic (
        type gen_t;
        function to_str (x: gen_t) return string;
        function to_str2 (x: natural) return string;
        function to_range (x: gen_t) return bit_vector
    );
    procedure test (e : gen_t);
    procedure iter_enum (e : gen_t );
end package;
package body pkg1 is
    procedure test (e : gen_t) is
    begin
        -- Below is not supported by VHDL
        -- report "type image is: "&gen_t'image(e);
        -- Need to use generic subprogram as workaround
        report "type image is: "&to_str(e);
	end procedure;
    procedure iter_enum (e : gen_t ) is
    begin
        for i in to_range(e)'range loop
            report to_str2(i);
            report " = "&natural'image(i);
        end loop;
    end procedure;
end package body;

package pkg2 is
    -- Type 0 headers
    type enum0 is (RED, GREEN, BLUE);
    function enum0_to_str (x : enum0) return string;
    function enum0_to_str2 (x : natural) return string;
    function enum0_to_range (x : enum0) return bit_vector;
    package pkg0_inst is new work.pkg1
        generic map (
            gen_t => enum0,
            to_str => enum0_to_str,
            to_str2 => enum0_to_str2,
            to_range => enum0_to_range
        );
    -- Type 1 headers
    type enum1 is (ONE, TWO, THREE);
    function enum1_to_str (x : enum1) return string;
    function enum1_to_str2 (x : natural) return string;
    function enum1_to_range (x : enum1) return bit_vector;
    package pkg1_inst is new work.pkg1
        generic map (
            gen_t => enum1,
            to_str => enum1_to_str,
            to_str2 => enum1_to_str2,
            to_range => enum1_to_range
        );
    end;
package body pkg2 is
    -- Type 0 impl
    function enum0_to_str (x : enum0) return string is begin
        return enum0'image(x);
    end function;
    function enum0_to_str2 (x : natural) return string is begin
        return enum0'image(enum0'val(x));
    end function;
    function enum0_to_range (x : enum0) return bit_vector is
        variable v : bit_vector(enum0'pos(enum0'low) to enum0'pos(enum0'high));
    begin
        return v;
    end function;
    -- Type 1 impl
    function enum1_to_str (x : enum1) return string is begin
        return enum1'image(x);
    end function;
    function enum1_to_str2 (x : natural) return string is begin
        return enum1'image(enum1'val(x));
    end function;
    function enum1_to_range (x : enum1) return bit_vector is
        variable v : bit_vector(enum1'pos(enum1'low) to enum1'pos(enum1'high));
    begin
        return v;
    end function;
end package body;


use work.pkg2.all;
use pkg0_inst.all;
use pkg1_inst.all;
entity test_e is
end entity test_e;
architecture sim of test_e is
begin
    main : process begin
        report "%%% test enum1";
        test(RED);
        test(GREEN);
        test(BLUE);
        report "iterate over enum";
        iter_enum(enum0'left);
        report "%%% test enum2";
        test(ONE);
        test(TWO);
        test(THREE);
        report "iterate over enum";
        iter_enum(enum1'left);
        std.env.finish;
    end process;
end architecture sim;
