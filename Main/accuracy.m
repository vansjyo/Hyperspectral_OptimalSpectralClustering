%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load original ground truth
original_gt = indian_pines_gt;

%find all nonzero values
a=find(indian_pines_gt);

%declare a matrix of ones
b=ones(145,145);
%fill that matrix with zeros at position of all classes except background
b(a) = 0;
%extract background positions
background = find(b);
 
%load my groundtruth
clustered_my_gt = euclid_gt;

%make background positions zero in my image
my_gt(background) = 0;
clustered_my_gt(background) = 0;

my_idx = [1 2 3 4 5 6 15 7 8 9 10 11 12 13 16 14];
% alfalfa = 1;
% corn_notill = 2;
% corn_mintill = 3;
% corn = 4;
% grass_pasture = 5;
% grass_trees = 6;
% grass_pasture_mowed = 15;
% hay_windrowed = 7;
% oats = 8;
% soybean_notill = 9;
% soybean_mintill = 10;
% soybean_clean = 11;
% wheat = 12;
% woods = 13;
% buildings_Grass_Trees_Drives = 16;
% stone_Steel_Towers = 14;
new_my_gt = zeros(145,145);
new_clustered_my_gt = zeros(145,145);
for i=1:16
    k = find(my_gt == i);
    new_my_gt(k) = find(my_idx == i);
    
    m = find(clustered_my_gt == i);
    new_clustered_my_gt(m) = find(my_idx == i);
end

%enable this


%converting into vectors
original_gt_v = original_gt(:);
new_clustered_my_gt_v = clustered_my_gt(:);

%% Accuracy with band selection (SVM Classification)
[c_matrixp_bs,Result_bs]= confusion.getMatrix(original_gt(:),clustered_my_gt(:));

%% Accuracy with all bands (SVM Classification)
[c_matrixp,Result]= confusion.getMatrix(original_gt(:),my_gt(:));
