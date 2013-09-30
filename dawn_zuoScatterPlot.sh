#!/bin/bash
# dawnsong
# 20130929
# repeat Dr. Zuo's scatter plot and histogram of CC centrality

ln -sf ../../inia19s-gm.msk.nii .

nii2dump(){
    echo $@
    dt=$1
    prfx=`basename $dt .nii`
    #3dmaskave -q -dump -mask ../../inia19s-gm.msk.nii dc003.nii > dc003.dump
    3dmaskave -q -dump -mask inia19s-gm.msk.nii $dt > ${prfx}.dump
    sed -i '/^\+\+.*/d' ${prfx}.dump

    3dhistog -mask inia19s-gm.msk.nii -prefix ${prfx}.hist $dt
    1dplot -png ${prfx}.hist.png -x ${prfx}.hist.1D[0]  ${prfx}.hist.1D[1]
}
plot(){
    xd=$1 ; yd=$2 ; png=$3

    tmp=$(dawn_getmp.sh)
    1dcat $xd $yd > $tmp
    gnuplot <<eop
unset key
set xlabel "$xd"
set ylabel "$yd"
set terminal png
set output "$png"

f(x)=m*x + b
fit f(x) "$tmp" using 1:2 via m,b

plot "$tmp" using 1:2 with dots linecolor rgb "navy", f(x) linecolor rgb "red"
eop
    rm $tmp
}

test 0 -eq 1 && {
nii2dump dc003.nii 
nii2dump sc003.nii 
nii2dump ec003.nii 

nii2dump pc003.nii 
}

test 1 -eq 1  && {
plot dc003.dump sc003.dump dc003_sc003.png
plot sc003.dump dc003.dump sc003_dc003.png

plot dc003.dump ec003.dump dc003_ec003.png
plot ec003.dump dc003.dump ec003_dc003.png

plot dc003.dump pc003.dump dc003_pc003.png
plot pc003.dump dc003.dump pc003_dc003.png

plot sc003.dump ec003.dump sc003_ec003.png
plot ec003.dump sc003.dump ec003_sc003.png

plot sc003.dump pc003.dump sc003_pc003.png
plot pc003.dump sc003.dump pc003_sc003.png

plot ec003.dump pc003.dump ec003_pc003.png
plot pc003.dump ec003.dump pc003_ec003.png
}
