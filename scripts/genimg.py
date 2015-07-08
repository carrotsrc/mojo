#!/bin/env python

import sys
import math
from os import environ,geteuid,getuid
from subprocess import call

offset = 0
if len(sys.argv) < 3:
    print("Usage:\ngenimg.py sizeMB img")
    exit()


size = sys.argv[1]
img  = sys.argv[2]
bytesPerSec = 516096

cyl = int(math.ceil((int(size)*1000*1024)/bytesPerSec));

args = ["dd", "if=/dev/zero", "of="+img, "bs="+str(bytesPerSec)+"c", "count="+str(cyl)]
if call(args) == 0:
    print("Ok - created image");
else:
    print("Failed to create image")
