close all;
% pkg load mapping;
% load 'Indian_pines_corrected.mat';
z = paviaU;
[rows,cols,bands] = size(z);
%[z,info]= rasterread(file_path);
k=zeros(bands,bands);
for i=1:bands-1
  for j=i+1:bands
    q=(z(:,:,i)-z(:,:,j)).^2;
    k(j,i)=sqrt(sum(sum(q)));
    k(i,j)=sqrt(sum(sum(q)));
  end
end
figure(1);
image(k); 
figure(2);
imagesc(k);
