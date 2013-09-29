#! /bin/bash
#
# threshFCmat.sh
#% Init: 2013-07-06 12:38
#% Copyright (C) 2013~2020 Xiaowei.Song <dawnwei.song@gmail.com>
#% Distributed under terms of the AFL (Academy Free license).
#
elog(){ echo "$@" 1>&2 ; }
if [ $# -eq 0 ]; then
  cat <<eof
Usage: $0 fcmat thrd.prfx 0.0001=p
eof
  exit 1
fi 

CALLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

matlabg <<eof
addpath(genpath('$CALLDIR'));
threshFCmat('$1','$2',${3:-0.0001});
eof


