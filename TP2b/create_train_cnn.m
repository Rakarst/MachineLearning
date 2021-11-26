function cnn_net = create_train_cnn(X_train,y_train)

    number_of_classes = 3;
    input_size = [29 29 1];
    
    layers = [
        imageInputLayer(input_size)
        convolution2dLayer(5,20)
        reluLayer
        
        maxPooling2dLayer(2,'Stride',2)
        
        convolution2dLayer(3,32,'Padding',1)
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(3,64,'Padding',1)
        batchNormalizationLayer
        
        reluLayer
        fullyConnectedLayer(32)
        reluLayer
        
        fullyConnectedLayer(number_of_classes)
        
        softmaxLayer
        classificationLayer
    ];

    options = trainingOptions('sgdm','MaxEpochs',100,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
    rng(42);
    
    cnn_net = trainNetwork(X_train,y_train, layers, options);

end