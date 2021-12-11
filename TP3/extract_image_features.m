function features = extract_image_features(class_number)

    path = strcat("Class ", num2str(class_number));
    files = dir(fullfile(path, '*.jpg'));
    
    number_of_files = length(files);

    features = zeros(number_of_files,9);
    
    for i = 1:number_of_files
        file_name = fullfile(path, files(i).name);
        for j = 1:3
            image = imread(file_name);
            layer = image(:,:,j);
            filtered = layer(layer>30);
            features(i,j) = mean(filtered);
            features(i,j+3) = entropy(filtered);
        end
        
        %green-red
        features(i,7) = abs(features(i,2) - features(i,1));
    
        %red-blue
        features(i,8) = abs(features(i,1) - features(i,3));
    
        %green-blue
        features(i,9) = abs(features(i,2) - features(i,3));
    end
    
end