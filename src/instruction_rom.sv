//
//  schoolRISCV - small RISC-V CPU
//
//  Originally based on Sarah L. Harris MIPS CPU
//  & schoolMIPS project.
//
//  Copyright (c) 2017-2020 Stanislav Zhelnio & Aleksandr Romanov.
//
//  Modified in 2024 by Yuri Panchul & Mike Kuskov
//  for systemverilog-homework project.
//

module instruction_rom
#(
    parameter SIZE = 64
)
(
    input  [31:0] a,
    output [31:0] rd
);
    `ifdef UNDEFINED

        logic [31:0] rom [0:SIZE - 1];
        assign rd = rom [a];

        initial $readmemh ("program.hex", rom);

    `endif

    logic [31:0] rom [0:15];
    assign rd = rom [a [3:0]];

    assign rom [ 0] = 32'h12300293;
    assign rom [ 1] = 32'h12345337;
    assign rom [ 2] = 32'h67830313;
    assign rom [ 3] = 32'h123453b7;
    assign rom [ 4] = 32'h00038393;
    assign rom [ 5] = 32'hedd00e13;
    assign rom [ 6] = 32'h00000533;
    assign rom [ 7] = 32'h00100293;
    assign rom [ 8] = 32'h00550333;
    assign rom [ 9] = 32'h00500533;
    assign rom [10] = 32'h006002b3;
    assign rom [11] = 32'hfe000ae3;

    assign rom [12] = 32'hdeadbeef;
    assign rom [13] = 32'hdeadbeef;
    assign rom [14] = 32'hdeadbeef;
    assign rom [15] = 32'hdeadbeef;

endmodule
