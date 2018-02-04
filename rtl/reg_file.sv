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

module reg_file #(parameter NUM_REGS = 128,
                  parameter RADDR_WD = $clog2(NUM_REGS))
(
    input  logic                  clk,
    input  logic                  reset,
    input  logic [RADDR_WD-1:0]   reg_addr,
    input  logic                  reg_wr,
    input  logic [127:0]          reg_in,
    output logic [127:0]          reg_out
);

    logic [127:0] reg_array[128];

    always_ff @(posedge clk)
        if(reset) begin
            reg_out <= 'd0;
        end
        else begin
            reg_out <= reg_array[reg_addr];
        end

    always_ff @(posedge clk)
        if(reset) begin
            for(int i = 0; i < NUM_REGS; i++) begin
                reg_array[i] <= 'd0;
            end
        end
        else begin
            if(reg_wr) reg_array[reg_addr] <= reg_in;
        end

endmodule
//end of file.
