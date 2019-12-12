function mixtures(training_file,test_file,N)
    train_data = dlmread(training_file);
    [~,col] = size(train_data);
    test_data = dlmread(test_file);
    [row1,col1] = size(test_data);
    last_col= train_data(:, col);
    groups = unique(last_col);
    result= randn(row1,5);
    dist_n = randn(numel(groups),col-1,N,3);
    class_repeatation = histc(last_col ,groups);
    lastcol_size=size(last_col);
    class_probab = rdivide(class_repeatation,max(lastcol_size));    
    %training phase%
    for i = 1: numel(groups)
        index = train_data(:,col) == groups(i);
        for j= 1:col-1
            S = min(train_data(index,j));
            L = max(train_data(index,j));
            G = (L - S)/N;
            em_input = randn(N,3);
            for k=1:N
                em_input(k,1)= S+ G*(k-1)+ G/2;
                em_input(k,2)=1;
                em_input(k,3)=1/N;
            end
            X= train_data(index,j);
            probab = randn(N,size(X,1));
            for itr = 1:50
                %E Step%
                for p = 1: size(X,1)
                    Pxj = 0;
                    for q= 1:N
                        probab(q,p) = normpdf(X(p,1),em_input(q,1),em_input(q,2))*em_input(q,3);
                        Pxj = Pxj + probab(q,p);
                    end
                    for q = 1:N
                        probab(q,p) = probab(q,p)/Pxj; 
                    end
                end
                %M Step%
                sum_Pij = zeros(N,1);
                for r = 1:N
                    sum_PijXj = 0;        
                    test = 0;
                    for p=1:size(X,1)
                        sum_PijXj = sum_PijXj + probab(r,p) * X(p,1);
                        sum_Pij(r,1) = sum_Pij(r,1) + probab(r,p); 
                        test = test + probab(r,p)*(X(p,1)-em_input(r,1))*(X(p,1)-em_input(r,1));
                    end  
                    em_input(r,1) = sum_PijXj/sum_Pij(r,1);
                    em_input(r,2) = sqrt(test/sum_Pij(r,1));
                    if em_input(r,2)<0.01
                        em_input(r,2) = 0.01;
                    end
                end
                sum_sumPij = sum(sum_Pij(:,1)); 
                for r= 1:N
                    em_input(r,3) = sum_Pij(r,1)/sum_sumPij;
                end
            end   
            res = em_input;   
            for k=1:N
                dist_n(i,j,k,1) = res(k,1);
                dist_n(i,j,k,2) = res(k,2);
                dist_n(i,j,k,3) = res(k,3);
                fprintf('Class %d, attribute %d, Gaussian %d, mean = %.2f ,std = %.2f\n',groups(i),j-1,k-1,dist_n(i,j,k,1),dist_n(i,j,k,2));
            end
         end
     end
     %testing phase%
     probab = randn(row1,numel(groups));
     for i=1:row1                        
        for j=1:numel(groups)
            probl= 1;
            for k=1:col1-1     
                mix_probab = 0;
                for m=1:N
                    mean = dist_n(j,k,m,1);
                    standard_deviation = dist_n(j,k,m,2);
                    weight = dist_n(j,k,m,3);                        
                    mix_probab = mix_probab + normpdf(test_data(i,k),mean,standard_deviation)*weight;

                end
                 probl = probl * mix_probab;
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