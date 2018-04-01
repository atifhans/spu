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

module decode 
(
    input  logic             clk,
    input  logic             rst,
    input  logic [0:31]      eins1,
    input  logic [0:31]      eins2,
    output Opcodes           opcode_ep,
    output Opcodes           opcode_op,
    output logic [0:6]       ra_addr_ep,
    output logic [0:6]       rb_addr_ep,
    output logic [0:6]       rc_addr_ep,
    output logic [0:6]       rt_addr_ep,
    output logic [0:6]       ra_addr_op,
    output logic [0:6]       rb_addr_op,
    output logic [0:6]       rc_addr_op,
    output logic [0:6]       rt_addr_op,
    output logic [0:6]       in_I7e,
    output logic [0:7]       in_I8e,
    output logic [0:9]       in_I10e,
    output logic [0:15]      in_I16e,
    output logic [0:17]      in_I18e,
    output logic [0:6]       in_I7o,
    output logic [0:7]       in_I8o,
    output logic [0:9]       in_I10o,
    output logic [0:15]      in_I16o,
    output logic [0:17]      in_I18o
);

    always_comb begin
        opcode_ep  = LNOP;
        opcode_op  = NOP;
        ra_addr_ep = 'dx;
        rb_addr_ep = 'dx;
        rc_addr_ep = 'dx;
        rt_addr_ep = 'dx;
        ra_addr_op = 'dx;
        rb_addr_op = 'dx;
        rc_addr_op = 'dx;
        rt_addr_op = 'dx;
        in_I7e     = 'dx;  
        in_I8e     = 'dx; 
        in_I10e    = 'dx;
        in_I16e    = 'dx;
        in_I18e    = 'dx;
        in_I7o     = 'dx;
        in_I8o     = 'dx;
        in_I10o    = 'dx;
        in_I16o    = 'dx;
        in_I18o    = 'dx;

        if(eins1 == 32'hffffffff || eins2 == 32'hffffffff) begin
            opcode_op = CMISS;
        end
    end

endmodule
//end of file.
