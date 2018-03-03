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

    parameter EVENINSFILE  = "even_ins_file.txt";
    parameter ODDINSFILE  = "odd_ins_file.txt";
    parameter NUM_PIPES = 2;

    parameter BYTE       =   8;
    parameter HALFWORD   =  16;
    parameter WORD       =  32;
    parameter DOUBLEWORD =  64;
    parameter QUADWORD   = 128;

    typedef enum logic [10:0] {  //Simple Fixed Instructions
                                 IMMEDIATE_LOAD_HALFWORD                   = 11'b00010000011,
                                 IMMEDIATE_LOAD_WORD                       = 11'b00010000001,
                                 IMMEDIATE_LOAD_ADDRESS                    = 11'b00000100001,
                                 ADD_HALF_WORD                             = 11'b00011001000,
                                 ADD_HALF_WORD_IMMEDIATE                   = 11'b00000011101,
                                 ADD_WORD                                  = 11'b00011000000,
                                 ADD_WORD_IMMEDIATE                        = 11'b00000011100,
                                 SUBTRACT_FROM_HALFWORD                    = 11'b00001001000,
                                 SUBTRACT_FROM_HALFWORD_IMMEDIATE          = 11'b00000001101,
                                 SUBTRACT_FROM_WORD                        = 11'b00001000000,
                                 SUBTRACT_FROM_WORD_IMMEDIATE              = 11'b00000001100,
                                 ADD_EXTENDED                              = 11'b01101000000,
                                 SUBTRACT_FROM_EXTENDED                    = 11'b01101000001,
                                 CARRY_GENERATE                            = 11'b00011000010,
                                 BORROW_GENERATE                           = 11'b00001000010,
                                 COUNT_LEADING_ZEROS                       = 11'b01010100101,
                                 AND                                       = 11'b00011000001,
                                 AND_WORD_IMMEDIATE                        = 11'b00000010100,
                                 AND_HALFWORD_IMMEDIATE                    = 11'b00000010101,
                                 AND_BYTE_IMMEDIATE                        = 11'b00000010110,
                                 OR                                        = 11'b00001000001,
                                 OR_WORD_IMMEDIATE                         = 11'b00000000100,
                                 OR_HALFWORD_IMMEDIATE                     = 11'b00000000101,
                                 OR_BYTE_IMMEDIATE                         = 11'b00000000110,
                                 EXCLUSIVE_OR                              = 11'b01001000001,
                                 EXCLUSIVE_OR_WORD_IMMEDIATE               = 11'b00001000100,
                                 EXCLUSIVE_OR_HALFWORD_IMMEDIATE           = 11'b00001000101,
                                 EXCLUSIVE_OR_BYTE_IMMEDIATE               = 11'b00001000110,
                                 NAND                                      = 11'b00011001001,
                                 NOR                                       = 11'b00001001001,
                                 EQUIVALENT                                = 11'b01001001001,
                                 COMPARE_EQUAL_WORD                        = 11'b01111000000,
                                 COMPARE_EQUAL_WORD_IMMEDIATE              = 11'b00001111100,
                                 COMPARE_EQUAL_HALFWORD                    = 11'b01111001000,
                                 COMPARE_EQUAL_HALFWORD_IMMEDIATE          = 11'b00001111101,
                                 COMPARE_GREATER_THAN_WORD                 = 11'b01001000000,
                                 COMPARE_GREATER_THAN_WORD_IMMEDIATE       = 11'b00001001100,
                                 COMPARE_GREATER_THAN_HALFWORD             = 11'b01001001000,
                                 COMAPRE_GREATER_THAN_HALFWORD_IMMEDIATE   = 11'b00001001101,
                                 COMPARE_GREATER_THAN_BYTE                 = 11'b01001010000,
                                 COMPARE_GREATER_THAN_BYTE_IMMEDIATE       = 11'b00001001110,
                                 //Shift and Rotate
                                 SHIFT_LEFT_HALFWORD                       = 11'b00001011111,
                                 SHIFT_LEFT_HALFWORD_IMMEDIATE             = 11'b00001111111,
                                 SHIFT_LEFT_WORD                           = 11'b00001011011,
                                 SHIFT_LEFT_WORD_IMMEDIATE                 = 11'b00001111011,
                                 SHIFT_LEFT_QUADWORD_BY_BITS               = 11'b00111011011,
                                 SHIFT_LEFT_QUADWORD_BY_BITS_IMMEDIATE     = 11'b00111111011,
                                 SHIFT_LEFT_QUADWORD_BY_BYTES              = 11'b00111011111,
                                 SHIFT_LEFT_QUADWORD_BY_BYTES_IMMEDIATE    = 11'b00111111111,
                                 ROTATE_WORD                               = 11'b00001011000,
                                 ROTATE_WORD_IMMEDIATE                     = 11'b00001111000,
                                 ROTATE_QUADWORD_BY_BITS                   = 11'b00111011000,
                                 ROTATE_QUADWORD_BY_BITS_IMMEDIATE         = 11'b00111111000,
                                 ROTATE_QUADWORD_BY_BYTES                  = 11'b00111011100,
                                 ROTATE_QUADWORD_BY_BYTES_IMMEDIATE        = 11'b00111111100
                              } Opcodes;

endpackage
