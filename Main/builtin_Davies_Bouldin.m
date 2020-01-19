function [ davies_values ] = builtin_Davies_Bouldin( L_norm )

    bands = size(L_norm,1);
    davies_values = zeros(30,1);
    for i=1:30
%         v_norm = zeros(bands,bands);
        [vk,~] = eigs(L_norm,bands);
%         for m = 1:bands
%             v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
%         end
        eva = evalclusters(vk,'kmeans','DaviesBouldin','KList',i);
        davies_values(i,1) = eva.CriterionValues;
    end
    figure;
    plot(davies_values,'-x');
    title('Davies Bouldin Index PLOT');


end
