
function net=myclassify(fActivation)
    net = network(1,1);
    net.trainFcn='trainc';
    % binary
    if fActivation==0
        net.layers{1}.transferFcn = 'hardlim';
    elseif fActivation==1
    % linear
        net.layers{1}.transferFcn = 'purelin';
    % sigmoidal
    else 
        net.layers{1}.transferFcn = 'logsig';
    end
end

