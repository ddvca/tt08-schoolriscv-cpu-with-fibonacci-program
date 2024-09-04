<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

A minimalistic SoC with a schoolRISCV educational CPU and a ROM memory with a program that computes the Fibonacci numbers.

## How to test

A self-checking testbench for the design is located in a directory
*test_extra* that contains:

* *clean.bash* - a script to delete temporary files produced by *simulate.bash*.

* *simulate.bash* - a script that simulates the design together with a testbench
  using Icarus Verilog and produces *log.txt*.
  Before the simulation, the script compiles assemply *program.s*
  using RARS instruction set simulator (ISS) and generates a file
  *program.hex*. This *program.hex* file can be used to fill the ROM
  for either simulation or synthesis.

* *tb.sv* - a self-checking testbench that generates a log, a status  **PASS** or **FAIL**,
  and performance data.

After the manufacturing, the design can be manually tested by resetting,
driving a slow (3 MHz) clock, and observing the outputs.

## External hardware

Buttons, LEDs and an 8-digit 7-segment display.
