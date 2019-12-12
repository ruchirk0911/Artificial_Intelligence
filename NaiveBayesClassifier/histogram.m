function histogram( training_file,test_file,N )
    train_data = dlmread(training_file);
    [~,col] = size(train_data);
    test_data = dlmread(test_file);
    [row1,col1] = size(test_data);
    last_col= train_data(:, col);
    groups = unique(last_col);
    bin_probab= randn(numel(groups),col-1,N);
    bin_min_range= randn(numel(groups),col-1,N);
    bin_max_range= randn(numel(groups),col-1,N);
    result= randn(row1,5);
    test_n = randn(row1,col-1);
    class_repeatation = histc(last_col ,groups);
    lastcol_size=size(last_col);
    class_probab = rdivide(class_repeatation,max(lastcol_size));
    %training phase%
    for i = 1:numel(groups)
        index = train_data(:,col) == groups(i);
        for j = 1:col-1
           temp = train_data(index,j);
           L = max(train_data(index,j));
           S = min(train_data(index,j));
           G = (L-S)/(N-3);
           if G < 0.0001
               G = 0.0001;
           end
           range_min = -inf;
           range_max = S-G/2;
           
           for k= 1:N
               bin_count=0;
               for m = 1: size(train_data(index,j),1)
                    if(temp(m,1) >= range_min && temp(m,1) < range_max)
                        bin_count= bin_count+1;
                    end
               end
               bin_min_range(i,j,k)= range_min;
               bin_max_range(i,j,k)= range_max;
               range_min = range_max;
               if k == N-1
                 range_max =  inf;
               else
                 range_max = range_max + G;
               end
               bin_probab(i,j,k)= bin_count/(size(train_data(index,j),1)*G);
               fprintf('Class %d, attribute %d, bin %d, P(bin | class) = %.2f\n',groups(i),j,k-1, bin_probab(i,j,k));
           end
        end
        fprintf('\n');
    end
    %testing phase%
    probab = randn(row1,numel(groups));
    for i= 1: row1
        for j= 1: numel(groups)
            probl= 1;
            for k = 1: col-1
                bin_chosen = 0;
                for m= 1: N
                    if( test_data(i,k) >= bin_min_range(j,k,m)&& test_data(i,k) < bin_max_range(j,k,m))
                        bin_chosen = m;
                        test_n(j,k)= bin_probab(j,k,bin_chosen);
                        probl= probl * test_n(j,k);
                    end
                    
                end 
            end
            probab(i,j)= probl*class_probab(j);
        end
        probsum = sum(probab(i,:));
        for j = 1:numel(groups)
            if probsum == 0
                probab(i,j) = 1/ numel(groups);
            else
                probab(i,j) = probab(i,j)/probsum;
            end
        end
        actual_val = test_data(i,col1);
        class_details = Acc(probab(i,:),groups,actual_val);
        result(i,1)= i-1;
        result(i,2)= class_details(2);
        result(i,3)= class_details(3);
        result(i,4)= actual_val;
        result(i,5)= class_details(1);
    end
    classification_accuracy(result);
end

