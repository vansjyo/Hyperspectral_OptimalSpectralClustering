function[ rep_bands ] = find_repbands(dist)   

[~,index] = sort(dist);

rep_bands = index(1,:);

end