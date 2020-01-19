%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ L_norm,degree ] = simLaplace( W )

%degree matrix
D = sum(W);
degree = diag(D);
%unnormalized laplacian
L = degree - W;

%normalized laplacian
p = -0.5;
Deg = diag(D.^-0.5);

L_norm = (degree^p)*L*(degree^p);

end
