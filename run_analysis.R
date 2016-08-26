# Load the necessary packages (rows 2-4)
library(dplyr)
library(plyr)
library(reshape2)

# Merge training and test sets to create one data frame
# Download the project files, including the features, activity labels, subject, x, and y files
# Check whether file location exists and all dimensions of incoming files [rows 9-25]
if(!file.exists("./data")){dir.create("./data")}
feature_lab<-read.table("./data/UCI HAR Dataset/features.txt")
dim(feature_lab)
activity_lab<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
dim(activity_lab)
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
dim(subject_test)
x_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
dim(x_test)
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
dim(y_test)
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
dim(subject_train)
x_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
dim(x_train)
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
dim(y_train)

# Convert all feature names to lower case
feature_lab[,2]<-tolower(feature_lab[,2])

#Appropriately label the data set with descriptive variable names [rows 31-36]
names(x_test)<-feature_lab[,2]
names(x_train)<-feature_lab[,2]
names(subject_test)<-"subject_id"
names(y_test)<-"activity_label"
names(subject_train)<-"subject_id"
names(y_train)<-"activity_label"

# Differentiate between the two types of test and train data sets and combine [rows 39-43]
test_type<-rep("test",2947)
train_type<-rep("train",7352)
combined_test_data<-cbind(subject_test,x_test,y_test,data_type=test_type)
combined_train_data<-cbind(subject_train,x_train,y_train,data_type=train_type)
combined_test_train_data<-rbind(combined_test_data,combined_train_data)

# Extract only the measurements on the mean and standard deviation variables [rows 46-50]
mean_column<-grep("mean()",names(combined_test_train_data),fixed=TRUE)
std_column<-grep("std()",names(combined_test_train_data),fixed=TRUE)
mean_std_column<-sort(c(mean_column,std_column))
mean_std_measurements<-combined_test_train_data[,mean_std_column]

# Assign descriptive activity names [rows 52-57]
combined_test_train_data$activity_label<-factor(as.character(combined_test_train_data$activity_label))
combined_test_train_data$activity_label<-revalue(combined_test_train_data$activity_label,c("1"="walking",
                                                "2"="walking_upstairs","3"="walking_downstairs","4"="sitting",
                                                "5"="standing","6"="laying"))
mean_std_measurements_activity<-cbind(mean_std_measurements,activity_label=combined_test_train_data$activity_label)

# Create a second, independent tidy data set with the average of each variable for each activity 
# and each subject [rows 60-72]
tidy_data_bind<-cbind(mean_std_measurements_activity,subject_id=combined_test_train_data$subject_id,
                                     data_type=combined_test_train_data$data_type)

# Convert data frame from wide to narrow [rows 64-67]
aggregatednames=names(tidy_data_bind)
aggregatednames<-aggregatednames[1:(length(aggregatednames)-3)]
tidy_data_aggregated<-melt(tidy_data_bind,id.vars=c("activity_label","subject_id","data_type"),measure.vars
     =aggregatednames)
# take the mean of all of the variables 
tidy_data_final<-dcast(tidy_data_aggregated,activity_label+subject_id~variable,mean)

# Write the tidy data set to a text file.
write.table(tidy_data_final,"./data/tidy_data_subject_activity_by_variable.txt",row.names=FALSE)






