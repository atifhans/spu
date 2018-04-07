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
    output logic             dec_stall,
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

    localparam EVEN = 0;
    localparam ODD  = 1;

    Opcodes      opcode_i1;
    Opcodes      opcode_i2;
    logic [0:6]  ra_addr_i1;
    logic [0:6]  rb_addr_i1;
    logic [0:6]  rc_addr_i1;
    logic [0:6]  rt_addr_i1;
    logic [0:6]  ra_addr_i2;
    logic [0:6]  rb_addr_i2;
    logic [0:6]  rc_addr_i2;
    logic [0:6]  rt_addr_i2;
    logic [0:6]  in_I7_i1;
    logic [0:7]  in_I8_i1;
    logic [0:9]  in_I10_i1;
    logic [0:15] in_I16_i1;
    logic [0:17] in_I18_i1;
    logic [0:6]  in_I7_i2;
    logic [0:7]  in_I8_i2;
    logic [0:9]  in_I10_i2;
    logic [0:15] in_I16_i2;
    logic [0:17] in_I18_i2;

    logic        stall_done;
    logic [0:3]  eoc1_4b;
    logic [0:3]  eoc2_4b;
    logic [0:6]  eoc1_7b;
    logic [0:6]  eoc2_7b;
    logic [0:7]  eoc1_8b;
    logic [0:7]  eoc2_8b;
    logic [0:8]  eoc1_9b;
    logic [0:8]  eoc2_9b;
    logic [0:10] eoc1_10b;
    logic [0:10] eoc2_10b;

    logic        ins1_type;
    logic        ins2_type;

    assign eoc1_4b  = eins1[0:3];
    assign eoc2_4b  = eins2[0:3];
    assign eoc1_7b  = eins1[0:6];
    assign eoc2_7b  = eins2[0:6];
    assign eoc1_8b  = eins1[0:7];
    assign eoc2_8b  = eins2[0:7];
    assign eoc1_9b  = eins1[0:8];
    assign eoc2_9b  = eins2[0:8];
    assign eoc1_10b = eins1[0:9];
    assign eoc2_10b = eins2[0:9];

    always_ff @(posedge clk) begin
        if(rst) begin
            stall_done <= 'd0;
            opcode_ep <= LNOP;
            opcode_op <= NOP;
            ra_addr_ep <= 'dx;
            rb_addr_ep <= 'dx;
            rc_addr_ep <= 'dx;
            rt_addr_ep <= 'dx;
            ra_addr_op <= 'dx;
            rb_addr_op <= 'dx;
            rc_addr_op <= 'dx;
            rt_addr_op <= 'dx;
            in_I7e <= 'dx;
            in_I8e <= 'dx;
            in_I10e <= 'dx;
            in_I16e <= 'dx;
            in_I18e <= 'dx;
            in_I7o <= 'dx;
            in_I8o <= 'dx;
            in_I10o <= 'dx;
            in_I16o <= 'dx;
            in_I18o <= 'dx;
        end
        else begin
            if(dec_stall || stall_done) begin
                if(stall_done) begin
                    if(ins2_type == EVEN) begin
                        opcode_ep  <= opcode_i2;
                        ra_addr_ep <= ra_addr_i2;
                        rb_addr_ep <= rb_addr_i2;
                        rc_addr_ep <= rc_addr_i2;
                        rt_addr_ep <= rt_addr_i2;
                        in_I7e     <= in_I7_i2;
                        in_I8e     <= in_I8_i2;
                        in_I10e    <= in_I10_i2;
                        in_I16e    <= in_I16_i2;
                        in_I18e    <= in_I18_i2;
                    end
                    else begin
                        opcode_op  <= opcode_i2;
                        ra_addr_op <= ra_addr_i2;
                        rb_addr_op <= rb_addr_i2;
                        rc_addr_op <= rc_addr_i2;
                        rt_addr_op <= rt_addr_i2;
                        in_I7o     <= in_I7_i2;
                        in_I8o     <= in_I8_i2;
                        in_I10o    <= in_I10_i2;
                        in_I16o    <= in_I16_i2;
                        in_I18o    <= in_I18_i2;
                    end
                    stall_done <= 'd0;
                end
                else begin
                    if(ins1_type == EVEN) begin
                        opcode_ep  <= opcode_i1;
                        ra_addr_ep <= ra_addr_i1;
                        rb_addr_ep <= rb_addr_i1;
                        rc_addr_ep <= rc_addr_i1;
                        rt_addr_ep <= rt_addr_i1;
                        in_I7e     <= in_I7_i1;
                        in_I8e     <= in_I8_i1;
                        in_I10e    <= in_I10_i1;
                        in_I16e    <= in_I16_i1;
                        in_I18e    <= in_I18_i1;
                    end
                    else begin
                        opcode_op  <= opcode_i1;
                        ra_addr_op <= ra_addr_i1;
                        rb_addr_op <= rb_addr_i1;
                        rc_addr_op <= rc_addr_i1;
                        rt_addr_op <= rt_addr_i1;
                        in_I7o     <= in_I7_i1;
                        in_I8o     <= in_I8_i1;
                        in_I10o    <= in_I10_i1;
                        in_I16o    <= in_I16_i1;
                        in_I18o    <= in_I18_i1;
                    end
                    stall_done <= 'd1;
                end
            end
            else begin
                if(ins1_type == EVEN) begin
                    opcode_ep  <= opcode_i1;
                    ra_addr_ep <= ra_addr_i1;
                    rb_addr_ep <= rb_addr_i1;
                    rc_addr_ep <= rc_addr_i1;
                    rt_addr_ep <= rt_addr_i1;
                    in_I7e     <= in_I7_i1;
                    in_I8e     <= in_I8_i1;
                    in_I10e    <= in_I10_i1;
                    in_I16e    <= in_I16_i1;
                    in_I18e    <= in_I18_i1;
                    opcode_op  <= opcode_i2;
                    ra_addr_op <= ra_addr_i2;
                    rb_addr_op <= rb_addr_i2;
                    rc_addr_op <= rc_addr_i2;
                    rt_addr_op <= rt_addr_i2;
                    in_I7o     <= in_I7_i2;
                    in_I8o     <= in_I8_i2;
                    in_I10o    <= in_I10_i2;
                    in_I16o    <= in_I16_i2;
                    in_I18o    <= in_I18_i2;
                end
                else begin
                    opcode_ep  <= opcode_i2;
                    ra_addr_ep <= ra_addr_i2;
                    rb_addr_ep <= rb_addr_i2;
                    rc_addr_ep <= rc_addr_i2;
                    rt_addr_ep <= rt_addr_i2;
                    in_I7e     <= in_I7_i2;
                    in_I8e     <= in_I8_i2;
                    in_I10e    <= in_I10_i2;
                    in_I16e    <= in_I16_i2;
                    in_I18e    <= in_I18_i2;
                    opcode_op  <= opcode_i1;
                    ra_addr_op <= ra_addr_i1;
                    rb_addr_op <= rb_addr_i1;
                    rc_addr_op <= rc_addr_i1;
                    rt_addr_op <= rt_addr_i1;
                    in_I7o     <= in_I7_i1;
                    in_I8o     <= in_I8_i1;
                    in_I10o    <= in_I10_i1;
                    in_I16o    <= in_I16_i1;
                    in_I18o    <= in_I18_i1;
                end
            end
        end
    end

    always_comb begin
        opcode_i1  = LNOP;
        opcode_i2  = NOP;
        ins1_type  = EVEN;
        ins2_type  = ODD;
        ra_addr_i1 = 'dx;
        rb_addr_i1 = 'dx;
        rc_addr_i1 = 'dx;
        rt_addr_i1 = 'dx;
        ra_addr_i2 = 'dx;
        rb_addr_i2 = 'dx;
        rc_addr_i2 = 'dx;
        rt_addr_i2 = 'dx;
        in_I7_i1   = 'dx;  
        in_I8_i1   = 'dx; 
        in_I10_i1  = 'dx;
        in_I16_i1  = 'dx;
        in_I18_i1  = 'dx;
        in_I7_i2   = 'dx;
        in_I8_i2   = 'dx;
        in_I10_i2  = 'dx;
        in_I16_i2  = 'dx;
        in_I18_i2  = 'dx;

        if(eins1 == 32'hffffffff) begin
            opcode_i1 = CMISS;
            ins1_type = ODD;
        end
        else if(eoc1_4b == 4'b1100 || eoc1_4b == 4'b1110 || eoc1_4b == 4'b1111) begin
            ins1_type  = EVEN;
            rt_addr_i1 = eins1[4:10];
            ra_addr_i1 = eins1[11:17];
            rb_addr_i1 = eins1[18:24];
            rc_addr_i1 = eins1[25:31];
            case(eoc1_4b)
                4'b1100:
                    begin
                        opcode_i1 = MULTIPLY_AND_ADD;
                    end
                4'b1110:
                    begin
                        opcode_i1 = FLOATING_MULTIPLY_AND_ADD;
                    end
                4'b1111:
                    begin
                        opcode_i1 = FLOATING_MULTIPLY_AND_SUBTRACT;
                    end
            endcase
        end
        else if(eoc1_7b == 7'b0100001) begin
            ins1_type = EVEN;
            rt_addr_i1 = eins1[25:31];
            in_I18_i1  = eins1[7:24];
            opcode_i1  = IMMEDIATE_LOAD_ADDRESS;
        end
        else if(eoc1_8b == 8'b00011101 || eoc1_8b == 8'b00011100 || eoc1_8b == 8'b00001101 || eoc1_8b == 8'b00001100 ||
                eoc1_8b == 8'b00010100 || eoc1_8b == 8'b00010101 || eoc1_8b == 8'b00010110 || eoc1_8b == 8'b00000100 ||
                eoc1_8b == 8'b00000101 || eoc1_8b == 8'b00000110 || eoc1_8b == 8'b01000100 || eoc1_8b == 8'b01000110 ||
                eoc1_8b == 8'b01111100 || eoc1_8b == 8'b01111110 || eoc1_8b == 8'b01001100 || eoc1_8b == 8'b01001101 ||
                eoc1_8b == 8'b00110100 || eoc1_8b == 8'b00100100 || eoc1_8b == 8'b01110100 || eoc1_8b == 8'b01000101) begin
            rt_addr_i1 = eins1[25:31];
            ra_addr_i1 = eins1[18:24];
            in_I10_i1  = eins1[8:17];
            case(eoc1_8b)
                8'b00011101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = ADD_HALF_WORD_IMMEDIATE;
                    end
                8'b00011100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = ADD_WORD_IMMEDIATE;
                    end
                8'b00001101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = SUBTRACT_FROM_HALFWORD_IMMEDIATE;
                    end
                8'b00001100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = SUBTRACT_FROM_WORD_IMMEDIATE;
                    end
                8'b00010100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = AND_WORD_IMMEDIATE;
                    end
                8'b00010101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = AND_HALFWORD_IMMEDIATE;
                    end
                8'b00010110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = AND_BYTE_IMMEDIATE;
                    end
                8'b00000100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = OR_WORD_IMMEDIATE;
                    end
                8'b00000101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = OR_HALFWORD_IMMEDIATE;
                    end
                8'b00000110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = OR_BYTE_IMMEDIATE;
                    end
                8'b01000100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = EXCLUSIVE_OR_WORD_IMMEDIATE;
                    end
                8'b01000101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = EXCLUSIVE_OR_HALFWORD_IMMEDIATE;
                    end
                8'b01000110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = EXCLUSIVE_OR_BYTE_IMMEDIATE;
                    end
                8'b01111100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_EQUAL_WORD_IMMEDIATE;
                    end
                8'b01111110:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_EQUAL_HALFWORD_IMMEDIATE;
                    end
                8'b01001100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_GREATER_THAN_WORD_IMMEDIATE;
                    end
                8'b01001101:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE;
                    end
                8'b00110100:
                    begin
                        ins1_type = ODD;
                        opcode_i1  = LOAD_QUADWORD_DFORM;
                    end
                8'b00100100:
                    begin
                        ins1_type  = ODD;
                        opcode_i1  = STORE_QUADWORD_DFORM;
                        rc_addr_i1 = eins1[25:31];
                    end
                8'b01110100:
                    begin
                        ins1_type = EVEN;
                        opcode_i1  = MULTIPLY_IMMEDIATE;
                    end
            endcase
        end

        if(eins2 == 32'hffffffff) begin
            opcode_i2 = LNOP;
            ins2_type = EVEN;
        end
        else if(eoc2_4b == 4'b1100 || eoc2_4b == 4'b1110 || eoc2_4b == 4'b1111) begin
            ins2_type  = EVEN;
            rt_addr_i2 = eins2[4:10];
            ra_addr_i2 = eins2[11:17];
            rb_addr_i2 = eins2[18:24];
            rc_addr_i2 = eins2[25:31];
            case(eoc2_4b)
                4'b1100:
                    begin
                        opcode_i2 = MULTIPLY_AND_ADD;
                    end
                4'b1110:
                    begin
                        opcode_i2 = FLOATING_MULTIPLY_AND_ADD;
                    end
                4'b1111:
                    begin
                        opcode_i2 = FLOATING_MULTIPLY_AND_SUBTRACT;
                    end
            endcase
        end
        else if(eoc2_7b == 7'b0100001) begin
            ins2_type = EVEN;
            rt_addr_i2 = eins2[25:31];
            in_I18_i2  = eins2[7:24];
            opcode_i2  = IMMEDIATE_LOAD_ADDRESS;
        end
        else if(eoc2_8b == 8'b00011101 || eoc2_8b == 8'b00011100 || eoc2_8b == 8'b00001101 || eoc2_8b == 8'b00001100 ||
                eoc2_8b == 8'b00010100 || eoc2_8b == 8'b00010101 || eoc2_8b == 8'b00010110 || eoc2_8b == 8'b00000100 ||
                eoc2_8b == 8'b00000101 || eoc2_8b == 8'b00000110 || eoc2_8b == 8'b01000100 || eoc2_8b == 8'b01000110 ||
                eoc2_8b == 8'b01111100 || eoc2_8b == 8'b01111110 || eoc2_8b == 8'b01001100 || eoc2_8b == 8'b01001101 ||
                eoc2_8b == 8'b00110100 || eoc2_8b == 8'b00100100 || eoc2_8b == 8'b01110100 || eoc2_8b == 8'b01000101) begin
            rt_addr_i2 = eins2[25:31];
            ra_addr_i2 = eins2[18:24];
            in_I10_i2  = eins2[8:17];
            case(eoc2_8b)
                8'b00011101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = ADD_HALF_WORD_IMMEDIATE;
                    end
                8'b00011100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = ADD_WORD_IMMEDIATE;
                    end
                8'b00001101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = SUBTRACT_FROM_HALFWORD_IMMEDIATE;
                    end
                8'b00001100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = SUBTRACT_FROM_WORD_IMMEDIATE;
                    end
                8'b00010100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = AND_WORD_IMMEDIATE;
                    end
                8'b00010101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = AND_HALFWORD_IMMEDIATE;
                    end
                8'b00010110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = AND_BYTE_IMMEDIATE;
                    end
                8'b00000100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = OR_WORD_IMMEDIATE;
                    end
                8'b00000101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = OR_HALFWORD_IMMEDIATE;
                    end
                8'b00000110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = OR_BYTE_IMMEDIATE;
                    end
                8'b01000100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = EXCLUSIVE_OR_WORD_IMMEDIATE;
                    end
                8'b01000101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = EXCLUSIVE_OR_HALFWORD_IMMEDIATE;
                    end
                8'b01000110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = EXCLUSIVE_OR_BYTE_IMMEDIATE;
                    end
                8'b01111100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_EQUAL_WORD_IMMEDIATE;
                    end
                8'b01111110:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_EQUAL_HALFWORD_IMMEDIATE;
                    end
                8'b01001100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_GREATER_THAN_WORD_IMMEDIATE;
                    end
                8'b01001101:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = COMPARE_GREATER_THAN_HALFWORD_IMMEDIATE;
                    end
                8'b00110100:
                    begin
                        ins2_type = ODD;
                        opcode_i2  = LOAD_QUADWORD_DFORM;
                    end
                8'b00100100:
                    begin
                        ins2_type = ODD;
                        opcode_i2  = STORE_QUADWORD_DFORM;
                        rc_addr_i2 = eins2[25:31];
                    end
                8'b01110100:
                    begin
                        ins2_type = EVEN;
                        opcode_i2  = MULTIPLY_IMMEDIATE;
                    end
            endcase
        end

        if(stall_done) begin
            dec_stall = 0;
        end
        else if((ins1_type == EVEN && ins2_type == EVEN) || 
                (ins1_type == ODD  && ins2_type == ODD))
        begin

            dec_stall = 1;
        end
        else if((rt_addr_i1 == rt_addr_i2) && rt_addr_i1 !== 7'dx && rt_addr_i2 !== 7'dx) begin
            dec_stall = 1;
        end
        else begin
            dec_stall = 0;
        end
    end

endmodule
//end of file.
