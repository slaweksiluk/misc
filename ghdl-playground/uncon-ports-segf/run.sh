#!/bin/bash
set -e
ghdl -a -g --std=08 a.vhd
ghdl -e --std=08 tb
./tb
