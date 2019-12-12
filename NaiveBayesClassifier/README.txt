1) Open MATLAB.
2) Copy the training and test files in same folder with the code.
3) Type the following commands in MATLAB console:
Example:
-- For Histograms:
	naive_bayes('yeast_training.txt','yeast_test.txt','histograms',7)
-- For Guassians:
	naive_bayes('yeast_training.txt','yeast_test.txt','gaussians',0)
-- For Mixtures:
	naive_bayes('yeast_training.txt','yeast_test.txt','mixtures',3)
4) Press enter.