#!/bin/bash
set -e
ghdl -a --std=08 a.vhd
ghdl -e --std=08 wb_demux_tb
./wb_demux_tb --wave=w.ghw
gtkwave -a w.gtkw
