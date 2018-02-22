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

module odd_pipe #(parameter OPCODE_LEN  = 11,
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
    output logic [6:0]               rf_addr_s2_op,
    output logic [6:0]               rf_addr_s3_op,
    output logic [6:0]               rf_addr_s4_op,
    output logic [6:0]               rf_addr_s5_op,
    output logic [6:0]               rf_addr_s6_op,
    output logic [6:0]               rf_addr_s7_op,
    output logic [127:0]             rf_data_s2_op,
    output logic [127:0]             rf_data_s3_op,
    output logic [127:0]             rf_data_s4_op,
    output logic [127:0]             rf_data_s5_op,
    output logic [127:0]             rf_data_s6_op,
    output logic [127:0]             rf_data_s7_op,
    input  logic [6:0]               in_RT_addr,
    output logic [127:0]             out_RT
);

    always_comb begin
        case(opcode)


        endcase
    end

endmodule
//end of file.
