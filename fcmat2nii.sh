#!/bin/bash -
#
# fcmat2nii.sh
# Copyright (C) 2013 Xiao-Wei Song <dawnwei.song@gmail.com>
#

elog(){ echo "$@" 1>&2 ; }

if [ $# -eq 0 ]; then
  elog "Usage: $0 " 
  exit 1
fi 

CALLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

matlabg <<eof
addpath(genpath('$CALLDIR'));
  fcmat2nii('$1', '$2');
eof

