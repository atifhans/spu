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

module spu_pipes_top #(parameter OPCODE_LEN  = 11,
                       parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst,
    input  Opcodes                   opcode_ep,
    input  Opcodes                   opcode_op,
    input  logic [6:0]               ra_addr_ep,
    input  logic [6:0]               rb_addr_ep,
    input  logic [6:0]               rc_addr_ep,
    input  logic [6:0]               rt_addr_ep,
    input  logic [6:0]               ra_addr_op,
    input  logic [6:0]               rb_addr_op,
    input  logic [6:0]               rc_addr_op,
    input  logic [6:0]               rt_addr_op,
    input  logic [6:0]               in_I7e,
    input  logic [7:0]               in_I8e,
    input  logic [9:0]               in_I10e,
    input  logic [15:0]              in_I16e,
    input  logic [17:0]              in_I18e,
    input  logic [6:0]               in_I7o,
    input  logic [7:0]               in_I8o,
    input  logic [9:0]               in_I10o,
    input  logic [15:0]              in_I16o,
    input  logic [17:0]              in_I18o
);

    logic                  rt_wr_en_ep;
    logic                  rt_wr_en_op;
    logic [127:0]          rt_wr_ep;
    logic [127:0]          rt_wr_op;
    logic [127:0]          ra_rd_ep;
    logic [127:0]          rb_rd_ep;
    logic [127:0]          rc_rd_ep;
    logic [127:0]          ra_rd_op;
    logic [127:0]          rb_rd_op;
    logic [127:0]          rc_rd_op;
    logic [6:0]            rf_addr_s2_ep;
    logic [6:0]            rf_addr_s3_ep;
    logic [6:0]            rf_addr_s4_ep;
    logic [6:0]            rf_addr_s5_ep;
    logic [6:0]            rf_addr_s6_ep;
    logic [6:0]            rf_addr_s7_ep;
    logic [6:0]            rf_addr_s2_op;
    logic [6:0]            rf_addr_s3_op;
    logic [6:0]            rf_addr_s4_op;
    logic [6:0]            rf_addr_s5_op;
    logic [6:0]            rf_addr_s6_op;
    logic [6:0]            rf_addr_s7_op;
    logic [127:0]          rf_data_s2_ep;
    logic [127:0]          rf_data_s3_ep;
    logic [127:0]          rf_data_s4_ep;
    logic [127:0]          rf_data_s5_ep;
    logic [127:0]          rf_data_s6_ep;
    logic [127:0]          rf_data_s7_ep;
    logic [127:0]          rf_data_s2_op;
    logic [127:0]          rf_data_s3_op;
    logic [127:0]          rf_data_s4_op;
    logic [127:0]          rf_data_s5_op;
    logic [127:0]          rf_data_s6_op;
    logic [127:0]          rf_data_s7_op;
    logic [127:0]          ra_fw_ep;
    logic [127:0]          rb_fw_ep;
    logic [127:0]          rc_fw_ep;
    logic [127:0]          ra_fw_op;
    logic [127:0]          rb_fw_op;
    logic [127:0]          rc_fw_op;

    reg_file u_reg_file (
        .clk          ( clk         ),
        .rst          ( rst         ),
        .ra_addr_ep   ( ra_addr_ep  ),
        .rb_addr_ep   ( rb_addr_ep  ),
        .rc_addr_ep   ( rc_addr_ep  ),
        .rt_addr_ep   ( rt_addr_ep  ),
        .ra_addr_op   ( ra_addr_op  ),
        .rb_addr_op   ( rb_addr_op  ),
        .rc_addr_op   ( rc_addr_op  ),
        .rt_addr_op   ( rt_addr_op  ),
        .rt_wr_en_ep  ( rt_wr_en_ep ),
        .rt_wr_en_op  ( rt_wr_en_op ),
        .rt_wr_ep     ( rt_wr_ep    ),
        .rt_wr_op     ( rt_wr_op    ),
        .ra_rd_ep     ( ra_rd_ep    ),
        .rb_rd_ep     ( rb_rd_ep    ),
        .rc_rd_ep     ( rc_rd_ep    ),
        .ra_rd_op     ( ra_rd_op    ),
        .rb_rd_op     ( rb_rd_op    ),
        .rc_rd_op     ( rc_rd_op    )
   );

    fw_macro u_fw_macro (
        .clk          ( clk         ),
        .rst          ( rst         ),
        .ra_addr_ep   ( ra_addr_ep  ),
        .rb_addr_ep   ( rb_addr_ep  ),
        .rc_addr_ep   ( rc_addr_ep  ),
        .rt_addr_ep   ( rt_addr_ep  ),
        .ra_addr_op   ( ra_addr_op  ),
        .rb_addr_op   ( rb_addr_op  ),
        .rc_addr_op   ( rc_addr_op  ),
        .rt_addr_op   ( rt_addr_op  ),
        .ra_data_ep   ( ra_rd_ep    ),
        .rb_data_ep   ( rb_rd_ep    ),
        .rc_data_ep   ( rc_rd_ep    ),
        .ra_data_op   ( ra_rd_op    ),
        .rb_data_op   ( rb_rd_op    ),
        .rc_data_op   ( rc_rd_op    ),
        .rf_addr_s2_ep( rf_addr_s2_ep ),
        .rf_addr_s3_ep( rf_addr_s3_ep ),
        .rf_addr_s4_ep( rf_addr_s4_ep ),
        .rf_addr_s5_ep( rf_addr_s5_ep ),
        .rf_addr_s6_ep( rf_addr_s6_ep ),
        .rf_addr_s7_ep( rf_addr_s7_ep ),
        .rf_addr_s2_op( rf_addr_s2_op ),
        .rf_addr_s3_op( rf_addr_s3_op ),
        .rf_addr_s4_op( rf_addr_s4_op ),
        .rf_addr_s5_op( rf_addr_s5_op ),
        .rf_addr_s6_op( rf_addr_s6_op ),
        .rf_addr_s7_op( rf_addr_s7_op ),
        .rf_data_s2_ep( rf_data_s2_ep ),
        .rf_data_s3_ep( rf_data_s3_ep ),
        .rf_data_s4_ep( rf_data_s4_ep ),
        .rf_data_s5_ep( rf_data_s5_ep ),
        .rf_data_s6_ep( rf_data_s6_ep ),
        .rf_data_s7_ep( rf_data_s7_ep ),
        .rf_data_s2_op( rf_data_s2_op ),
        .rf_data_s3_op( rf_data_s3_op ),
        .rf_data_s4_op( rf_data_s4_op ),
        .rf_data_s5_op( rf_data_s5_op ),
        .rf_data_s6_op( rf_data_s6_op ),
        .rf_data_s7_op( rf_data_s7_op ),
        .ra_fw_ep     ( ra_fw_ep      ),
        .rb_fw_ep     ( rb_fw_ep      ),
        .rc_fw_ep     ( rc_fw_ep      ),
        .ra_fw_op     ( ra_fw_op      ),
        .rb_fw_op     ( rb_fw_op      ),
        .rc_fw_op     ( rc_fw_op      )
    );

    even_pipe u_even_pipe (
        .clk           (clk),
        .rst           (rst),
        .opcode        (opcode_ep),
        .rt_wr_en_ep   (rt_wr_en_ep),
        .in_RA         (ra_fw_ep),
        .in_RB         (rb_fw_ep),
        .in_RC         (rc_fw_ep),
        .in_I7         (in_I7e),
        .in_I8         (in_I8e),
        .in_I10        (in_I10e),
        .in_I16        (in_I16e),
        .in_I18        (in_I18e),
        .rf_addr_s2_ep ( rf_addr_s2_ep ),
        .rf_addr_s3_ep ( rf_addr_s3_ep ),
        .rf_addr_s4_ep ( rf_addr_s4_ep ),
        .rf_addr_s5_ep ( rf_addr_s5_ep ),
        .rf_addr_s6_ep ( rf_addr_s6_ep ),
        .rf_addr_s7_ep ( rf_addr_s7_ep ),
        .rf_data_s2_ep ( rf_data_s2_ep ),
        .rf_data_s3_ep ( rf_data_s3_ep ),
        .rf_data_s4_ep ( rf_data_s4_ep ),
        .rf_data_s5_ep ( rf_data_s5_ep ),
        .rf_data_s6_ep ( rf_data_s6_ep ),
        .rf_data_s7_ep ( rf_data_s7_ep ),
        .out_RT        (rt_wr_ep)
    );

    odd_pipe u_odd_pipe (
        .clk           (clk),
        .rst           (rst),
        .opcode        (opcode_op),
        .rt_wr_en_op   (rt_wr_en_op),
        .in_RA         (ra_fw_op),
        .in_RB         (rb_fw_op),
        .in_RC         (rc_fw_op),
        .in_I7         (in_I7o),
        .in_I8         (in_I8o),
        .in_I10        (in_I10o),
        .in_I16        (in_I16o),
        .in_I18        (in_I18o),
        .rf_addr_s2_op ( rf_addr_s2_op ),
        .rf_addr_s3_op ( rf_addr_s3_op ),
        .rf_addr_s4_op ( rf_addr_s4_op ),
        .rf_addr_s5_op ( rf_addr_s5_op ),
        .rf_addr_s6_op ( rf_addr_s6_op ),
        .rf_addr_s7_op ( rf_addr_s7_op ),
        .rf_data_s2_op ( rf_data_s2_op ),
        .rf_data_s3_op ( rf_data_s3_op ),
        .rf_data_s4_op ( rf_data_s4_op ),
        .rf_data_s5_op ( rf_data_s5_op ),
        .rf_data_s6_op ( rf_data_s6_op ),
        .rf_data_s7_op ( rf_data_s7_op ),
        .in_RT_addr    ( rt_addr_op ),
        .out_RT        (rt_wr_op)
    );

endmodule
//end of file.

