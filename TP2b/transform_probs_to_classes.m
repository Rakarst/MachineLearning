function y_pred = transform_probs_to_classes(y_pred_old)
    [~,idx] = max(y_pred_old);
    y_pred = zeros(3, length(y_pred_old));
    for i = 1:length(y_pred_old)
        y_pred(idx(i),i) = 1;
    end
    y_pred = y_pred';