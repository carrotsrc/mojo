#!/bin/env python

import sys
from os import environ,geteuid
from subprocess import call
if geteuid() != 0:
    print("Requires root privileges")
    exit();

loopdev = 0
if len(sys.argv) > 1:
    loopdev = int(sys.argv[1])

args = ["losetup", "-d", "/dev/loop"+str(loopdev)]
if call(args) == 0:
    print("Ok - Detached from /dev/loop"+str(loopdev));
else:
    print("Error detaching /dev/loop0")
