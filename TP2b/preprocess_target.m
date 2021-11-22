function processed_target = preprocess_target(y)
    y = y';
    preictal_size = 900; % 15min = 900 seconds
    temporary_y = y;
    
    indices_of_ones = find(y);
    for index = indices_of_ones
        temporary_y((index - preictal_size):index) = 1;
    end
    
    y = y + temporary_y + 1;
    
    processed_target = zeros(3, length(y));
    
    for i = 1:length(processed_target)
        processed_target(y(i),i) = 1;
    end