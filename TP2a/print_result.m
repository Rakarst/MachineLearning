function print_result()

  ocr.labels='1234567890';
  load('P.mat','P');
  load('filter.mat','filter_use')
  load('tranfer.mat','tranfer_use')
  switch filter_use
      case 'None'
      case 'Perceptron'
          load('percp.mat',"percep");
          P = use_perceptron(P,percep);
      case 'Associative Memory'
          load('Wp.mat','Wp');
          P=assoc_m(P,Wp);
  end
  
  switch tranfer_use
      case 'hardlim'
          load('netwhardlim.mat','netw');
      case 'purelin'
          load('netwpurelin.mat','netw');
      case 'logsig'
          load('netwlogsig.mat','netw');
  end
  a = sim(netw,P);
  
  
  final = zeros(1,50);
  

    for i = 1:50
        y=1;
        current = a(:,i);
        if tranfer_use == 'hardlim'
            while a(y,i) ~=0
                y=y+1;
            end
            if sum(P(:,i))==0
                y=-1;
            end
            final(:,i)=y;
        else
        
        [index,j]=find(current==max(current));
        if index==10
            index=0;
        end
        if sum(P(:,i))==0
            index=-1;
        end
        final(:,i)=index;
        end
    end
    figure(2);
    axis equal;
    axis([0 1 0 0.5]);
    hold on;
    plot( [ 0 0 1 1 0 ], [ 0 .5 .5 0 0 ] );
    for i = 1:9, plot( [i/10 i/10],[0 .5] ); end
    for i = 1:4, plot( [0 1],[i/10 i/10] );  end
    
    %--------------------------- display recognized numerals
    for i=1:5
        for j = 1:10
            inx = j+(i-1)*10;
            if final(:,inx) ~= -1
                character = num2str(final(:,inx)); 
                
                h=text(0.05+(j-1)/10,-0.05+(5-i+1)/10,character);
                set(h,'fontsize',25,'VerticalAlignment','middle',...
                    'HorizontalAlignment','center');
            end
        end
    end
  
end

