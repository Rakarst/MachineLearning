function percept = train_perceptron(X)

    perfect_numbers = load('PerfectArial.mat');
    current_perfect_number = cell2mat(struct2cell(perfect_numbers));

    disp(size(perfect_numbers));
    y = repmat(current_perfect_number,1,50);
    percept = perceptron;
    percept = train(percept, X, y);
end