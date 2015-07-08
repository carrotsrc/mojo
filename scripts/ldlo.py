#!/bin/env python

import sys
from os import environ,geteuid,getuid
from subprocess import call
offset = 0
if len(sys.argv) == 1:
    print("Usage:\nldlo.py img [offset]")
    exit()

if geteuid() != 0:
    print("Requires root privileges")
    exit();

device = sys.argv[1]

if len(sys.argv) > 2:
    offset = int(sys.argv[2])*512;

loopdev = 0
if len(sys.argv) > 3:
    loopdev = int(sys.argv[3])
    


args = ["losetup", "-o"+str(offset), "/dev/loop"+str(loopdev), device]
if call(args) == 0:
    print("Ok - Attached " + device + " to /dev/loop"+str(loopdev)+" +"+str(offset)+" bytes");
else:
    print("Error setting " + device + " to /dev/loop0"+str(loopdev))
