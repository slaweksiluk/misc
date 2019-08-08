#!/bin/bash
set -e
ghdl -a --std=08 a.vhd
ghdl -e --std=08 dut
