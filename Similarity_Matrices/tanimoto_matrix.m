close all;
% pkg load mapping;
% load 'Indian_pines_corrected.mat';
% z = indian_pines_corrected;
z = paviaU;
[rows,cols,bands] = size(z);

%file_path='subset_rfl(spectral).tif';
%[z,info]= rasterread(file_path);
k=ones(bands,bands);
for i=1:bands-1
  %m = sum((z(i).data.^2)(:));
  m = sum(sum((z(:,:,i).^2)));
  for j=i+1:bands
    %n = sum((z(i).data).*(z(j).data));
    %den = m + sum((z(j).data.^2)(:)) - n;
    %k(j,i)=k(i,j)=n/den;
    n = sum(sum(z(:,:,i).*z(:,:,j)));
    den = m + sum(sum((z(:,:,j).^2))) - n;
    k(j,i) = n/den;
    k(i,j) = n/den;
  end
end
figure(1);
image(k); 
figure(2);
imagesc(k);
