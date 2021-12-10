function value_with_target = create_target(classNumber)
    value_without_target = extract_image_features(classNumber);
    target = zeros(length(value_without_target),1)+classNumber;
    value_with_target = [value_without_target,target];
    %disp(value_with_target);
end

