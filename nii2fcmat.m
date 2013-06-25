function [fcmat, vmd] = nii2fcmat(fnii, fmsk )
%nii2fcmat:
%
%Copyright (C) 2013 Xiao-Wei Song <dawnwei.song@gmail.com>

v=spm_vol(fnii);
vd=spm_read_vols(v);
[n1 n2 n3 n4]=size(vd);
vd=reshape(vd,[n1*n2*n3, n4]);
vd=vd';

vm=spm_vol(fmsk);
vmd=spm_read_vols(vm);
vmdi=find(vmd~=0);
msk=reshape(vmdi, [1 length(vmdi)]);
msk=repmat(msk, [n4 1]);

vd=vd(find(msk));
vd=reshape(vd, [n4, length(vmdi)]);

%fcmat=zeros(length(vmdi));
[fcmat,p]=corrcoef(vd);

[~,fn, ext]=fileparts(fnii);
fcmatfilename=[fn '_'];
[~,fn, ext]=fileparts(fmsk);
fcmatfilename=[fcmatfilename, fn];
save(sprintf('fcmat.%s.mat', fcmatfilename), 'fcmat', 'p', 'vmd');
