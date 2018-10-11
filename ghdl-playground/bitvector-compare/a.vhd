library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb is
end entity;
architecture bench of tb is

	type packet_db_record_t is record
		ip_src               : bit_vector(4*8 -1 downto 0);
		ip_dst               : bit_vector(4*8 -1 downto 0);
		port_src             : natural range 0 to 65535;
		port_dst             : natural range 0 to 65535;
		src_pkts             : natural;
		src_octets           : natural;
		pkts                 : natural;
		octets               : natural;
	end record;

	type lookup_cmd_t is (LOOKUP_DROP, LOOKUP_UPDATE, LOOKUP_NEW, LOOKUP_ERR);

	constant C_MAX_CE_FLOW_NUM : positive := 128;

	type frm_model_t is protected
		procedure insert(packet : packet_db_record_t; cmd : lookup_cmd_t);
		procedure remove(packet : packet_db_record_t);
		impure function db_is_empty return boolean;
	end protected frm_model_t;

	type frm_model_t is protected body
		type db_item_t is record
			active    : boolean;
			touchtime : time;
			packet    : packet_db_record_t;
		end record;
		subtype flows_range is natural range 0 to C_MAX_CE_FLOW_NUM;
		type array_t is array (flows_range) of db_item_t;
		variable a : array_t;

		function to_string (p : packet_db_record_t) return string is
		begin
			return LF&
				"ip_src "&to_hstring(p.ip_src)&LF&
				"ip_dst "&to_hstring(p.ip_dst)&LF&
				"port_src "&to_string(p.port_src)&LF&
				"port_dst "&to_string(p.port_dst)&LF&
				"src_pkts "&to_string(p.src_pkts)&LF&
				"src_octets "&to_string(p.src_octets)&LF&
				"pkts "&to_string(p.pkts)&LF&
				"octets "&to_string(p.octets);
		end function;

		function item_match(item : db_item_t; packet : packet_db_record_t) return boolean is
		begin
			if not item.active then
				return false;
			end if;
			report to_string(item.packet.ip_src)&" vs "&to_string(item.packet.ip_src);
			if item.packet.ip_src = packet.ip_src then
				report "compare true!";
				return true;
			end if;
			return false;
		end function;

		procedure item_inc(i :natural; packet : packet_db_record_t) is
		begin
			a(i).packet.src_pkts := a(i).packet.src_pkts + packet.src_pkts;
			a(i).packet.src_octets := a(i).packet.src_octets + packet.src_octets;
			a(i).packet.pkts := a(i).packet.pkts + packet.pkts;
			a(i).packet.octets := a(i).packet.octets + packet.octets;
		end procedure;

		procedure item_new(i :natural; packet : packet_db_record_t) is
		begin
			a(i).packet.src_pkts := 0;
			a(i).packet.src_octets := 0;
			a(i).packet.pkts := 0;
			a(i).packet.octets := 0;
			item_inc(i, packet);
			a(i).active := true;
			--debug(tb_logger, "new db item"&to_string(packet));
			report "new db item"&to_string(packet);
		end procedure;

		procedure item_dec(i :natural; packet : packet_db_record_t) is
		begin
			a(i).packet.src_pkts := a(i).packet.src_pkts - packet.src_pkts;
			a(i).packet.src_octets := a(i).packet.src_octets - packet.src_octets;
			a(i).packet.pkts := a(i).packet.pkts - packet.pkts;
			a(i).packet.octets := a(i).packet.octets - packet.octets;
		end procedure;

		procedure insert(packet : packet_db_record_t; cmd : lookup_cmd_t) is
			variable pass : boolean := true;
		begin
			case cmd is
			when LOOKUP_DROP =>
				-- just ignore
			when LOOKUP_UPDATE =>
				-- find what to update
				for i in a'range loop
					if item_match(a(i), packet) then
						item_inc(i, packet);
						pass := true;
					end if;
				end loop;
				--check_true(pass, "failed to update db");
			when LOOKUP_NEW =>
				for i in a'range loop
					if not a(i).active then
						item_new(i, packet);
						pass := true;
						exit;
					end if;
				end loop;
				--check_true(pass, "failed to insert db");
			when others =>
				--error("lookup error");
			end case;
		end procedure insert;

		procedure remove(packet : packet_db_record_t) is
			variable pass : boolean := false;
		begin
			for i in a'range loop
				if item_match(a(i), packet) then
					item_dec(i, packet);
					pass := true;
					--debug(tb_logger, "remove db item"&to_string(packet));
					report "remove db item"&to_string(packet);
				end if;
			end loop;
			--check_true(pass, "has not found packet to remove from db "&to_string(packet));
			assert pass report "has not found" severity failure;
		end procedure;

		impure function db_is_empty return boolean is
		begin
			for i in a'range loop
				if a(i).active and (a(i).packet.src_pkts /= 0 or a(i).packet.pkts /= 0) then
					return false;
				end if;
			end loop;
			return true;
		end function;

	end protected body;

	shared variable frm_database: frm_model_t;


begin
	proc: process
		variable packet : packet_db_record_t;
	begin
		packet := (x"aabbcc01", x"00112202", 01, 02, 1, 1, 1, 1);
		frm_database.insert(packet, LOOKUP_NEW);
		frm_database.remove(packet);
		std.env.stop(0);
	end process;
end bench;
