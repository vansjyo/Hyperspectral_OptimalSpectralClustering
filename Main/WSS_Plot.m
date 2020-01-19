%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Program For Spectral Clustering                       %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [ WSS ] = WSS_Plot(L_norm)

%bands = size(L_norm,1);
WSS = zeros(30,1);
bands = size(L_norm,1);

for i=1:30
    
    %preallocating memory for v_norm
    %v_norm = zeros(bands,i);

    %finding eigenvectors corresponding to k largest eigenvectors
    [vk,~] = eigs(L_norm,bands);
  
    %normalizing eigenvector (if needed)
    %for m = 1:bands
    %    v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
    %end

    %applying k-means
    [~,~,sumd,~] = kmeans(vk,i);
    WSS(i,1) = sum(sumd);
    
end

figure;
plot(WSS,'x-');
title('within-Cluster-Sum-Of-Squares(elbow method)');

end
