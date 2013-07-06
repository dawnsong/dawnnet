function threshFCmat(afcmat, athdprfx, ap)
load afcmat;

msk= p>=ap;
fcmat(~msk)=0;

%positive
pfcmat=fcmat;
pm= fcmat>0;
pfcmat[~pm]=0;

[i,j,s]=find(pfcmat);
[m,n]=size(pfcmat);
sfcmat=sparse(i,j,s,m,n);
fn=sprintf("%s.Pge%g.positive.mat",athdprfx,ap);
save(fn, 'sfcmat')
clear pfcmat pm sfcmat;

%negative
nfcmat=fcmat;
nm= fcmat<0;
nfcmat[~nm]=0;

[i,j,s]=find(nfcmat);
[m,n]=size(nfcmat);
sfcmat=sparse(i,j,s,m,n);
fn=sprintf("%s.Pge%g.negative.mat",athdprfx,ap);
save(fn, 'sfcmat')
clear nfcmat nm sfcmat;
