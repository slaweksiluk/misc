#!/bin/bash
set -e
ghdl -a --std=08 a.vhd
ghdl -a --std=08 a2.vhd
ghdl -e --std=08 test_e
./test_e

ghdl -e --std=08 test_e2
./test_e2

ghdl -e --std=08 test_e3
./test_e3
