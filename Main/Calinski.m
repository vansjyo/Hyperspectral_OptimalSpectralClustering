% Calinski Index 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [calinski_index,TSS_sum,WGSS,BGSS,DG] = Calinski(  nClusters , L_norm )

bands=size(L_norm,1);
%preallocating memory for constants in index
   v_norm = zeros(bands,bands);

%finding eigenvectors corresponding to k largest eigenvectors
%    [vk,~] = eigs(L_norm ,nClusters,'lm');
[vk,~] = eigs(L_norm,bands);

%normalizing eigenvector
  for m = 1:bands
      v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
  end

%applying k-means
[IDX,~,~,~] = kmeans(vk,nClusters);
%column vecor with number of points in respective cluster
count = zeros(nClusters,1);
for p = 2:nClusters
  count(p,1) = size(find(IDX(:)==p),1);
end


TSS_matrix = zeros(bands,bands);
for i=1:bands
    for j=1:bands
        TSS_matrix(i,j) = sum((v_norm(i,:) - v_norm(j,:)).^2);
        TSS_matrix(j,i) = sum((v_norm(i,:) - v_norm(j,:)).^2); 
    end
end

TSS_sum = sum(sum(TSS_matrix));
D_bar = TSS_sum/(bands*(bands-1));

TSS = 0.5 * (bands-1) * D_bar;

DG = zeros(bands,1);
DG_bar = zeros(nClusters,1);

for i=1:bands 
    A = find(IDX == IDX(i,1));
    S_A = size(A,1);
    for j=1:S_A
        k_1 = v_norm(i,:) - v_norm(A(j),:);
        DG(i,1) = DG(i,1) + sum(k_1.^2);
    end
end

for i=1:nClusters
    B = find(IDX == i);
    S_B = size(B,1);
    DG_bar(i,1) = sum(DG(B,1))/(S_B);
end

WGSS = sum(DG_bar)/2;
BGSS = TSS - WGSS;

calinski_index = (BGSS/(nClusters-1))/(WGSS/(bands-nClusters));


end


%%
% COPY PASTE THIS CODE ON COMMAND WINDOW TO RUN THE FUNCTION
% val = zeros(30,1);
% for i=1:30
%     [calinski_index,TSS_sum,WGSS,BGSS,DG] = Calinski( bands, nClusters , L_norm );
%     val(i,1) = sum(DG)/TSS_sum;
% end    



