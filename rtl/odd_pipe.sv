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
    output logic                     rt_wr_en_op,
    input  logic [127:0]             in_RA,
    input  logic [127:0]             in_RB,
    input  logic [127:0]             in_RC,
    input  logic [6:0]               in_I7,
    input  logic [7:0]               in_I8,
    input  logic [9:0]               in_I10,
    input  logic [15:0]              in_I16,
    input  logic [17:0]              in_I18,
    input  logic [6:0]               in_RT_addr,
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
    output logic [0:2]               rf_idx_s2_op,
    output logic [0:2]               rf_idx_s3_op,
    output logic [0:2]               rf_idx_s4_op,
    output logic [0:2]               rf_idx_s5_op,
    output logic [0:2]               rf_idx_s6_op,
    output logic [0:2]               rf_idx_s7_op,
    output logic [6:0]               out_RT_addr,
    output logic [127:0]             out_RT
);


    logic            rt_wr_en;
    logic [0:2]      rf_idx_s1_op;
    logic [6:0]      rf_addr_s1_op;
    logic [127:0]    rf_data_s1_op;
    logic            rf_s1_we;
    logic            rf_s2_we;
    logic            rf_s3_we;
    logic            rf_s4_we;
    logic            rf_s5_we;
    logic            rf_s6_we;
    logic            rf_s7_we;
    logic [127:0]    RT_reg;

    logic [2:0]      unit_idx;
// Shift Rotate variables
    logic [127:0]    result;
    logic [127:0]    result_temp;

    always_ff @(posedge clk) begin
        if(rst) begin
            rf_addr_s1_op <= 'd0;
            rf_addr_s2_op <= 'd0;
            rf_addr_s3_op <= 'd0;
            rf_addr_s4_op <= 'd0;
            rf_addr_s5_op <= 'd0;
            rf_addr_s6_op <= 'd0;
            rf_addr_s7_op <= 'd0;
            out_RT_addr   <= 'd0;
            rf_data_s1_op <= 'd0;
            rf_data_s2_op <= 'd0;
            rf_data_s3_op <= 'd0;
            rf_data_s4_op <= 'd0;
            rf_data_s5_op <= 'd0;
            rf_data_s6_op <= 'd0;
            rf_data_s7_op <= 'd0;
            rf_idx_s1_op  <= 'd0;
            rf_idx_s2_op  <= 'd0;
            rf_idx_s3_op  <= 'd0;
            rf_idx_s4_op  <= 'd0;
            rf_idx_s5_op  <= 'd0;
            rf_idx_s6_op  <= 'd0;
            rf_idx_s7_op  <= 'd0;
            out_RT        <= 'd0;
            rf_s1_we      <= 'd0;
            rf_s2_we      <= 'd0;
            rf_s3_we      <= 'd0;
            rf_s4_we      <= 'd0;
            rf_s5_we      <= 'd0;
            rf_s6_we      <= 'd0;
            rf_s7_we      <= 'd0;
            rt_wr_en_op   <= 'd0;
        end
        else begin
            rf_addr_s1_op <= in_RT_addr;
            rf_addr_s2_op <= rf_addr_s1_op;
            rf_addr_s3_op <= rf_addr_s2_op;
            rf_addr_s4_op <= rf_addr_s3_op;
            rf_addr_s5_op <= rf_addr_s4_op;
            rf_addr_s6_op <= rf_addr_s5_op;
            rf_addr_s7_op <= rf_addr_s6_op;
            out_RT_addr   <= rf_addr_s7_op;
            rf_idx_s1_op  <= unit_idx;
            rf_idx_s2_op  <= rf_idx_s1_op;
            rf_idx_s3_op  <= rf_idx_s2_op;
            rf_idx_s4_op  <= rf_idx_s3_op;
            rf_idx_s5_op  <= rf_idx_s4_op;
            rf_idx_s6_op  <= rf_idx_s5_op;
            rf_idx_s7_op  <= rf_idx_s6_op;
            rf_data_s1_op <= RT_reg;
            rf_data_s2_op <= rf_data_s1_op;
            rf_data_s3_op <= rf_data_s2_op;
            rf_data_s4_op <= rf_data_s3_op;
            rf_data_s5_op <= rf_data_s4_op;
            rf_data_s6_op <= rf_data_s5_op;
            rf_data_s7_op <= rf_data_s6_op;
            out_RT        <= rf_data_s7_op;
            rf_s1_we      <= rt_wr_en;
            rf_s2_we      <= rf_s1_we;
            rf_s3_we      <= rf_s2_we;
            rf_s4_we      <= rf_s3_we;
            rf_s5_we      <= rf_s4_we;
            rf_s6_we      <= rf_s5_we;
            rf_s7_we      <= rf_s6_we;
            rt_wr_en_op   <= rf_s7_we;
        end
    end

   always_comb
    begin
        rt_wr_en = 'd0;
        RT_reg = 'd0;
        unit_idx = 'd0;

        case(opcode)

           SHIFT_LEFT_QUADWORD_BY_BITS :
              begin
               RT_reg = in_RA << in_RB[2:0];
              end

           SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE :
              begin
               RT_reg = in_RA << in_I7[2:0];
              end

           SHIFT_LEFT_QUADWORD_BY_BYTES :
              begin
               if (in_RB[4:0] < 16) begin
                  RT_reg = in_RA << in_RB[4:0] * 8;
               end
               else
                  RT_reg = 'd0;
              end

           SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE:
              begin
                if (in_RB[4:0] < 16) begin
                  RT_reg = in_RA << in_I7[4:0] * 8;
                end
                else
                  RT_reg = 'd0;
              end

           ROTATE_QUADWORD_BY_BITS:
              begin
               if (in_RB[2:0] < 8) begin
                  result_temp = in_RA;
                  for (int i = 0; i < in_RB[2:0]; i++)begin
                       result = {result_temp[126:0],result_temp[127]};
                       result_temp = result;
                  end
                  RT_reg = result_temp;
               end
               else
                  RT_reg = 'd0;
              end

           ROTATE_QUADWORD_BY_BITS_IMMEDIATE:
               begin
                 if (in_I7[2:0] < 8) begin
                    result_temp = in_RA;
                    for (int i = 0; i < in_I7[2:0]; i++) begin
                       result = {result_temp[126:0],result_temp[127]};
                       result_temp = result;
                    end
                    RT_reg = result_temp;
                 end
                 else
                    RT_reg = 'd0;
              end

           ROTATE_QUADWORD_BY_BYTES:
               begin
                if (in_RB[4:0] < 16) begin
                  result_temp = in_RA;
                  for (int i = 0; i < in_RB[4:0]; i++)begin
                      result = {result_temp[119:0],result_temp[127:120]};
                      result_temp = result;
                  end
                  RT_reg = result_temp;
                end
                else
                  RT_reg = 'd0;
              end

           ROTATE_QUADWORD_BY_BYTES_IMMEDIATE:
                begin
                if (in_I7[4:0] < 16) begin
                  result_temp = in_RA;
                  for (int i = 0; i < in_I7[4:0]; i++)begin
                      result = {result_temp[119:0],result_temp[127:120]};
                      result_temp = result;
                  end
                  RT_reg = result_temp;
                end
                else
                  RT_reg = 'd0;
              end

         endcase
    end
endmodule
