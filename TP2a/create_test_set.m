function all_numbers = create_test_set()

all_numbers = [];

for i = 1:10
    filename = sprintf('numbers/data%i.mat', i)
    matrix_struct = load(filename);
    matrix = cell2mat(struct2cell(matrix_struct));
    all_numbers = horzcat(all_numbers,matrix);
end
all_numbers;
end