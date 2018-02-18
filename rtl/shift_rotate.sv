// ------------------------------------------//
// Shift Rotate unit File for SPU-Lite Processor
// ------------------------------------------//
// Authors:
// NAME:  Atif Iqbal
// NETID: aahangar
// SBUID: 111416569
//
// NAME: Karthik Raj
// NETID: karamachandr
// SBUID: 111675685
// ------------------------------------------//

import defines_pkg::*;

module shift_rotate #(parameter OPCODE_LEN  = 11,
                      parameter REG_ADDR_WD = 7,
                      parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst,
    input  Opcodes                   opcode,
    input  logic [REG_DATA_WD-1:0]   in_RA,
    input  logic [REG_DATA_WD-1:0]   in_RB,
    input  logic [6:0]               in_I7;
    input  logic [9:0]               in_I10,
    input  logic [15:0]              in_I16,
    input  logic [17:0]              in_I18,
    output logic [REG_DATA_WD-1:0]   out_RT
);

    always_comb begin

        case(opcode)

            SHIFT_LEFT_HALFWORD_IMMEDIATE:
                begin
                  if in_I7[3:6] < 16 begin
                    for(int i=0; i < 8; i++) begin
                        out_RT[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] << in_I7[3:6];
                    end
                  end
                  else begin
                       out_RT[i*HALFWORD +: HALFWORD] = 0;
                  end
                end

        endcase


    end

endmodule

module simple_fixed_tb();

    logic clk;
    logic rst;

    logic [15:0]  in_I16;
    Opcodes       opcode;
    logic [127:0] out_RT;

    always #5 clk = ~clk;

    simple_fixed u_sf (
        .clk (clk),
        .rst (rst),
        .opcode(opcode),
        .in_I16 (in_I16),
        .out_RT (out_RT)
    );

    initial begin
        clk = 0;
        rst = 0;

        $monitor("Time: %3d, out_RT: %h", $time, out_RT);

        opcode = SHIFT_LEFT_HALFWORD_IMMEDIATE;
        in_I7 = 16'h0004;
        in_RA = 16'h2132;
        @(posedge clk) in_I7 = 16'h0044;;

        repeat(10) @(posedge clk);

        $finish();
    end
endmodule

//end of file.
