function threshFCmat(afcmat, athdprfx, ap)
%
%
% Copyright (C) 2013 Xiaowei.Song <dawnwei.song@gmail.com>
% Distributed under terms of the AFL (Academy Free license).
%
eval(sprintf('load %s', afcmat));

msk= p<=ap;
fcmat(~msk)=0;

%both positive and negative
[i,j,s]=find(fcmat);
[m,n]=size(fcmat);
sfcmat=sparse(i,j,s,m,n);
fn=sprintf('%s.Ple%g.both.mat',athdprfx,ap);
save(fn, 'sfcmat')
clear sfcmat;

%positive
pfcmat=fcmat;
pm= fcmat>0;
pfcmat(~pm)=0;

[i,j,s]=find(pfcmat);
[m,n]=size(pfcmat);
sfcmat=sparse(i,j,s,m,n);
fn=sprintf('%s.Ple%g.positive.mat',athdprfx,ap);
save(fn, 'sfcmat')
clear pfcmat pm sfcmat;

%negative
nfcmat=fcmat;
nm= fcmat<0;
nfcmat(~nm)=0;

[i,j,s]=find(nfcmat);
[m,n]=size(nfcmat);
sfcmat=sparse(i,j,s,m,n);
fn=sprintf('%s.Ple%g.negative.mat',athdprfx,ap);
save(fn, 'sfcmat')
clear nfcmat nm sfcmat;
