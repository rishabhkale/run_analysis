# Get Training related files and rename the default column names with those that make sense
# NOTE: Only those column names are changed that will be used going forward.
# EX: The measurements in the x_train files are not renames as only their mathematical Avg and SD are required
# Whereas the ActivityLabel in the y_train file and Subject in the sub_train file are used in the final output hence they are given names

x_train<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
y_train<-rename(y_train,ActivityLabel=V1)
sub_train<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
sub_train<-rename(sub_train,Subject=V1)

# Joining (column bind) the three train files
train_data<-cbind(sub_train,y_train,x_train)

# Get Test related files, same process as with the Train files
x_test<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
y_test<-rename(y_test,ActivityLabel=V1)
sub_test<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
sub_test<-rename(sub_test,Subject=V1)

# Join the three test files
test_data<-cbind(sub_test,y_test,x_test)

# Get the Activity Labels file and give appropriate headers
activity_labels<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
activity_labels<-rename(activity_labels,ActivityLabel=V1, ActivityDesc=V2)

# Join the Train and Test Data sets to make one data set (completing Part 1)
total_data<-rbind(train_data,test_data)

# Compute the mean of all the measuremens & store in new column - cols 3 to 563 (column 1 is the subject, col 2 is the activity label)
total_data<-mutate(total_data,MeasureMean=rowMeans(total_data[,3:563],na.rm=TRUE))

# Similarly, compute the StdDev of all measurements and store in new column
# The rowSDs is part of the matrixStats package, and it takes only a matrix as input, hence converting each row into a matrix before calulating the SD
total_data<-mutate(total_data,MeasureSD=rowSds(as.matrix(total_data[,3:563]),na.rm=TRUE))

# Extract only the Mean and SD columns of all measurements, i.e. Omit detailed Measurements
# This completes Part 2. 
tidy_data<-select(total_data,c(1:2,564:565))

# Merge the tidy_data dataframe with the activity_labels to give descriptive names to each activity
# This completed Part 3.
# Part 4 is about assigning names, which was done while getting files - complete
new_tidy_data<-merge(tidy_data,activity_labels,by="ActivityLabel")

# Re-ordering the new_tidy_data dataframe according to ActivityLabel and Subject
new_tidy_data<-arrange(new_tidy_data,ActivityLabel,Subject)

# Create a new group-by group for Activity Description and Subject
AcLabel<-group_by(new_tidy_data,ActivityDesc,Subject)

# Summarize the data per the Group-by: AcLabel
# and calculate the Mean of all measures (mean and SD) per Activity and Subject (hence the choice of group-by)
final_data<-summarize(AcLabel,AvMean=mean(MeasureMean),AvSD=mean(MeasureSD))

# The final_data DF has the final tidy data set. This completed Part 5
# Write this table to a text file to upload as per instructions
write.table(final_data,file="final_data.txt",row.names = FALSE)