function gaussian(training_file,test_file)
train_data = dlmread(training_file);
    [~,col] = size(train_data);
    test_data = dlmread(test_file);
    [row1,col1] = size(test_data);
    last_col= train_data(:, col);
    
    groups = unique(last_col);
    dist_n = randn(numel(groups),col-1,2);
    result= randn(row1,5);
        
    class_repeatation = histc(last_col ,groups);
    lastcol_size=size(last_col);
    class_probab = rdivide(class_repeatation,max(lastcol_size));    
    %training phase%
    for i = 1:numel(groups)
        index = train_data(:,col) == groups(i);
        for j = 1:col-1
            fprintf('Class %d, \t', groups(i));
            fprintf('dimension %d, \t', j-1);
            col_mean= mean(train_data(index,j));
            fprintf('mean = %.2f, \t',col_mean);
            standard_deviation = std(train_data(index,j));
            if(standard_deviation < 0.01)
                standard_deviation = 0.01;
            end
            fprintf('std= %.2f \n',standard_deviation);
            dist_n(i,j,1)= col_mean;
            dist_n(i,j,2)= standard_deviation;
        end
        fprintf('\n');
    end
    %testing phase%
        test_n = randn(row1,col-1);
        probab = randn(row1,numel(groups));
         for k = 1:row1
            for i = 1:numel(groups)
                probl = 1;
                for j = 1:col-1
                    test_n(i,j)= normpdf(test_data(k,j),dist_n(i,j,1),dist_n(i,j,2));
                    probl= probl * test_n(i,j);
                end
                probab(k,i)= probl*class_probab(i);
            end
            probsum = sum(probab(k,:));
            for i = 1:numel(groups)
                probab(k,i) = probab(k,i)/probsum;
            end
            actual_val = test_data(k,col1);
            class_details = Acc(probab(k,:),groups,actual_val);
            result(k,1)= k-1;
            result(k,2)= class_details(2);
            result(k,3)= class_details(3);
            result(k,4)= actual_val;
            result(k,5)= class_details(1);
         end
         classification_accuracy(result);
end

