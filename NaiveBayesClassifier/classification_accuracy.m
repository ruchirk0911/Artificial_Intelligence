function classification_accuracy( result)
    result_col = result(:,5);
    sum_last_col = sum(result_col);
    classification_accuracy = sum_last_col/numel(result_col);
    for i = 1: max(size(result))
        fprintf('ID=%5d, predicted=%3d, probability = %.4f, true=%3d, accuracy=%4.2f\n',result(i,1), result(i,2), result(i,3), result(i,4), result(i,5));
    end
    fprintf('classification accuracy=%6.4f\n', classification_accuracy);
end

