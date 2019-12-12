function class_details = Acc(row, groups, actual)
    predicted_class=0;
    max_row= max(row);
    [~,j] = find(row==max_row);
    count = 0;
    temp =0;
    for k= 1:numel(j)
        count = count+1;
        if actual == groups(j(k));
            temp = 1;
        end
        predicted_class = groups(j(k));
    end
    
    if temp ==1        
       accuracy = 1/count;
    else
        accuracy =0;
    end
    class_details=[accuracy predicted_class max_row];    
end

