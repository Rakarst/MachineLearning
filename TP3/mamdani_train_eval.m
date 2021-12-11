function mamdani = mamdani_train_eval(X,y)

    mamdani = mamfis;
    
    for i = 1:3
        mamdani = addInput(mamdani, [0,255], 'NumMFs',3,'MFType','gaussmf');
    end
    
    for i = 1:3
        mamdani = addInput(mamdani, [0,10], 'NumMFs',3,'MFType','trimf');
    end
    
    for i = 1:3
        mamdani = addInput(mamdani, [0,255], 'NumMFs',3,'MFType','gaussmf');
    end
    
    mamdani = addOutput(mamdani, [0,6], 'Name','class','NumMFs', 6);
    mamdani.DefuzzificationMethod = 'bisector';
    
    options = tunefisOptions('Method','particleswarm','OptimizationType','learning','NumMaxRules', 25);
    options.MethodOptions.MaxIterations = 20;
    
    mamdani = tunefis(mamdani,[],X,y,options); 
    plotfis(mamdani)

end