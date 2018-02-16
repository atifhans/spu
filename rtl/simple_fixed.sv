// ------------------------------------------//
// Register File for SPU-Lite Processor
// ------------------------------------------//
// Authors:
// NAME:  Atif Iqbal                           
// NETID: aahangar                             
// SBUID: 111416569                            
//
// NAME: Karthik Raj
// NETID: ?
// SBUID: ?
// ------------------------------------------//

import defines_pkg::*;

module simple_fixed #(parameter OPCODE_LEN  = 11,
                      parameter REG_ADDR_WD = 7,
                      parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst,
    input  Opcodes                   opcode,
    input  logic [REG_DATA_WD-1:0]   in_RA,
    input  logic [REG_DATA_WD-1:0]   in_RB,
    input  logic [9:0]               in_I10,
    input  logic [15:0]              in_I16,
    input  logic [17:0]              in_I18,
    output logic [REG_DATA_WD-1:0]   out_RT
);

    always_comb begin

        case(opcode)

            IMMEDIATE_LOAD_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        out_RT[i*16 +: 16] = in_I16;
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

        opcode = IMMEDIATE_LOAD_HALFWORD;
        in_I16 = 16'd23;
    end
endmodule

//end of file.
