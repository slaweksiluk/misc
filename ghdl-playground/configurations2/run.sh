#!/bin/bash
set -e
ghdl -a --std=08 unrelated.vhd
ghdl -a --std=08 dut.vhd
ghdl -a --std=08 testbench.vhd
ghdl -e --std=08 testbench
./testbench
