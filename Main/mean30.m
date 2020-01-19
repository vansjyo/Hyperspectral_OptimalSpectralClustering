%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ init ] = mean30( nClusters , bands ,L_norm )

CENTERS = zeros(nClusters,nClusters,30);
  for i=1:30
    %preallocating memory for v_norm
    v_norm = zeros(bands,nClusters);

    %finding eigenvectors corresponding to k largest eigenvectors
    [vk, ~ ] = eigs(L_norm,nClusters);
  
    %normalizing eigenvector
    for m = 1:bands
        v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
    end

    %applying k-means
    [~,CENTERS(:,:,i),~,~]=kmeans(v_norm,nClusters);
    
  end
  init = zeros(nClusters,nClusters);
  for i=1:30
      init = init + CENTERS(:,:,i);
  end
  init = init/30;

end
