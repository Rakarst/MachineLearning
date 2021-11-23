function [X_train, y_train, X_test, y_test] = train_test_split(X,y,test_ratio)
    indices_to_split = find_changes_in_signal(y);
    
    length_of_all_seizures = calculate_interval_sums(indices_to_split);
    %length_of_calm_state = max(size(y)) - length_of_all_seizures;
    
    indices_to_split = indices_to_split(randperm(size(indices_to_split,1)),:);
    size_of_indices = length(indices_to_split(:,1));
    test_seizure_size = round(size_of_indices * test_ratio);
    train_seizure_size = size_of_indices - test_seizure_size;
    
    y = y';
    training_seizures = cell(0, 1);
    train_seizures_target = cell(0, 1);
    
    test_seizures = cell(0, 1);
    test_seizures_target = cell(0, 1);
    
    for i = 1:train_seizure_size % seizures for training set
        indice_row = indices_to_split(i,:);
        start_index = indice_row(1);
        end_index = indice_row(2);
        X_slice = X(start_index:end_index,:);
        y_slice = y(start_index:end_index,:);
        training_seizures{end + 1} = X_slice;
        train_seizures_target{end + 1} = y_slice;
    end
     
    for i = (train_seizure_size+1):(train_seizure_size + test_seizure_size)
        indice_row = indices_to_split(i,:);
        start_index = indice_row(1);
        end_index = indice_row(2);
        X_slice = X(start_index:end_index,:);
        y_slice = y(start_index:end_index,:);
        test_seizures{end + 1} = X_slice;
        test_seizures_target{end + 1} = y_slice;
    end
    
    training_seizures = cell2mat(training_seizures');
    train_seizures_target = cell2mat(train_seizures_target');
    test_seizures = cell2mat(test_seizures');
    test_seizures_target = cell2mat(test_seizures_target');
    
    X_temp = cell(0, 1);
    for i = 1:length(X(:,1))
        if check_if_index_should_keep(i,indices_to_split)
            X_temp{end + 1} = X(i,:);
        end
    end
    X_temp = cell2mat(X_temp');
    
    X_temp = X_temp(randperm(size(X_temp,1)),:);
    X_temp = X_temp(1:length_of_all_seizures,:);
    
    train_length = length(training_seizures(:,1));
    %test_length = length(test_seizures(:,1));
 
    training_seizures = [training_seizures' X_temp(1:train_length,:)']';
    test_seizures = [test_seizures' X_temp(train_length:end,:)']';
    %disp(size(training_seizures));
    train_seizures_target = [train_seizures_target' repmat([1 0 0],train_length,1)']';
    test_seizures_target = [test_seizures_target' repmat([1 0 0],(length(test_seizures) - length(test_seizures_target)),1)']';
    
    
    %disp(size(test_seizures));
    X_train = training_seizures;
    X_test = test_seizures;
    y_train = train_seizures_target;
    y_test = test_seizures_target;