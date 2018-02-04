#!/usr/bin/env python2

import sys
import subprocess

from subprocess import call

def gen_syn_script(name, clk):
    with open('cfg/runsynth_template.tcl', 'r') as file :
        filedata = file.read()

    filedata = filedata.replace('{ARG0}', name)
    filedata = filedata.replace('{CLK}' , str(clk))

    with open('synth/runsynth_layer.tcl', 'w') as file:
        file.write(filedata)

    return "synth/" + name + ".txt"

def run_syn(name, clk):
    lname = gen_syn_script(name, clk)
    p1 = subprocess.Popen(["dc_shell", "-f", "synth/runsynth_layer.tcl"], stdout=subprocess.PIPE)
    p2 = subprocess.Popen(["tee", lname], stdin=p1.stdout, stdout=subprocess.PIPE)
    p1.stdout.close()
    p2.communicate()

    with open(lname) as f:
        for line in f:
            if "Error" in line:
                print line
            elif "/CK" in line:
                print line
            elif "Warning" in line and "signed" not in line and "tran" not in line:
                print line
            elif "Total" in line and "undefined" not in line and "Dynamic" not in line:
                print line
            elif "slack" in line:
                print line

def run_sim():

    lname = "sim/" + name + ".log"

    #p1 = subprocess.Popen(["./testmodetwo", str(N), str(M1), str(M2), str(M3), str(Mults), str(bits)], stdout=subprocess.PIPE)
    #p2 = subprocess.Popen(["tee", lname], stdin=p1.stdout, stdout=subprocess.PIPE)
    #p1.stdout.close()
    #p2.communicate()

    with open(lname) as f:
        for line in f:
            if "errors" in line:
                print line
            elif "Throughput" in line:
                print line

flow = sys.argv[1]

if flow == "syn":
    print "Running Synthesis!"
    name = sys.argv[2]
    clk  = float(sys.argv[3])
    run_syn(name, clk)
elif flow == "sim":
    run_sim()
elif flow == "clean":
    print "Cleaning Temp Files!"
    call("rm -rf command.log default.svf work_synth")


