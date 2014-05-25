## run_analysis.R by Paride Bertulio 
###(Getting and Cleaning Data course from John Hopkins University)

## Data input
The script get data from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Structure of the script:
### This Script is divided into 5 steps:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive activity names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

###1 Merges the training and the test sets to create one data set.
The script import in R 6 files:
- X_train.txt
- X_test.txt
- subject_train.txt
- subject_test.txt
- y_train.txt
- y_test.txt

and create 3 new data frame using rbind function:
dbX (X_train.txt, X_test.txt)
dbS (subject_train.txt, subject_test.txt)
dbY (y_train.txt, y_test.txt)

###2 Extracts only the measurements on the mean and standard deviation for each measurement. 
from dbX data frame  the script extract the mean and standarddeviation for each measurement using the features.txt file

###3 Uses descriptive activity names to name the activities in the data set
the file activity_labels.txt is used for get the names of the activity and store those in dbY data frame

###4. Appropriately labels the data set with descriptive activity names.
using the function cbind (columns bind), to "attach" the three data frame dbS, dbY, dbX, the data frame "cleaned" is created.
This dataframe is then dumped into an external file merged_data.txt (csv format)

###5. Creates a 2nd, independent tidy data set with the average of each variable 
In this steps I've used two loops (nested to each other) for scan all the variables and the activities and calculate the mean for each.
the result was dumped into an external file "averages.txt" (in csv format)