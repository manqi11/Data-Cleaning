# Getting-and-Cleaning-Data-Course-Project Procedure
##The Run_Analysis.R file perform the analysis and generate a new tidy data as the assignment requested.
*I first Download and unzip data
*I Read in the X,Y, and Subject datasets separately 
*I combine train and test datasets and view what they look like
*I labels the data set with descriptive variable names.
*I extract only the measurements on the mean and standard deviation for each measurement
*I combine all X,Y,and Subject Datasets together into the new dataset "CombinedAll"
*I read in the activity_label files to see the names for each activity
*I replace the activity code (1-6) with the corresponding descriptve labels
*Create a tidy data set with the average of each variable for each activity and each subject and check the results using table() function
*As required, I split the dataset based on activity and subject
*I use sapply() function to get the mean of each variable on the split data set
*The original row names does not fit the clean data principle, so I use split () function to split the activity and subject's ID
and name them as "activity" and "subject and save the new cleaned data as TidyData
*I write the results into a txt file
