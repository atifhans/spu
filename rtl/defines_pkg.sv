// ------------------------------------------//
// Matrix Vector Multiplier Defines Part-1
// ------------------------------------------//
// NAME:  Atif Iqbal
// NETID: aahangar
// SBUID: 111416569
//
// NAME: Karthik Raj
// NETID: ?
// SBUID: ?
// ------------------------------------------//

package defines_pkg;

    `define UTEST_SFIXED

    parameter NUM_PIPES = 2;

    parameter BYTE       =   8;
    parameter HALFWORD   =  16;
    parameter WORD       =  32;
    parameter DOUBLEWORD =  64;
    parameter QUADWORD   = 128;

    typedef enum logic [10:0] {  IMMEDIATE_LOAD_HALFWORD       = 11'b00010000011,
                                 IMMEDIATE_LOAD_HALFWORD_UPPER = 11'b00010000010
                              } Opcodes;
endpackage
