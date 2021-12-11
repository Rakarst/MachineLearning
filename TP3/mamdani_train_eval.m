function mamdani = mamdani_train_eval(X,y)
    X= X(:,1:3);
    mamdani = mamfis;
    mamdani = addInput(mamdani, [0,255], 'NumMFs',2,'Name',"Red",'MFType',"trimf");
    mamdani = addInput(mamdani, [0,255], 'NumMFs',6,'Name',"Green",'MFType',"trimf");
    mamdani = addInput(mamdani, [0,255], 'NumMFs',2,'Name',"Blue",'MFType',"trimf");
    
    
    mamdani = addOutput(mamdani, [0,6], 'Name','class','NumMFs', 6);
    mamdani.DefuzzificationMethod = 'centroid';
    
    options = tunefisOptions('Method','ga','OptimizationType','learning','NumMaxRules', 25);
    options.ValidationTolerance = 0.02;
    %options.FunctionTolerance = 0.02;
    %options.MethodOptions.MaxIterations = 20;
    %options.MethodOptions.UseCompletePoll = true;
    mamdani = tunefis(mamdani,[],X,y,options); 
    plotfis(mamdani)

end