function indices = find_changes_in_signal(y)
    indices = []
    for ind = 2:length(y)
        prew_row = y(:,ind-1);
        row = y(:,ind);
        if (prew_row(1) == 1 && row(2) == 1) || (prew_row(3) == 1 && row(1) == 1)
            indices(end+1) = ind
        end
    end
    odd = indices(:,1:2:end);
    even = indices(:,2:2:end);
    indices = [odd',even'];
end