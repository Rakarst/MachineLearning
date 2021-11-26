function cnn_predict(cnn_net, X_test, y_test)

    pred_Y = predict(cnn_net,X_test,'ExecutionEnvironment','cpu');
    [~,pred_Y] = max(pred_Y');
    pred_Y = categorical(pred_Y);
    conf_mat = confusionmat(y_test, pred_Y);
    conf_mat = bsxfun(@rdivide,conf_mat,sum(conf_mat,2))
end