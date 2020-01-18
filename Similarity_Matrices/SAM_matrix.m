close all;
% pkg load mapping;
% file_path='subset_rfl(spectral).tif';
% [z,info]= rasterread(file_path);
z = paviaU;
[rows,cols,bands] = size(z);
l = zeros(bands,bands);
for i=1:bands-1
  i_abs =  sqrt(sum(sum(z(:,:,i).^2)));
  for j=i+1:bands
    j_abs =  sqrt(sum(sum(z(:,:,j).^2)));
    dot_product = sum(sum(z(:,:,i).*z(:,:,j)));
    costheta = dot_product/(i_abs*j_abs);
    l(j,i) = acos(costheta);
    l(i,j) = acos(costheta);
  end
end
