# Getting_-_Cleaning_Data_Project
Coursera Getting and Cleaning Data Project

The R script “run_analysis.R” completes the following tasks: 
1) merges the training and test sets to create one data set;
2) extracts only the measurements on the mean and standard deviation for each measurement;
3) uses descriptive activity names to name the activities in the data set;
4) appropriately label the data set with descriptive variable names;
5) creates a second, independent tidy data set with the average of each variable for each activity
   and each subject.

An explanation of what qualifies each task as completed above is provided below. Each number below corresponds with the the task number listed above.
1) The data frame “combined_test_train_data” represents the merged training and test sets. The merged data includes the raw files X_train.txt, y_train.txt, X_test.txt, y_test.txt, subject_train.txt, and subject_test.txt. The Inertial Signal files were not merged into the data frame, because the data was not needed to completed the assignment. 

2) The data frame “mean_std_measurements” presents only the columns of data in the raw files X_test.txt and X_train.txt that contained the words “mean()” or “std()”. The selection did not isolate the angle variable with “Mean” written in the name, because it was assumed not to be associated with the independent mean variable. 

3) The data frame “mean_std_measurements_activity” includes descriptive activity names under the column named “activity_label”. The key activity_labels was assigned to the numeric symbols in the y_test.txt and y_train.txt raw data files to generate the “activity_label” column.

4) The data frame “mean_std_measurements_activity” includes descriptive variable names. The combined subject_train.txt and subject_test.txt data files were assigned to the column with name “subject_id”. The combined y_train.txt and y_test.txt data files were assigned to the column with name “activity_label”. All other column names were designated to the combined X_train.txt and X_test.txt data files using the raw data file features.txt, which specifies the signal, variable, and, if relevant, direction in the name.

5) “tidy_data_subject_activity_by_variable.txt” contains the second, independent tidy data set with the mean of each variable mean and standard deviation by each activity and subject. The first two left columns “activity_label”  and “subject_id” lists all of the activities for each subject in the study. The remaining two columns list the mean of the all the mean variables and standard deviation variables, respectively, as these were the variables that were selected per the instructions in the assignment. The data set is tidy, because each column and row of the data set contains only one variable and observation, respectively. 
