#!/usr/bin/env python2

import os
import sys
import subprocess

from subprocess import call

ins_opcode = {}
ins_type   = {}

def print_usage():
    print sys.argv[0] + " <input file> <output file> <mode>."
    print "<input file> : Input assembly instruction file."
    print "<output file> : Output machine coded file."
    print "<mode> : 0 - Input is in assembly language, for full SPU sim."
    print "       : 1 - Input is in intermediate assembly language, for SPU pipes sim.\n"

print "!!Welcome to SPU Mini Assembler!!"

if(len(sys.argv) != 4):
    print "Invalid number of arguments\n"
    print_usage();
    sys.exit(0);
else:
    fname = sys.argv[1]
    fout = sys.argv[2]
    mode = int(sys.argv[3])
    print "Input file: " + fname + ", Output file: " + fout + ", Mode: " + sys.argv[3] 

with open("ins_dict.txt", 'r') as f:
    for line in f:
        items = line.split()
        key, value1, value2, value3 = items[0], items[1], items[2], items[3]
        if(mode == 1):
            ins_opcode[key] = value2
        else:
            ins_opcode[key] = value1
        ins_type[key] = value3
    f.close()

with open(fname) as f:
    fw = open(fout, 'w')
    for line in f:
        ls = line.strip()
        if(ls[0] == '#'):
            continue

        sys.stdout.write('.')
        sys.stdout.flush()
        #TODO: may have to strip all spaces when splitting
        words = line.split()
        mcode = ""
        opcode = words[0]

        if(mode == 1):
            syms = words[1].split(',')
            mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(11))
            mcode += str(bin(int(syms[0]))[2:].zfill(18))
            mcode += str(bin(int(syms[1]))[2:].zfill(7))
            mcode += str(bin(int(syms[2]))[2:].zfill(7))
            mcode += str(bin(int(syms[3]))[2:].zfill(7))
            mcode += str(bin(int(syms[4]))[2:].zfill(7))
        else:
            #TODO: Have to write special cases for some instructions...
            itype = ins_type[opcode]
            print itype
            if(itype == "1" or itype == "3"): #RR or RI17
                syms = words[1].split(',')
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(11))
                if(opcode == "bi"): 
                    mcode += str(bin(int("0"))[2:].zfill(7))
                    mcode += str(bin(int(syms[0]))[2:].zfill(7))
                    mcode += str(bin(int("0"))[2:].zfill(7))
                else:
                    mcode += str(bin(int(syms[0]))[2:].zfill(7))
                    mcode += str(bin(int(syms[1]))[2:].zfill(7))
                    mcode += str(bin(int(syms[2]))[2:].zfill(7))
            elif(itype == "2"): #RRR
                syms = words[1].split(',')
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(4))
                mcode += str(bin(int(syms[0]))[2:].zfill(7))
                mcode += str(bin(int(syms[1]))[2:].zfill(7))
                mcode += str(bin(int(syms[2]))[2:].zfill(7))
                mcode += str(bin(int(syms[3]))[2:].zfill(7))
            elif(itype == "4"): #RI10
                syms = words[1].split(',')
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(8))
                mcode += str(bin(int(syms[0]))[2:].zfill(10))
                mcode += str(bin(int(syms[1]))[2:].zfill(7))
                mcode += str(bin(int(syms[2]))[2:].zfill(7))
            elif(itype == "5"): #RI16
                syms = words[1].split(',')
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(9))
                if(opcode == "br" or opcode == "bra"):
                    mcode += str(bin(int(syms[0]))[2:].zfill(16))
                    mcode += str(bin(int("0"))[2:].zfill(7))
                else:
                    mcode += str(bin(int(syms[0]))[2:].zfill(16))
                    mcode += str(bin(int(syms[1]))[2:].zfill(7))
            elif(itype == "6"): #RI18
                syms = words[1].split(',')
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(7))
                mcode += str(bin(int(syms[0]))[2:].zfill(18))
                mcode += str(bin(int(syms[1]))[2:].zfill(7))
            else:
                mcode += str(bin(int(ins_opcode[opcode]))[2:].zfill(11))
                mcode += str(bin(int("0"))[2:].zfill(21))

        fw.write(mcode + "\n")

    print "\n"
    fw.close()
    f.close()
print "!!SPU Mini Assembler finished sucessfully!!\n"

