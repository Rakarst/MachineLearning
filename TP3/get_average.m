function [red,green,blue] = get_average(Img)
    figure;
    imshow(Img);
    for i = 1:3
    layer = Img(:,:,i);
    disp(mean(layer(layer>0)));

    end
  
end

