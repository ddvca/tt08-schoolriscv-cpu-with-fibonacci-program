`include "config.svh"

module soc
(
    input              clk,
    input              rst,

    output       [3:0] pc,
    output       [3:0] reg_a0,

    output logic       pass,
    output logic       fail
);

    //------------------------------------------------------------------------

    wire [ 4:0] regAddr;  // debug access reg address
    wire [31:0] regData;  // debug access reg data
    wire [31:0] imAddr;   // instruction memory address
    wire [31:0] imData;   // instruction memory data

    sr_cpu cpu
    (
        .clk     ( clk      ),
        .rst     ( rst      ),
        .regAddr ( regAddr  ),
        .regData ( regData  ),
        .imAddr  ( imAddr   ),
        .imData  ( imData   )
    );

    instruction_rom # (.SIZE (64)) rom
    (
        .a       ( imAddr   ),
        .rd      ( imData   )
    );

    //------------------------------------------------------------------------

    assign regAddr = 5'd10;  // a0

    assign pc     = imAddr  [3:0];
    assign reg_a0 = regData [3:0];

    //------------------------------------------------------------------------

    logic [7:0] cnt;

    always_ff @ (posedge clk)
        if (rst)
            cnt <= '0;
        else
            cnt <= cnt + 1'd1;

    //------------------------------------------------------------------------

    always_ff @ (posedge clk)
        if (rst)
            pass <= 1'b0;
        else if (regData == 32'h00213d05)
            pass <= 1'b1;

    always_ff @ (posedge clk)
        if (rst)
            fail <= 1'b0;
        else if (& cnt == 1'b1 & ~ pass)
            fail <= 1'b1;

endmodule
