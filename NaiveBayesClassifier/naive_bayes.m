function naive_bayes(training_file,test_file,type,num)
    if(strcmp(type,'gaussians'))
        gaussian(training_file,test_file);
    elseif(strcmp(type,'histograms'))
         histogram(training_file,test_file,num);
    elseif(strcmp(type,'mixtures'))
        mixtures(training_file,test_file,num);
    end
end

