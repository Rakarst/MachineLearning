function lstm_net = create_train_lstm(X_train,y_train)

    [X,y] = lstm_prep(X_train,y_train);

    numFeatures = 29;
    numHiddenUnits = 100;
    numClasses = 3;

    maxEpochs = 50;
    
    mini_batch_size = 29;
    
    layers = [
        sequenceInputLayer(numFeatures)
        lstmLayer(numHiddenUnits,'OutputMode','last')
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer
    ];

    options = trainingOptions('adam','ExecutionEnvironment','cpu','GradientThreshold',1,'MaxEpochs',maxEpochs,'MiniBatchSize',mini_batch_size,'SequenceLength','longest','Shuffle','never','Verbose',0,'Plots','training-progress');

    lstm_net = trainNetwork(X',y',layers,options);
end