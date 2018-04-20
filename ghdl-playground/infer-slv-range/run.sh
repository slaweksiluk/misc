#!/bin/bash
set -e
ghdl -a range_addr_decoder.vhd
ghdl -a range_addr_decoder_tb.vhd
ghdl -e range_addr_decoder_tb
./range_addr_decoder_tb
