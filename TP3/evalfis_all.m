function matrix_result = evalfis_all(Classnumber)
    for i = Classnumber
        matrix = extract_image_features(i);
        target = zeros(length(matrix),1);
        for j = 1:length(matrix)
         target(j,1) = evalfis(readfis("mamdani_predict.fis"),[matrix(j,1),matrix(j,2),matrix(j,3),matrix(j,4),matrix(j,5),matrix(j,6),matrix(j,7),matrix(j,8),matrix(j,9)]);
        end
        matrix_result = [matrix,target];
    end
    %pred = categorical(matrix_result(:,10));
    %disp(pred);
    %plotconfusion(matrix_result(:,10),zeros(length(matrix),1)+1);
end

