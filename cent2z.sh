#! /bin/bash
#
# cent2z.sh  2013-09-23 10:04
# Copyright (C) 2013 Xiaowei Song <dawnwei.song@gmail.com>
#
# Distributed under terms of the MIT license.
#
true=":" ; false="/bin/false" ; success=0 ; failure=1
progname=`basename $0`
usage() {   cat <<EOM
Usage: $progname  [-h] [--] ...
EOM
    exit 1
}
die() { [ $# != 0 ] && echo "$@" ; exit 1 ; }
warn(){ echo "$@" >&2 ; }
while getopts h opt; do
    case  $opt in
        h) usage ;;
    esac
done
shift `expr $OPTIND - 1`
test $# -ge 1 || usage;
# TODO
#{
#
#} 1>${progname}.log 2>${progname}.err

cent=$1
msk=$2
read mean sigma o < <(3dmaskave -sigma -mask $msk $cent)
fcent=$(basename $cent)
3dcalc -a $cent -b $msk -expr "(a-$mean)/$sigma * step(b)" -prefix $fcent
