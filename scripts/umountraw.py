#!/bin/env python

import sys
from os import environ,geteuid,chown
from subprocess import call

if geteuid() != 0:
    print("Requires root privileges")
    exit();

loopdev = 0
if len(sys.argv) > 1:
    loopdev = int(sys.argv[3])

args = ["umount", "/dev/loop"+str(loopdev)]
if call(args) == 0:
    print("Ok - Unmounted /dev/loop"+str(loopdev))
else:
    print("Error unmounting")
