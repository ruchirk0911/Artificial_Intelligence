function Task5(path)
contents = dlmread(path);

[row,col] = size(contents);
last_col= contents(:, col);

groups = unique(last_col);
for i = 1:numel(groups)
    index = contents(:,col) == groups(i);
    fprintf('Class %d, \t', i);
    col1_mean= mean(contents(index,1));
    col2_mean= mean(contents(index,2));
    fprintf('mean = [%.2f,%.2f], \t',col1_mean,col2_mean);
    col_variance = cov(contents(index,1),contents(index,2));
    fprintf('sigma= [%.2f,%.2f,%.2f,%.2f]',col_variance);
    fprintf('\n');
end
end

