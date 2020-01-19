function [ eva_values ] = builtin_Calinski( L_norm )

bands = size(L_norm,1);
eva_values = ones(30,1);
for i=2:30
%     v_norm = zeros(bands,bands);
    [vk,~] = eigs(L_norm,bands);
%     for m = 1:bands
%         v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
%     end
    eva = evalclusters(vk,'kmeans','CalinskiHarabasz','KList',i);
    eva_values(i,1) = eva.CriterionValues;
end
eva_values = (eva_values - min(eva_values))/(max(eva_values) - min(eva_values));
figure;
plot(eva_values,'-x');
xlim([2,20]);
title('Calisnki Index PLOT');


end
