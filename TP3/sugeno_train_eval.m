function fis= sugeno_train_eval(X,y)
    X= X(:,1:3);
    fis = sugfis("AndMethod","min","OrMethod","max");
    fis = addInput(fis, [0,255], 'NumMFs',2,'Name',"Red",'MFType',"trimf");
    fis = addInput(fis, [0,255], 'NumMFs',6,'Name',"Green",'MFType',"trimf");
    fis = addInput(fis, [0,255], 'NumMFs',2,'Name',"Blue",'MFType',"trimf");
    fis = addOutput(fis, [0,6], 'Name','class','NumMFs', 6);
    fis.DefuzzificationMethod = "wtsum";
    
    options = tunefisOptions('Method','ga','OptimizationType','learning','NumMaxRules', 9);
    options.ValidationTolerance = 0.002;
    %options.MaxGeneration = 10;
    %options.FunctionTolerance = 0.02;
    %options.MethodOptions.MaxIterations = 20;
    %options.MethodOptions.UseCompletePoll = true;
    fis = tunefis(fis,[],X,y,options); 
    plotfis(fis)
    
end

