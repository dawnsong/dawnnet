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
plotHist(){
    xd=$1 ; png=$2
    gnuplot <<eoh
unset key 
set xrange[-6:16]
set style fill transparent solid 0.8
set xtics format " "
set ytics format " "
set terminal png
set output "$png"

binwidth=0.1
bin(x,width)=width*floor(x/width)
plot "$xd" using (bin(\$1, binwidth)):(1.0) smooth freq with boxes lc rgb "navy"
eoh
}
plotFit(){
    xd=$1 ; yd=$2 ; png=$3

    tmp=$(dawn_getmp.sh)
    1dcat $xd $yd > $tmp
    gnuplot <<eop
#unset key
#set xlabel "$xd"
set xrange [-6:16]
#set ylabel "$yd"
set xtics format " "
set ytics format " "
set style fill transparent solid 0.8
set terminal png
set output "$png"

f(x)=k*x + b
fit f(x) "$tmp" using 1:2 via k,b
title_f(k,b) = sprintf('f(x)=%.2fx + %.2f', k, b)

plot "$tmp" using 1:2 with dots linecolor rgb "navy" notitle, f(x) t title_f(k,b) linecolor rgb "red"
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
plotHist dc003.dump dc003.hist.png
plotHist sc003.dump sc003.hist.png
plotHist ec003.dump ec003.hist.png
plotHist pc003.dump pc003.hist.png



plotFit dc003.dump sc003.dump dc003_sc003.png
plotFit sc003.dump dc003.dump sc003_dc003.png

plotFit dc003.dump ec003.dump dc003_ec003.png
plotFit ec003.dump dc003.dump ec003_dc003.png

plotFit dc003.dump pc003.dump dc003_pc003.png
plotFit pc003.dump dc003.dump pc003_dc003.png


plotFit sc003.dump ec003.dump sc003_ec003.png
plotFit ec003.dump sc003.dump ec003_sc003.png

plotFit sc003.dump pc003.dump sc003_pc003.png
plotFit pc003.dump sc003.dump pc003_sc003.png


plotFit ec003.dump pc003.dump ec003_pc003.png
plotFit pc003.dump ec003.dump pc003_ec003.png


montage \
dc003.hist.png  dc003_sc003.png dc003_ec003.png dc003_pc003.png \
sc003_dc003.png sc003.hist.png  sc003_ec003.png sc003_pc003.png \
ec003_dc003.png ec003_sc003.png ec003.hist.png  ec003_pc003.png \
pc003_dc003.png pc003_sc003.png pc003_ec003.png pc003.hist.png  \
-tile 4x4 -geometry -4-4 montage.png
}
