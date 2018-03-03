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
    output logic                     rt_wr_en_ep,
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
    output logic [6:0]               out_RT_addr,
    output logic [127:0]             out_RT
);

    logic            rt_wr_en;
    logic [6:0]      rf_addr_s1_ep;
    logic [127:0]    rf_data_s1_ep;
    logic            rf_s1_we;
    logic            rf_s2_we;
    logic            rf_s3_we;
    logic            rf_s4_we;
    logic            rf_s5_we;
    logic            rf_s6_we;
    logic            rf_s7_we;
    logic [127:0]    RT_reg;

    logic [WORD-1:0]     rep_lb32_I16;
    logic [HALFWORD-1:0] rep_lb16_I10;
    logic [WORD-1:0]     rep_lb32_I10;

    assign rep_lb32_I16 = {{16{in_I16[15]}}, in_I16};
    assign rep_lb16_I10 = {{6{in_I10[9]}}, in_I10};
    assign rep_lb32_I10 = {{22{in_I10[9]}}, in_I10};

// Rotate Variables
    logic [31:0]   result;
    logic [31:0]   operand;
    logic [4:0]    rotate;
    logic [4:0]    rotate_temp;

    always_ff @(posedge clk) begin
        if(rst) begin
            rf_addr_s1_ep <= 'd0;
            rf_addr_s2_ep <= 'd0;
            rf_addr_s3_ep <= 'd0;
            rf_addr_s4_ep <= 'd0;
            rf_addr_s5_ep <= 'd0;
            rf_addr_s6_ep <= 'd0;
            rf_addr_s7_ep <= 'd0;
            out_RT_addr   <= 'd0;
            rf_data_s1_ep <= 'd0;
            rf_data_s2_ep <= 'd0;
            rf_data_s3_ep <= 'd0;
            rf_data_s4_ep <= 'd0;
            rf_data_s5_ep <= 'd0;
            rf_data_s6_ep <= 'd0;
            rf_data_s7_ep <= 'd0;
            out_RT        <= 'd0;
            rf_s1_we      <= 'd0;
            rf_s2_we      <= 'd0;
            rf_s3_we      <= 'd0;
            rf_s4_we      <= 'd0;
            rf_s5_we      <= 'd0;
            rf_s6_we      <= 'd0;
            rf_s7_we      <= 'd0;
            rt_wr_en_ep   <= 'd0;
        end
        else begin
            rf_addr_s1_ep <= in_RT_addr;
            rf_addr_s2_ep <= rf_addr_s1_ep;
            rf_addr_s3_ep <= rf_addr_s2_ep;
            rf_addr_s4_ep <= rf_addr_s3_ep;
            rf_addr_s5_ep <= rf_addr_s4_ep;
            rf_addr_s6_ep <= rf_addr_s5_ep;
            rf_addr_s7_ep <= rf_addr_s6_ep;
            out_RT_addr   <= rf_addr_s7_ep;
            rf_data_s1_ep <= RT_reg;
            rf_data_s2_ep <= rf_data_s1_ep;
            rf_data_s3_ep <= rf_data_s2_ep;
            rf_data_s4_ep <= rf_data_s3_ep;
            rf_data_s5_ep <= rf_data_s4_ep;
            rf_data_s6_ep <= rf_data_s5_ep;
            rf_data_s7_ep <= rf_data_s6_ep;
            out_RT        <= rf_data_s7_ep;
            rf_s1_we      <= rt_wr_en;
            rf_s2_we      <= rf_s1_we;
            rf_s3_we      <= rf_s2_we;
            rf_s4_we      <= rf_s3_we;
            rf_s5_we      <= rf_s4_we;
            rf_s6_we      <= rf_s5_we;
            rf_s7_we      <= rf_s6_we;
            rt_wr_en_ep   <= rf_s7_we;
        end
    end

    always_comb
    begin
        rt_wr_en = 'd0;
        RT_reg = 'd0;

        case(opcode)

            IMMEDIATE_LOAD_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_I16;
                    end
                    rt_wr_en = 1;
                end

            IMMEDIATE_LOAD_WORD:
                 begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = rep_lb32_I16;
                    end
                    rt_wr_en = 1;
                 end

            IMMEDIATE_LOAD_ADDRESS:
                 begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_I18 & 18'h3ffff;
                    end
                    rt_wr_en = 1;
                 end

            ADD_HALF_WORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] + in_RB[i*HALFWORD +: HALFWORD];
                    end
                    rt_wr_en = 1;
                end

            ADD_HALF_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] + rep_lb16_I10;
                    end
                    rt_wr_en = 1;
                end

            ADD_WORD:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] + in_RB[i*WORD +: WORD];
                    end
                    rt_wr_en = 1;
                end

            ADD_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] + rep_lb32_I10;
                    end
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_HALFWORD:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] - in_RB[i*HALFWORD +: HALFWORD];
                    end
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_HALFWORD_IMMEDIATE:
                begin
                    for(int i=0; i < 8; i++) begin
                        RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] - rep_lb16_I10;
                    end
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_WORD:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] - in_RB[i*WORD +: WORD];
                    end
                    rt_wr_en = 1;
                end

            SUBTRACT_FROM_WORD_IMMEDIATE:
                begin
                    for(int i=0; i < 4; i++) begin
                        RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] - rep_lb32_I10;
                    end
                    rt_wr_en = 1;
                end

            SHIFT_LEFT_HALFWORD_IMMEDIATE:
                begin
                    if(in_I7[4:0] < 16) begin
                        for(int i=0; i < 8; i++) begin
                            RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] << in_I7[4:0];
                        end
                    end
                    else begin
                        RT_reg = 'd0;
                    end
                    rt_wr_en = 1;
                end

            SHIFT_LEFT_HALFWORD_IMMEDIATE:
                    begin
                      if(in_I7[4:0] < 16) begin
                        for(int i=0; i < 8; i++) begin
                          RT_reg[i*HALFWORD +: HALFWORD] = in_RA[i*HALFWORD +: HALFWORD] << in_I7[4:0];
                        end
                      end
                      else begin
                        RT_reg = 'd0;
                      end
                      rt_wr_en = 1;
                    end

            SHIFT_LEFT_WORD:
                    begin
                       for (int i=0; i < 4; i++) begin
                                 if (in_RB[i*WORD +: 4] < 32) begin
                                     RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] << in_RB[i*WORD +: 4];
                                 end
                                 else begin
                                     RT_reg[i*WORD +: WORD] = 'd0;
                                 end
                       end
                      rt_wr_en = 1;
                    end

             SHIFT_LEFT_WORD_IMMEDIATE:
                    begin
                      if(in_I7[4:0] < 32) begin
                        for(int i=0; i < 4; i++) begin
                          RT_reg[i*WORD +: WORD] = in_RA[i*WORD +: WORD] << in_I7[4:0];
                        end
                      end
                      else begin
                        RT_reg = 'd0;
                      end
                      rt_wr_en = 1;
                    end

             ROTATE_WORD:
                   begin
                     for (int i=0; i < 4; i++) begin
                            operand = in_RA[i*WORD +: WORD];
                            rotate = in_RB[i*WORD +: 4];
                            while(rotate > 32)begin
                                  rotate_temp = rotate - 32;
                                  rotate = rotate_temp;
                            end
                            for ( int j=0; j < rotate ; j++) begin
                                result =  {operand[30:0],operand[31]};
                                operand = result;
                            end
                            RT_reg[i*WORD +: WORD] = operand;
                     end
                     rt_wr_en = 1;
                   end

             ROTATE_WORD_IMMEDIATE:
                    begin
                     for (int i=0; i < 4; i++) begin
                            operand = in_RA[i*WORD +: WORD];
                            rotate = in_I7[4:0];
                            while(rotate > 32)begin
                                  rotate_temp = rotate - 32;
                                  rotate = rotate_temp;
                            end
                            for ( int j=0; j < rotate ; j++) begin
                                result =  {operand[30:0],operand[31]};
                                operand = result;
                            end
                            RT_reg[i*WORD +: WORD] = operand;
                     end
                     rt_wr_en = 1;
                   end

        endcase
    end

endmodule
//end of file.
