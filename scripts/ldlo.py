#!/bin/env python

import sys
from os import environ
from subprocess import call
offset = 0
if len(sys.argv) == 1:
    exit()

device = sys.argv[1]

if len(sys.argv) > 2:
    offset = int(sys.argv[2])*512;


args = ["losetup", "-o"+str(offset), "/dev/loop0", device]
if call(args) == 0:
    print("Ok - Attached " + device + " to /dev/loop0 +"+str(offset)+" bytes");
else:
    print("Error setting " + device + " to /dev/loop0")
