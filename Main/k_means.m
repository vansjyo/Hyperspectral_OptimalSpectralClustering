%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program For K-Means Clustering (Vector Quantization)               %
% Program Written By Sharad K. Gupta                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mu,sigma,pi_k,assgn_cluster]=k_means(X,clusters)
data=X;
no_clust=clusters;
[no_rows, no_columns]=size(data);
assgn_cluster=zeros(no_rows,1);
randpts = floor(1+(no_rows-1)*rand(no_clust,1));
mu = data(randpts,:);
rank=zeros(no_rows,1,no_clust);
d=zeros(no_clust,1);
pi_k=zeros(no_clust,1);
iteration=0;

while(iteration<100)
    pts_c=zeros(no_clust,1);
    xn=zeros(1,no_columns,no_clust);
    for j=1:no_rows
        xydata=data(j,:);
        for k=1:no_clust
            d(k)=distxmu(xydata,mu(k,:));
        end
        dist=min(d);
        for k=1:no_clust
            if dist==d(k)
                assgn_cluster(j)=k;
                pts_c(k)=pts_c(k)+1;
                rank(j,:,k)=1; 
            end
        end
    end
    combined=[data assgn_cluster];
    for i=1:no_rows
        for k=1:no_clust
            if combined(i,no_columns+1)==k
                xn(:,:,k)=xn(:,:,k)+combined(i,1:no_columns);
            end
        end
    end
   % muold=mu;
    for k=1:no_clust
        mu(k,:)=xn(:,:,k)./pts_c(k);
        pi_k(k)=pts_c(k)/sum(pts_c);
    end
    iteration=iteration+1;
%     if mu==muold
%         break;
%     elseif abs(sum(mu-muold))<=10^-6
%         break;
%     end

%     for k=1:no_clust
%         plot3(mu(k,1),mu(k,2), mu(k,3),'kx');
%     end
%     hold on;
end

sigma=zeros(no_columns,no_columns,no_clust);
for k=1:no_clust
    idtmp = find(assgn_cluster==k);
    sigma(:,:,k) = cov(data(idtmp,:));
end
% plot3(X(:,1),X(:,2),X(:,3),'.')
x = X(:,1);
y = X(:,2);
z = X(:,3);
figure, scatter3(x,y,z,assgn_cluster);
hold on
for s=1:clusters
scatter3(data(find(assgn_cluster==s),1),data(find(assgn_cluster==s),2),data(find(assgn_cluster==s),3));
hold on;
end
figure, plot(x,y,'.')
end
