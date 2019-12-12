function linear_regression(training_file,degree,l)
    train_data = dlmread(training_file);
    [row,col] = size(train_data);
    x = train_data(:,col-1);
    t = train_data(:, col);
    phi = randn(row,degree+1);
    for i = 1:numel(x)
        for j = 0: degree
            phi(i,j+1)= power(x(i),j);
        end
    end
    
    if l == 0
        w = pinv(transpose(phi) * phi)* transpose(phi)*t;
    elseif l > 0
            w = pinv(l* eye(degree+1) + transpose(phi) * phi)* transpose(phi)*t;
    end
    w0 = w(1);
    w1 = w(2);
    if degree == 1
        w2 = 0;
    else
        w2 = w(3);
    end
    fprintf('w0= %.4f\n', w0);
    fprintf('w1= %.4f\n', w1);
    fprintf('w2= %.4f\n', w2);

end

