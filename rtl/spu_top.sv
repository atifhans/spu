// ------------------------------------------//
//  
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

module spu_top #(parameter OPCODE_LEN  = 11,
                 parameter REG_DATA_WD = 128)
(
    input  logic                     clk,
    input  logic                     rst
);

    Opcodes           opcode_ep;
    Opcodes           opcode_op;
    logic [0:6]       ra_addr_ep;
    logic [0:6]       rb_addr_ep;
    logic [0:6]       rc_addr_ep;
    logic [0:6]       rt_addr_ep;
    logic [0:6]       ra_addr_op;
    logic [0:6]       rb_addr_op;
    logic [0:6]       rc_addr_op;
    logic [0:6]       rt_addr_op;
    logic [0:6]       in_I7e;
    logic [0:7]       in_I8e;
    logic [0:9]       in_I10e;
    logic [0:15]      in_I16e;
    logic [0:17]      in_I18e;
    logic [0:6]       in_I7o;
    logic [0:7]       in_I8o;
    logic [0:9]       in_I10o;
    logic [0:15]      in_I16o;
    logic [0:17]      in_I18o;
    logic [0:31]      eins1;
    logic [0:31]      eins2;
    logic [0:127]     ls_data_rd;
    logic [0:127]     ls_data_wr;
    logic [0:31]      ls_addr;
    logic             ls_wr_en;
    logic [0:31]      pc_dtof;
    logic [0:31]      pc_ftod;
    logic [0:1023]    cache_line;
    logic             ins_wr_en;
    logic             cache_wr;
    logic             dec_stall;

    local_store u_local_store (
        .clk          ( clk         ),
        .rst          ( rst         ),
        .ls_addr      ( ls_addr     ),
        .ls_data_wr   ( ls_data_wr  ),
        .ls_data_rd   ( ls_data_rd  ),
        .cache_wr     ( cache_wr    ),
        .cache_out    ( cache_line  ),
        .ls_wr_en     ( ls_wr_en    )
    );

    fetch u_fetch (
        .clk(clk),
        .rst(rst),
        .cache_line(cache_line),
        .cache_wr(cache_wr),
        .dec_stall(dec_stall),
        .branch_taken(),
        .pc_in(pc_dtof),
        .pc_out(pc_ftod),
        .eins1(eins1),
        .eins2(eins2)
    );

    decode u_decode (
        .clk(clk),
        .rst(rst),
        .dec_stall(dec_stall),
        .eins1(eins1),
        .eins2(eins2),
        .opcode_ep(opcode_ep),
        .opcode_op(opcode_op),
        .ra_addr_ep(ra_addr_ep),
        .rb_addr_ep(rb_addr_ep),
        .rc_addr_ep(rc_addr_ep),
        .rt_addr_ep(rt_addr_ep),
        .ra_addr_op(ra_addr_op),
        .rb_addr_op(rb_addr_op),
        .rc_addr_op(rc_addr_op),
        .rt_addr_op(rt_addr_op),
        .in_I7e(in_I7e),
        .in_I8e(in_I8e),
        .in_I10e(in_I10e),
        .in_I16e(in_I16e),
        .in_I18e(in_I18e),
        .in_I7o(in_I7o),
        .in_I8o(in_I8o),
        .in_I10o(in_I10o),
        .in_I16o(in_I16o),
        .in_I18o(in_I18o)
    );

    spu_pipes_top u_spu_pipes_top (
        .clk(clk),
        .rst(rst),
        .opcode_ep(opcode_ep),
        .opcode_op(opcode_op),
        .ra_addr_ep(ra_addr_ep),
        .rb_addr_ep(rb_addr_ep),
        .rc_addr_ep(rc_addr_ep),
        .rt_addr_ep(rt_addr_ep),
        .ra_addr_op(ra_addr_op),
        .rb_addr_op(rb_addr_op),
        .rc_addr_op(rc_addr_op),
        .rt_addr_op(rt_addr_op),
        .in_I7e(in_I7e),
        .in_I8e(in_I8e),
        .in_I10e(in_I10e),
        .in_I16e(in_I16e),
        .in_I18e(in_I18e),
        .in_I7o(in_I7o),
        .in_I8o(in_I8o),
        .in_I10o(in_I10o),
        .in_I16o(in_I16o),
        .in_I18o(in_I18o),
        .ls_data_rd(ls_data_rd),
        .ls_data_wr(ls_data_wr),
        .ls_addr(ls_addr),
        .ls_wr_en(ls_wr_en),
        .cache_wr(cache_wr),
        .PC_in(pc_ftod),
        .PC_out(pc_dtof)
    );

endmodule
//end of file.
