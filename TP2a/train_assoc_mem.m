function Wp = train_assoc_mem(P)
% P 256,500
% T 256,500

perfect_numbers = load('PerfectArial.mat');
current_perfect_number = cell2mat(struct2cell(perfect_numbers));

disp(size(perfect_numbers));
T = repmat(current_perfect_number,1,50);

pinvP = pinv(P);
Wp = T * pinvP;
% wp [256,256]

end