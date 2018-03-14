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

module ls_and_cache #(parameter MEM_SIZE = LS_SIZE/16)
(
    input  logic                   clk,
    input  logic                   rst,
    input  logic [0:127]           ls_data_wr,
    input  logic [0:31]            ls_addr,
    input  logic                   ls_wr_en,
    output logic [0:127]           ls_data_rd
);

    logic [0:127] ls_mem[MEM_SIZE];

    initial begin
        $readmemh(LSLOADFILE, ls_mem);
    end

    always_ff @(posedge clk) begin
        ls_mem[ls_addr] <= ls_data_wr;
    end

    assign ls_data_rd = ls_mem[ls_addr];

endmodule
//end of file.
