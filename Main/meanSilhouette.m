%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ] = meanSilhouette(bands, L_norm)

s = zeros(bands,30);

for i=1:30
    
    %preallocating memory for v_norm
    v_norm = zeros(bands,bands);

    %finding eigenvectors corresponding to k largest eigenvectors
    [vk,~] = eigs(L_norm,bands);
  
    %normalizing eigenvector
    for m = 1:bands
        v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
    end

    %applying k-means
    [IDX,CENTER,sumd,dist]=kmeans(vk,i);
     
    %silhouette
    [s(:,i),h] = silhouette(vk,IDX);
    
end

%mean silhouette plot
    figure;
    plot(sum(s)/bands,'-x');
    title('silhouette plot');
    
end
