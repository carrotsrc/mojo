#!/bin/env python

import sys
from os import environ
from subprocess import call
offset = 0
if len(sys.argv) < 3:
    exit()

img = sys.argv[1]
out = sys.argv[2]


args = ["VBoxManage", "convertfromraw","--format", "vdi", img, out]
if call(args) == 0:
    print("Ok - created vdi from raw");
else:
    print("Error creating vdi")
