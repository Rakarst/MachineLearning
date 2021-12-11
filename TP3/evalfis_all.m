function evalfis_all(fis)
    result_target = [];
    result_label = [];
    for i = 1:6
        matrix = extract_image_features(i);
        target = zeros(length(matrix),1);
        label = zeros(length(matrix),1)+i;
        for j = 1:length(matrix)
         target(j,1) = round(evalfis(fis,[matrix(j,1),matrix(j,2),matrix(j,3)]));
        end
        %matrix_result = [matrix,target];
        result_target = [result_target;target];
        result_label = [result_label;label];
        disp(sum(target == i)/length(target));
        
    end
    figure;
    confusionchart(result_label,result_target);
    %disp(target);
    %pred = categorical(matrix_result(:,10));
    %disp(pred);
    %plotconfusion(matrix_result(:,10),zeros(length(matrix),1)+1);
end