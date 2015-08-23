# Title: 		Getting and Cleaning - Course Project
# Description: 	The purpose of this project is to demonstrate your ability to collect, work with, and 
#				clean a data set.
# Author: 		Miguel Herrera

###############################################
#### Course Project Tasks - Run Analysis   ####
###############################################
# 0. Setup process
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 		variable for each activity and each subject.


###############################################
#### Part 0 - Setup Process ####
###############################################

#### Setup for data.table package
if (!require("data.table")) { install.packages("data.table") }
require("data.table")

#### Setup for dplyr package
if (!require("dplyr")) { install.packages("dplyr") }
require("dplyr")

#### Download and setup file structure for our project data
filename <- "project_data.zip"
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, filename, method="curl")
unzip(filename) 

#### Assign feature names and activity labels
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

#### Assign train data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#### Assign test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

###############################################
#### Part 1 - Merging train/test data sets ####
###############################################

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#### Column names from features
colnames(features) <- t(featureNames[2])

#### Add activity and subject as a column to features
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

#######################################################
#### Part 2 - Extract mean/sd for each measurement ####
#######################################################

meanSTD <- grep(".*mean.*|.*std.*", names(completeData), ignore.case=TRUE)

#### Added activity and subject columns
requiredCols <- c(meanSTD, 562, 563)

#### Number of variables in completeData
dim(completeData)
extractedData <- completeData[,requiredCols]

#### Number of variables in extractedData
dim(extractedData)

#################################################
#### Part 3 - Name activites in the data set ####
#################################################

extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}
#### Assign activity variable in the data as a factor
extractedData$Activity <- as.factor(extractedData$Activity)

##################################################
#### Part 4 - Label data set w/ vriable names ####
##################################################

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

#############################################
#### Part 5 - Create final tidy data set ####
#############################################

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

#### Assign tidyData as a set with average
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

#### tidyData into a text file
write.table(tidyData, file = "tidy.txt", row.names = FALSE)