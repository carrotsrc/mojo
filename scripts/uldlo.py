#!/bin/env python

import sys
from os import environ
from subprocess import call
args = ["losetup", "-d", "/dev/loop0"]
if call(args) == 0:
    print("Ok - Detached from /dev/loop0");
else:
    print("Error detaching /dev/loop0")
