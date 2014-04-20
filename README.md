The given data comes divided into a training set and a test set, and contains 561 variables obtained from various statistical computations performed 
on accelerometer and gyroscope measurements on 30 subjects wearing smartphones while engaged in 6 different activities (walking, walking upstairs,
walking downstairs, sitting, standing, and laying).  Of the 561 variables, 33 are means of measurements, and 33 others are standard deviations; 
we identified these within the list of variable names by the fact that their names contained the strings "mean()" and "std()", respectively.  More
explanation of the variables can be found in the file "features_info.txt" that was included in the original data set. 

Our script "run_analysis.R" combines the training and test sets into one large data frame (named "merged"); extracts a subframe ("mergedMeanSD") 
containing only the 66 mean or standard deviation variables to which a 67th column indicating the activity being performed is then added; and produces 
another data frame ("out") showing the average values of each of the 66 mean or standard deviation variables for all of the 30*6=180 combinations of 
subject and activity (such as "1 WALKING" or "15 SITTING").  This last data frame "out" is written by the script to the file "output.txt". Both 
"mergedMeanSD" and "out" use descriptive names for activities and variables.
 
"run_analysis.R" assumes that the original zip file has already been extracted and that the files "features.txt", "X_train.txt", "y_train.txt", 
"subject_train.txt", "X_test.txt", "y_test.txt", "subject_test.txt", and "activity_labels.txt" are all in the working directory.  Detailed step-by-step 
explanations of the actions taken by the script are provided in the comments within the code.
