function avgs = extract_averages()

    avgs = zeros(6,9);
    
    for i = 1:6
        means = mean(extract_image_features(i));
        avgs(i,:) = means;
    end
end