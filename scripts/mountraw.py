#!/bin/env python

import sys
from os import environ,geteuid,chown
from subprocess import call

if len(sys.argv) < 2:
    print("Usage:\nmountraw.py mntpoint [fs type]")
    exit()

if geteuid() != 0:
    print("Requires root privileges")
    exit();

mnt = sys.argv[1]
fstype = "ext2"

if len(sys.argv) > 2:
    fstype = sys.argv[2]


args = ["mount", "-t"+fstype,"/dev/loop0", mnt ]
if call(args) == 0:
    chown(mnt, int(environ['SUDO_UID']), -1);
    print("Ok\nMounted to "+mnt+"\nOwned by uid " + str(environ['SUDO_UID']))
else:
    print("Error mounting")
