#!/bin/bash

#loop through kernel files, finding checkpatch warnings

#if [ 0 -eq $(./scripts/checkpatch.pl $i >/tmp/kernelcheck) ]
echo "$1"
$(./scripts/checkpatch.pl $1 >/tmp/kernelcheck)
echo /tmp/kernelcheck
