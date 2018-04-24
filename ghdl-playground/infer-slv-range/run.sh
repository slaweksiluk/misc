#!/bin/bash
set -e
ghdl -a ghdl_bug.vhd
ghdl -e tb
./tb
