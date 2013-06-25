function [result] = fcmat2nii(fcmat, fnii)
%mat2nii:
%
%Copyright (C) 2013 Xiao-Wei Song <dawnwei.song@gmail.com>

load(fcmat);
img=zeros([size(fcmat), 2]);
nii=make_nii(img);
save_nii(nii, fnii);
