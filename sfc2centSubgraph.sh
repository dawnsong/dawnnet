#! /bin/bash
#
# sfc2centSubgraph.sh
#% Init: 2013-07-09 15:24
#% Copyright (C) 2013~2020 Xiaowei.Song <dawnwei.song@gmail.com>
#% Distributed under terms of the AFL (Academy Free license).
#
CALLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
elog(){ echo "$@" 1>&2 ; }
if [ $# -eq 0 ]; then
  cat <<eof
Usage: $0 fcmat.120214088205_004_inia19s-gm.msk.Ple0.0001.positive.mat ../inia19s-gm.msk.nii
eof
  exit 1
fi 

matlabg <<eof
addpath(genpath('$CALLDIR'));
addpath(genpath('$CALLDIR/../1000FCP'));

%calc centrility
load('$1');
cij=sfcmat;
m=find(cij);
cij(m)=1;
dc=IPN_centDegree(cij);
sc=IPN_centSubgraph(cij);
ec=IPN_centEigenvector(cij);
pc=IPN_centPagerand(cij,0.85);

% for spm8
%load mask and save results to nii
Vi=spm_vol('$2');
msk=spm_read_vols(Vi);
midx=find(msk);

Vo=spm_create_vol(Vi);

Vo.fname=sprintf('%s.dc.nii','`basename $1 .mat`');
Vo.descrip=sprintf('%s degree centrility', '`basename $1 .mat`');
img=zeros(Vo.dim); img(midx)=dc;
spm_write_vol(Vo,img);

Vo.fname=sprintf('%s.sc.nii','`basename $1 .mat`');
Vo.descrip=sprintf('%s subgraph centrility', '`basename $1 .mat`');
img=zeros(Vo.dim); img(midx)=sc;
spm_write_vol(Vo,img);

Vo.fname=sprintf('%s.ec.nii','`basename $1 .mat`');
Vo.descrip=sprintf('%s eigen-vector centrility', '`basename $1 .mat`');
img=zeros(Vo.dim); img(midx)=ec;
spm_write_vol(Vo,img);

Vo.fname=sprintf('%s.pc.nii','`basename $1 .mat`');
Vo.descrip=sprintf('%s page-rank centrility', '`basename $1 .mat`');
img=zeros(Vo.dim); img(midx)=pc;
spm_write_vol(Vo,img);
eof



