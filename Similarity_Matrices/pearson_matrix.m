close all;
% file_path='subset_rfl(spectral).tif';
% [z,info]= rasterread(file_path);
z = paviaU;
[rows,cols,bands] = size(z);
k=ones(bands,bands);
q=zeros(bands,rows*cols);
for i=1:bands
  q(i,:)=reshape(z(:,:,i),rows*cols,1);  
end
for i=1:bands-1
  m=q(i,:);
  for j=i+1:bands
    n=q(j,:);
    c=cov(m,n);
    k(i,j)=c(2)/(std(m)*std(n));
    k(j,i)=c(2)/(std(m)*std(n));
  end
end
  
figure(1);
image(k); 

