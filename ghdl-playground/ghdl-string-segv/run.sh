#!/bin/bash
set -e
ghdl -a -g a.vhd
ghdl -e -g tb
./tb
