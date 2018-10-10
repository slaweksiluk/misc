#!/bin/bash
ghdl -a --std=08 a.vhd
ghdl -e --std=08 wb_demux_tb
echo "without ghw"
./wb_demux_tb
echo "with ghw"
./wb_demux_tb --wave=w.ghw
