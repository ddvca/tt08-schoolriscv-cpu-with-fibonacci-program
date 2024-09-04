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

    localparam clk_mhz = 50,
               w_key   = 1,
               w_digit = 8;

    //------------------------------------------------------------------------

    wire                 rst;
    wire                 slow_clk_en;
    wire                 key;

    wire [          7:0] abcdefgh;
    wire [w_digit - 1:0] digit;

    //------------------------------------------------------------------------

    assign rst     = ~ rst_n';
    assign key     =   ui_in [0];

    assign uo_out  =   abcdefgh;
    assign uio_out =   digit;

    assign uio_oe  = '1;

    wire _unused = & { ena, ui_in [7:1], uio_in, 1'b0 };

    //------------------------------------------------------------------------

    strobe_gen
    # (
        .clk_mhz      ( clk_mhz     ),
        .strobe_hz    ( 3           )
    )
    i_strobe_gen
    (
        .clk          ( clk         ),
        .rst          ( rst         ),
        .strobe       ( slow_clk_en )
    );

    //------------------------------------------------------------------------

    lab_top
    # (
        .clk_mhz      ( clk_mhz     ),
        .w_key        ( w_key       ),
        .w_sw         ( w_sw        ),
        .w_digit      ( w_digit     )
    )
    i_lab_top
    (
        .clk          ( clk         ),

        .slow_clk     ( slow_clk    ),
        .slow_clk_en  ( slow_clk_en ),

        .rst          ( rst         ),

        .key          ( key         ),
        .sw           ( sw          ),
        .led          (             ),

        .abcdefgh     ( abcdefgh    ),
        .digit        ( digit       ),

        .x            (             ),
        .y            (             ),

        .red          (             ),
        .green        (             ),
        .blue         (             ),

        .mic          (             ),
        .sound        (             ),

        .uart_rx      (             ),
        .uart_tx      (             ),

        .gpio         (             )
    );

endmodule
