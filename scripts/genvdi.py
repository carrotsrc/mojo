#!/bin/env python

import sys
from os import environ,geteuid
from subprocess import call
offset = 0
if len(sys.argv) < 3:
    print("Usage:\ngenvdi.py raw out [uuid]")
    exit()

img = sys.argv[1]
out = sys.argv[2]


uuida = [];
if len(sys.argv) > 3:
	uuida = ["--uuid", sys.argv[3]]

args = ["VBoxManage", "convertfromraw","--format", "vdi"] + uuida +[img, out]
if call(args) == 0:
    print("Ok - created vdi from raw");
else:
    print("Error creating vdi")
