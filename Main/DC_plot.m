%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Program For Spectral Clustering                        %
%                Written By Vanshika Gupta                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ DC_value, DC_logvalue, DC_value1, DC_logvalue1 ] = DC_plot(bands, v1, lambda_vector1 , v , lambda_vector )

 n1 = ones(1,bands)/bands;

%preallocatig memory  for sorted DC_graph
    factor = zeros(bands,1);
    DC_value = zeros(bands,1);
    DC_logvalue = zeros(bands,1);

%preallocating memory for unsorted DC_graph
    factor1 = zeros(bands,1);
    DC_value1 = zeros(bands,1);
    DC_logvalue1 = zeros(bands,1);

%computing the DC values
    for i=1:bands

      %sorted
      factor(i,1) = n1*v(:,i);  
      DC_value(i,1) = lambda_vector(i,1)*(factor(i,1)^2);
      DC_logvalue(i,1) = log(lambda_vector(i,1)*(factor(i,1)^2));

      %unsorted
      factor1(i,1) = n1*v1(:,i);  
      DC_value1(i,1) = lambda_vector1(i,1)*(factor1(i,1)^2);
      DC_logvalue1(i,1) = log(lambda_vector1(i,1)*(factor1(i,1)^2));

    end

figure;
    bar(DC_value*100/sum(DC_value));%set(gca,'yscale','log');
    title('Bar DCvalue percentage contribution after sorting eigenvalues');
    legend('DCvalue*100/sum(DCvalue)');
    xlabel('Band Number');
    ylabel('DC value');

figure
    a = smooth(DC_logvalue,3);
    semilogy(a);
    xlabel('band number');
    ylabel('DC logvalue');
    legend('DC logvalue');
    title('semilogY DC logvalue plot with size 3 filter after sorting eigenvalues');

figure;
    bar(DC_value1*100/sum(DC_value1));%,set(gca,'yscale','log');
    title('Bar DCvalue percentage contribution');
    legend('DCvalue*100/sum(DCvalue) without sorting eigenvalues');
    xlabel('Band Number');
    ylabel('DC value');

figure
    b = smooth(DC_logvalue1,3);
    semilogy(b);
    xlabel('band number');
    ylabel('DC logvalue');
    legend('DC logvalue');
    title('semilogY DC logvalue plot with size 3 filter without sorting eigevalues');

end
