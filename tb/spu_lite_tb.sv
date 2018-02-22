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

module top_tb();

   parameter OPCODE_LEN = 11;
   parameter INTS_LEN   = 32;

   parameter PROGFILENAME = "test_prog1.txt";

   logic clk;
   logic reset;

   logic [INTS_LEN-1:0] ints;

   initial clk=0;
   always #5 clk = ~clk;
   
   //TODO: Instantiate DUT

   initial begin
     $readmemb(PROGFILENAME, ints);
     
     // reset
     @(posedge clk); reset = 1; 
     @(posedge clk); reset = 0; 

     repeat(1000) @(posedge clk);

     $finish;
   end

endmodule
