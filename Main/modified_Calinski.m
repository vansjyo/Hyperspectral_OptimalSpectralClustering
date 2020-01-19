%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [ modified_Calinski_index ] = modified_Calinski( L_norm )
%PLOTTING DC PLOT, MODIFIED CALINSKI AND SILHOUETTE FOR AFFINITY MATRIX 

%preallocating memory for constants in index
    within_Sum = zeros(30,1);
    between_Sum = zeros(30,1);
    modified_Calinski_index = zeros(30,1);
    bands = size(L_norm,1);
 
%indices
    for nClusters=1:30
        %preallocating memory for v_norm
        v_norm = zeros(bands,nClusters);

        %finding eigenvectors corresponding to k largest eigenvectors
        %[vk,~] = eigs(L_norm ,nClusters,'lm');
        [vk,~] = eig(L_norm);
        
        %normalizing eigenvector
        %for m = 1:bands
        %   v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
        %end

        %applying k-means
        [IDX,~,sumd,dist]=kmeans(vk,nClusters);

        %column vecor with number of points in respective cluster
        count = zeros(nClusters,1);
        for p = 2:nClusters
          count(p,1) = size(find(IDX(:)==p),1);
        end

        %calculating within-cluster-sum-of-squares
        within_Sum(nClusters,1) = sum(sumd);

        %calculating between-cluster-sum-of-squares
        between_Sum(nClusters,1) = sum(sum(dist') - (min(dist')));
        
        %finding the modified calinski index
        modified_Calinski_index(nClusters,1) = (between_Sum(nClusters,1)/(nClusters-1))/(within_Sum(nClusters,1));

    end

%plot the calinski index
  figure;
  plot(modified_Calinski_index,'-o');
  title('modified calinski index');
  
  
end
  

 
  
 
 
