%PLOTTING DC PLOT, PREDEFINED CALINSKI AND SILHOUETTE FOR SIMPLIFIED
%AFFINITY MATRIX(TANIMOTO/COSINE/PEARSON/HYBRID/SAM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%import hyperspectral data
z = paviaU;   % indian_pines_corrected;
[rows,cols,bands] = size(z);

%similarity weight matrix (uncomment if SID similarity used)
% SID_norm = (SID - min(min(SID)) )/ (max(max(SID)) - min(min(SID)));
% weight =  1 - SID_norm;

%indicate bands and import Similarity/Affinity matrix generated from Similarity codes
bands=212;
W = SimGraph;

%if(weight matrix == euclid) uncomment:
% W = simGaussian(W,100000);


%return the normalized laplacian
[L_norm,degree] = simLaplace(W);

%sorted descending eigenvalues
[v, lambda] = eigs(L_norm ,bands,'lm');
lambda_vector = diag(lambda);

%unsorted eigenvector and values
[v1,lambda1] = eig(L_norm);
lambda_vector1 = diag(lambda1);

%plot the DC_curve
DC_plot(bands, v1, lambda_vector1 , v , lambda_vector );

%computing mean centroid from 30 observations given max number of clusters to iterate for
nClusters=18; 
%if running 2nd time for same cluster consecutively => comment this:
init = mean30(nClusters , bands ,L_norm );

%computing mean silhouette plot
meanSilhouette(bands, L_norm);

%computing cluster-wise silhouette
clusterSilhouette(bands, L_norm, nClusters ,init );

%calinski index plot
eva_values = zeros(30,1);
eva = evalclusters(v,'kmeans','CalinskiHarabasz','KList',(1:30));
figure,
plot(eva);

for i=1:30
eva = evalclusters(v(:,1:i),'kmeans','CalinskiHarabasz','KList',i);
eva_values(i,1) = eva.CriterionValues;
end
figure,
plot(eva_values);

%Davies-Bouldin Index
davis_values = zeros(30,1);
for i=1:30
eva = evalclusters(v(:,1:i),'kmeans','DaviesBouldin','KList',i);
davis_values(i,1) = eva.CriterionValues;
end
figure,
plot(davis_values,'-x');

%Gap method plot
eva_gap = evalclusters(v,'kmeans','gap','KList',(1:30));
figure,
plot(eva_gap);
