function features = extract_image_features(image)
    features = zeros(1,9);
    for i = 1:3
        layer = image(:,:,i);
        filtered = layer(layer>30);
        features(i) = mean(filtered);
        features(i+3) = entropy(filtered);
    end
    
    %green-red
    features(7) = abs(features(2) - features(1));
    
    %red-blue
    features(8) = abs(features(1) - features(3));
    
    %green-blue
    features(9) = abs(features(2) - features(3));
end