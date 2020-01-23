%PLOTTING DC PLOT, PREDEFINED CALINSKI AND SILHOUETTE FOR SPARSE AFFINITY MATRIX 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Sparse Spectral Clustering                    %
%          Written By Vanshika Gupta, Sharad Kumar Gupta                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%fetchig data
    % z = paviaU;
    z = indian_pines_corrected;
    [rows,cols,bands] = size(z);
    %file_path='subset_rfl(spectral).tif';
    %[z,info]= rasterread(file_path);%bands = 372;

n = bands;
%indicate number of clusters
k = 20;

% Preallocate memory
    indi = zeros(1, k * n);
    indj = zeros(1, k * n);
    inds = zeros(1, k * n);

%euclidean/other distance matrix
    euclid_sim = euclidean_pines;

%k-nearest neighbour sparse matrix
for ii = 1:n
    % Compute i-th column of distance matrix
    dist = euclid_sim(:,ii);
    
    % Sort row by distance (order = "ascend" if similarity used instead of distance) 
    [s, O] = sort(dist, 'descend');
    
    % Save indices and value of the k 
    indi(1, (ii-1)*k+1:ii*k) = ii;
    indj(1, (ii-1)*k+1:ii*k) = O(1:k);
    inds(1, (ii-1)*k+1:ii*k) = s(1:k);
end

% Create sparse matrix
    W = sparse(indi, indj, inds, n, n);

% Mutual k-nearest neighbours
    W = min(W, W');
    
% Gaussian similarity function for obtaining similarity matrix if distance metric used, else comment it.
% ******sigma has been set by analysing data range/ equal to standard deviation********
W = spfun(@(W) (simGaussian(W,50000)), W);
    

%finding the degree matrix
    weight = full(W);
    degree_v = sum(weight)';
    %check to assign minimum double number to any zeroes in degree matrix
    degree_v(degree_v == 0) = eps;
    degree   = sparse(1:size(W, 1), 1:size(W, 2), degree_v);    
    
%computing unmormalized laplacian
    L = degree - weight;

%calculating normalized laplacian
    p=-0.5;
    degree = full(degree);
    L_norm = (degree^p)*L*(degree^p);
    
%sorted descending eigenvalues
    [v, lambda] = eigs(L_norm ,bands,'lm');
    lambda_vector = diag(lambda);

%unsorted eigenvector and values
    [v1,lambda1] = eig(L_norm);
    lambda_vector1 = diag(lambda1);

%%computing the DC (Distribution compactness) values
[DC_value, DC_logvalue, DC_value1, DC_logvalue1] = DC_plot(bands, v1, lambda_vector1 , v , lambda_vector );

nClusters=17;

%Calculatigng average centroid
init = mean30( nClusters , bands ,L_norm );

%average silhouette plot
meanSilhouette(bands, L_norm);
 
%calinski index plot
eva = evalclusters(v,'kmeans','CalinskiHarabasz','KList',(2:30));
figure;
plot(eva);
title('calisnki plot using klist');

%calinski_inbuilt plot
[ eva_values ] = builtin_Calinski( L_norm );

%davis plot
[ davies_values ] = builtin_Davies_Bouldin( L_norm );

%GAP plot
% [ gap_values ] = builtin_Gap( L_norm );

%WSS plot(elbow method)
a = zeros(30,1);
for i=2:30
[calinski_index,TSS_sum,WGSS,BGSS,DG] = Calinski( i , L_norm );
a(i,1) = calinski_index;
end
figure;plot(a,'-x');title('my calisnki plot');xlim([2,30]);

%silhoeutte
[IDX,CENTER,sumd,dist,vk] = clusterSilhouette(L_norm, nClusters ,init );

%count of number of points in each cluster
count = zeros(nClusters,1);
for p = 1:nClusters
  count(p,1) = size(find(IDX(:)==p),1);
end

%dunn index plot
dunn=ones(30,1);
for i=3:30
[index,~,~,~]=kmeans(v,i);
dunn(i,1) = Dunn_index(i,v,index);
end
figure;plot(dunn);title('Dunns Index');

%WSSplot(elbow method)
 [ WSS ] = WSS_Plot(L_norm);


%finding the represenative bands from the clusters
[ rep_bands ] = find_repbands(dist);

%find final bands in terms of original data without removal of bad bands %and resp wavelengths
[ final_bands,final_wavelengths ] = final_bands(rep_bands);

% %calculating average inter-cluster-distance for nClusters
% intercluster_dist = sumd./count;
% figure;
% plot(intercluster_dist,'-x');
% title('plotting inter-cluster average distance for nClusters');

% %modified calisnki plot
[ modified_Calinski_index ] = modified_Calinski( L_norm );


