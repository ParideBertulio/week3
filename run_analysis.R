# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# A full description is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# **************************************************************************************
# **************************************************************************************


#*****************************************************************
# 1. Merges the training and the test sets to create one data set.
#*****************************************************************

X_train <- read.table("train/X_train.txt")
X_test  <- read.table("test/X_test.txt")
dbX <- rbind(X_train, X_test)

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
dbS <- rbind(subject_train, subject_test)

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
dbY <- rbind(y_train, y_test)

#*******************************************************************************************
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#*******************************************************************************************

features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
dbX <- dbX[, indices_of_good_features]
names(dbX) <- features[indices_of_good_features, 2]
names(dbX) <- gsub("\\(|\\)", "", names(dbX))
names(dbX) <- tolower(names(X))

#***************************************************************************
# 3. Uses descriptive activity names to name the activities in the data set
#***************************************************************************

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
dbY[,1] = activities[dbY[,1], 2]
names(dbY) <- "activity"

#***************************************************************************
# 4. Appropriately labels the data set with descriptive activity names.
#***************************************************************************

names(dbS) <- "subject"
cleaned <- cbind(dbS, dbY, dbX)
#******* use txt instead of csv only beacuse the page to upload the file 
#******* request txt file **********************************************
write.csv(cleaned, file = "output/merged_data.txt")

#******************************************************************************
# 5. Creates a 2nd, independent tidy data set with the average of each variable 
#    for each activity and each subject.
#******************************************************************************

uniqueSubjects = unique(dbS)[,1]
numSubjects = length(unique(dbS)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activities[a, 2]
                tmp <- cleaned[cleaned$subject == s & cleaned$activity == activities[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row + 1
        }
}

#******* use txt instead of csv only beacuse the page to upload the file 
#******* request txt file **********************************************
write.csv(result, file = "output/averages.txt")
