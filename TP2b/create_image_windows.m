function [X,y] = create_image_windows(X,y)
    
    data_length = (size(X(:,1)));
    %data_length = length(1);
    
    data_X = cell(1,3);
    data_y = cell(1,3);
    
    for i = 1:data_length
        y_row = y(i,:);
        [~,idx] = max(y_row);
        data_X{idx} = [data_X{idx} ; X(i,:)];
        data_y{idx} = [data_y{idx} ; y(i,:)];
    end
    
    windows_X = cell(0,1);
    windows_y = cell(0,1);
    
    window_size = 29;
    for i = 1:3
       matrix = data_X{i};
       m_length = length(matrix);
       ind = 0;
       
       y_temp = [0,0,0];
       y_temp(i) = 1;
       for j = 1:window_size:m_length-mod(m_length,window_size)
           window = matrix(j:j+window_size-1,:);
           windows_X{ind+1} = window;
           
           windows_y{ind+1} = y_temp;
           
           ind = ind + 1;
       end
       disp(size(matrix));
    end
    
    X = cat(4, windows_X{:});
    y_temp = vertcat(windows_y{:});
    
    y = zeros(length(y_temp),1);
    
    for i = 1:size(y_temp)
        y(i) = find(y_temp(i,:) == 1);
    end
    
    y = categorical(y);
end