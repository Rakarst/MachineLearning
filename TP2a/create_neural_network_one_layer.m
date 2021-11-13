function netw = create_neural_network_one_layer()
    netw = feedforwardnet;
    
    netw.numInputs = 1;
    netw.numLayers = 1;
    netw.biasConnect = 1;
    netw.inputConnect = 1;
    netw.outputConnect = 1;
    
    netw.layers{1}.transferFcn = 'logsig';
    rng(0);
    W = rand(10,0);
    b = rand(10,1);
    
    netw.IW{1,1} = W;
    netw.b{1,1} = b;