function [X_train,y_train,X_test,y_test] = create_train_test_set()

    X_train = zeros(0,9);
    y_train = zeros(0,1);
    X_test = zeros(0,9);
    y_test = zeros(0,1);
    for i = 1:6
        features = extract_image_features(i);
        
        sz = size(features);
        width = sz(1);
        
        train_size = floor(width * 0.7);
        test_size = width - train_size;
        
        X_train = [X_train,(features(1:train_size,:))'];
        X_test = [X_test,(features(train_size:width,:))'];
        
        y_train = [y_train,ones(1,train_size)*i];
        y_test = [y_test,ones(1,test_size+1)*i];
    end
    X_train = X_train';
    y_train = y_train';
    
    X_test = X_test';
    y_test = y_test';
end