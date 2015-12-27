The run_analysis.R script is created to read training and test data files from the Samsung Galaxy S smartphone files, combine them, calculate the Mean and Standard Deviation of the Measurements, attach verbose labels and create a tidy set out of it.
Then the script generates another tidy data set that calulates the averages of the above two columns for each Subject and Activity
This new tidy set is then written to a file

First the *_train.txt files are read into data frames.
Then meaningful column names are given
The 3 train data frames are bound into one data frame (train_data) using cbind

This exact strategy is followed with the *_test.txt files
This creates the test_data data frame

Get the activity_labels.txt file as the activity_labels data frame, and give meaningful column names

Join (rbind) the test and train data frames as total_data . This completes Part 1 of the assignment.
Using the mutate function in the dplyr package add columns MeasureMean (mean using rowMeans function of the measures) and MeasureSD (standard deviation using rowSds of the matrixStats package of the measurements).
NOTE: The rowSds function takes a matrix as input therefore the data frame is converted to a matrix
The measurements are in the 3rd to the 363rd column (hence these are what are passed in the mean and SD functions

A new data frame (tidy_data) is created as a subset of the total_data data frame to include only the ActivityLabel, Subject and the newly created MeasureMean and MeasureSD columns. This completed Part 2 of the assignment.

Merge the tidy_data dataframe with the activity_labels to give descriptive names to each activity
This completes Part 3. Part 4 is about assigning names, which was done while getting files - complete

Create a new group-by group for Activity Description and Subject.
Summarize the data per the Group-by: AcLabel and calculate the Mean of all measures (mean and SD) per Activity and Subject (hence the choice of group-by)

The final_data DF has the final tidy data set. This completed Part 5
Write this table to a text file to upload as per instructions