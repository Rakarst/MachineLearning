function keep = check_if_index_should_keep(index,indices)
    keep = true;
    for i = 1:length(indices)
        row = indices(i,:);
        if index > row(1) && index < row(2)
            keep = false;
            return
        end
    end
    