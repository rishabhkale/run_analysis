Variable Description:

x_train: Read training file X_train.txt ("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train: Read training file y_train.txt ("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
sub_train: Read training file sub_train.txt ("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
train_data: Combination of all three training files (x_train, y_train and sub_train)

x_test: Read Test file x_test.txt ("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test: Read Test file y_test.txt ("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
sub_test: Read Test file sub_test.txt ("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
test_data: Combination of all three training files (sub_test, y_test and x_test)

activity_labels: Read file with Activity Labels - activity_labels.txt ("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

total_data: Combination of test and train data sets (train_data,test_data)
	MeasureMean: New column added in total_data to store the Mean of the measurements
	MeasureSD: New column added in total_data to store the Standard Deviation of the measurements

tidy_data: Subset of the total_data dataframe with columns, Subject, ActivityLabel, MeasureMean and MeasureSD

new_tidy_data: Merge the tidy_data and activity_labels data frames (by ActivityLabel. This adds column ActivityDesc to the tidy_data data frame

AcLabel: A new group-by variable, grouped by ActivityDesc and Subject on the new_tidy_data data frame

final_data: Summarized the AcLabel data frame by ActivityDesc and Subject (group-by) to calculate AvMean=mean(MeasureMean) and AvSD=mean(MeasureSD))
This is the final tidy data set required to be created as part of this course project