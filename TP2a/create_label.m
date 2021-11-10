function T=create_label()
    T=zeros(10,500)
    for i = 1:500 
        index = mod(i,10);
        if index==0
            index=10;
        end
        T(index,i)=1;
    end