function [ Gap_values ] = builtin_Gap( L_norm )

bands = size(L_norm,1);
Gap_values = zeros(30,1);
for i=1:30
v_norm = zeros(bands,bands);
[vk,~] = eigs(L_norm,bands);
for m = 1:bands
    v_norm(m,:) = vk(m,:)./ sqrt(sum(vk(m,:).^2));
end
eva = evalclusters(vk,'kmeans','gap','KList',i);
Gap_values(i,1) = eva.CriterionValues;
end
figure;
plot(Gap_values,'-x');
title('Gap Index PLOT');


end
