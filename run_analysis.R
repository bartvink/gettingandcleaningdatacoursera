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

#### Setup for reshape2 package
if (!require("reshape2")) { install.packages("reshape2") }
require("reshape2")

#### Download and setup file structure for our project data
filename <- "project_data.zip"
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, filename, method="curl")
unzip(filename) 

###############################################
#### Part 1 - Merging train/test data sets ####
###############################################


#######################################################
#### Part 2 - Extract mean/sd for each measurement ####
#######################################################


#################################################
#### Part 3 - Name activites in the data set ####
#################################################


##################################################
#### Part 4 - Label data set w/ vriable names ####
##################################################


#############################################
#### Part 5 - Create final tidy data set ####
#############################################