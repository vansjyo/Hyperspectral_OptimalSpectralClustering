close all;
% pkg load mapping;
%file_path='subset_rfl(spectral).tif';
%[z,info]= rasterread(file_path);
z = paviaU;
[rows,cols,bands] = size(z);
k=zeros(bands,bands);
for i=1:bands-1
  for j=i+1:bands
    %p1 = z(i).data./z(j).data;
    %p2 = z(j).data./z(i).data;
    %q1 = log(p1);
    %q2 = log(p2);
    %r1 = z(i).data.*q1;
    %r2 = z(j).data.*q2;
    %k(j,i)=k(i,j)= sum(r1(:)) + sum(r2(:));
    p1 = z(:,:,i)./z(:,:,j);
    p2 = z(:,:,j)./z(:,:,i);
    q1 = log(p1);
    q2 = log(p2);
    r1 = z(:,:,i).*q1;
    r2 = z(:,:,j).*q2;
    k(j,i)= sum(r1(:)) + sum(r2(:));
    k(i,j)= sum(r1(:)) + sum(r2(:));
  end
end

