#!/usr/bin/env python2

import os
import sys
import subprocess

from subprocess import call

my_dict = {}
fname = sys.argv[1]

with open("opcodes.txt", 'r') as f:
    for line in f:
        items = line.split()
        key, values = items[0], items[1]
        my_dict[key] = values

with open(fname) as f:
    for line in f:
        words = line.split()
        idx = 0
        mcode = ""
        for word in words:
            if (idx == 0):
                mcode += my_dict[word]
                idx = 1
            elif (idx == 1):
                mcode += str(bin(int(word))[2:].zfill(18))
                idx = 2
            else:
                mcode += str(bin(int(word))[2:].zfill(7))
        print mcode

