#! /bin/bash
#
# nii2thrdFCmat.sh  2013-09-30 09:33
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
test $# -eq 4 || usage;
# TODO
#{
#
#} 1>${progname}.log 2>${progname}.err

nii=$1
msk=$2
prfx=$3
pthrd=$4

nii2fcmat.sh $nii $msk
fcmat="fcmat.$(basename $nii .nii)*.mat"
threshFCmat.sh $fcmat $prfx $pthrd
rm $fcmat
