/*
 * Copyright (c) 2024 Yuri Panchul
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_yuri_panchul_schoolriscv_cpu_with_fibonacci_program
(
    input  [7:0] ui_in,    // Dedicated inputs
    output [7:0] uo_out,   // Dedicated outputs
    input  [7:0] uio_in,   // IOs: Input path
    output [7:0] uio_out,  // IOs: Output path
    output [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input        ena,      // always 1 when the design is powered, so you can ignore it
    input        clk,      // clock
    input        rst_n     // reset_n - low to reset
);

    //------------------------------------------------------------------------

    wire rst = ~ rst_n;

    wire [3:0] pc;
    wire [3:0] reg_a0;

    wire pass, fail;

    soc i_soc (.*);

    //------------------------------------------------------------------------

    assign uo_out  = { 6'b0, fail, pass };
    assign uio_out = { pc, reg_a0 };

    assign uio_oe  = '1;

    wire _unused = & { ena, ui_in, uio_in, 1'b0 };

endmodule
