function [X,y] = lstm_prep(X,y)

    reshaped_target = zeros(1,length(y));
    
    for i = 1:length(y)
        [~,idx] = max((y(i,:)));
        reshaped_target(i) = idx;
    end
    
    X_train = num2cell(X',1);
    reshaped_target = categorical(reshaped_target);
    
    X = X_train;
    y = reshaped_target;
end