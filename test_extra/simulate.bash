#!/usr/bin/env bash

set -Eeuo pipefail  # See the meaning in scripts/README.md
# set -x  # Print each command

rm -rf run
mkdir  run
cd     run

#-----------------------------------------------------------------------------

#  nc                              - Copyright notice will not be displayed
#  a                               - assembly only, do not simulate
#  ae<n>                           - terminate RARS with integer exit code if an assemble error occurs
#  dump .text HexText program.hex  - dump segment .text to program.hex file in HexText format

java -jar ../../bin/rars1_6.jar  \
    nc a ae1 dump .text HexText  \
    program.hex ../program.s

# We need to copy it for synthesis
cp program.hex ../../src/program.hex

#-----------------------------------------------------------------------------

iverilog -g2005-sv -s tb          \
    -I ..      -I ../../src       \
       ../*.sv    ../../src/*.sv  \
    |& tee ../log.txt

vvp a.out |& tee ../log.txt

#-----------------------------------------------------------------------------

gtkwave dump.vcd --script ../gtkwave.tcl
