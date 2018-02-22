// ------------------------------------------//
// Even Pipe
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

module even_pipe #(parameter OPCODE_LEN  = 11,
                   parameter REG_ADDR_WD = 7,
                   parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst,
    input  Opcodes                   opcode,
    input  logic [127:0]             in_RA,
    input  logic [127:0]             in_RB,
    input  logic [127:0]             in_RC,
    input  logic [6:0]               in_I7,
    input  logic [7:0]               in_I8,
    input  logic [9:0]               in_I10,
    input  logic [15:0]              in_I16,
    input  logic [17:0]              in_I18,
    input  logic [6:0]               in_RT_addr,
    output logic [6:0]               rf_addr_s2_ep,
    output logic [6:0]               rf_addr_s3_ep,
    output logic [6:0]               rf_addr_s4_ep,
    output logic [6:0]               rf_addr_s5_ep,
    output logic [6:0]               rf_addr_s6_ep,
    output logic [6:0]               rf_addr_s7_ep,
    output logic [127:0]             rf_data_s2_ep,
    output logic [127:0]             rf_data_s3_ep,
    output logic [127:0]             rf_data_s4_ep,
    output logic [127:0]             rf_data_s5_ep,
    output logic [127:0]             rf_data_s6_ep,
    output logic [127:0]             rf_data_s7_ep,
    output logic [127:0]             out_RT
);

    logic [WORD-1:0] rep_lb32_I16;

    assign rep_lb32_I16 = {{16{in_I16[15]}}, in_I16};

    always_comb
    begin
        case(opcode)

            IMMEDIATE_LOAD_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        out_RT[i*HALFWORD +: HALFWORD] = in_I16;
                    end
                end

            IMMEDIATE_LOAD_WORD:
                 begin
                    for(int i=0; i < 4; i++) begin
                        out_RT[i*WORD +: WORD] = rep_lb32_I16;
                    end
                 end

            IMMEDIATE_LOAD_ADDRESS:
                 begin
                    for(int i=0; i < 4; i++) begin
                        out_RT[i*WORD +: WORD] = in_I18 & 18'h3ffff;
                    end
                 end

            SHIFT_LEFT_HALFWORD_IMMEDIATE:
                begin
                  if(in_I7[4:0] < 16) begin
                    for(int i=0; i < 8; i++) begin
                      out_RT[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] << in_I7[4:0];
                    end
                  end
                  else begin
                    out_RT = 'd0;
                  end
                end

        endcase
    end

endmodule

/*
module even_pipe_tb();
    
    logic clk;
    logic rst;

    logic [15:0]  in_I16;
    Opcodes       opcode;
    logic [127:0] out_RT;

    always #5 clk = ~clk;

    even_pipe u_even_pipe (
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

        opcode = IMMEDIATE_LOAD_HALFWORD;
        in_I16 = 16'h1234;
        @(posedge clk) in_I16 = 16'h4311;

        repeat(10) @(posedge clk);

        opcode = SHIFT_LEFT_HALFWORD_IMMEDIATE;
        in_I7 = 16'h0004;
        in_RA = 16'h2132;
        @(posedge clk) in_I7 = 16'h0044;;

        repeat(10) @(posedge clk);

        $finish();
    end
endmodule
*/
//end of file.
