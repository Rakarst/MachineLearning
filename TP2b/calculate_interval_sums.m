function sums = calculate_interval_sums(intervals)
    sums = 0;

    for i = 1:length(intervals)
        row = intervals(i,:);
        sums = sums + (row(2) - row(1));
    end
end

