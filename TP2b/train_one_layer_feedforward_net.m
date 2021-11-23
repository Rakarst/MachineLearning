function feedf_net = train_one_layer_feedforward_net(X_train, y_train)
    feedf_net = feedforwardnet(140,'trainscg');
    feedf_net.layers{1}.transferFcn = 'logsig';
    feedf_net.layers{2}.transferFcn = 'softmax';
    feedf_net = train(feedf_net,X_train,y_train,'UseParallel','yes','UseGPU','yes');