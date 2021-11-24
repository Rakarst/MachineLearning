function network = train_neural_network_one_layer(net, X, y)
    network = configure(net, X, y);
    network.trainFcn = 'trainbr';
    network.performParam.lr = 0.5;
    network.trainParam.epochs = 100;
    network.trainParam.goal = 1e-6;
    network.performFcn = 'sse';
    network.trainParam.show = 35;
    network = train(network, X, y);