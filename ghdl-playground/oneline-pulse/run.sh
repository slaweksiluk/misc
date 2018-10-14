#!/bin/bash
set -e
ghdl -a a.vhd
ghdl -e tb
./tb --wave=w.ghw
