%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [IDX,CENTER,sumd,dist,vk] = clusterSilhouette(L_norm, nClusters ,init )

    bands = size(L_norm,1);
    %preallocating memory for v_norm
    v_norm = zeros(bands,nClusters);

    %finding eigenvectors corresponding to k largest eigenvectors
    [vk,~] = eigs(L_norm,nClusters);
  
    %normalizing eigenvector
    for m = 1:bands
        v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
    end

    %applying k-means
    [IDX,CENTER,sumd,dist]=kmeans(v_norm,nClusters,'Start', init);
     
    %silhouette
    figure;
    silhouette(v_norm,IDX);
    

end
