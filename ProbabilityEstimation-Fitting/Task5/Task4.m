function Task4(path)
contents = dlmread(path);

[row,col] = size(contents);
last_col= contents(:, col);

groups = unique(last_col);
for i = 1:numel(groups)
    index = contents(:,col) == groups(i);
    for j = 1:col
        fprintf('Class %d, \t', groups(i));
        fprintf('dimension %d, \t', j);
        col_mean= mean(contents(index,j));
        fprintf('mean = %.2f, \t',col_mean);
        col_variance = var(contents(index,j));
        fprintf('variance= %.2f \n',col_variance);
    end
    fprintf('\n');
end
end

