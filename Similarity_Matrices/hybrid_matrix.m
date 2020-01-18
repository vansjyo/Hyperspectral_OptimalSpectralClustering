% close all; clear all;
% pkg load mapping;
% file_path='subset_rfl(spectral).tif';
% [z,info]= rasterread(file_path);
z = indian_pines_corrected;
[rows,cols,bands] = size(z);


    hybrid= SID.*tan(SAM);
