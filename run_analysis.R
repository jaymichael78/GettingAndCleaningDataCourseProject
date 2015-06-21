###############################
##  NAME: run_analysis
#
##PURPOSE:
#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
#VERSIONS:
##  
#  Ver  	Date		    Author						         Description
#-------	---------	-------------------------	-----------------------------------
#  1.0		06/20/2015	J.STEVENS					      1. CREATED THIS R SCRIPT
##Note: 
#This script assumes the files have been downloaded and extracted into the main working directory.
#Files remain in the same dircteories as extracted. 
#Downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
###############################

#Source libraries
library(data.table)

#Parameters
#zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#zipFile <- "datasets.zip"
subjects <- c("subject_id")
activities <- c("activity_id", "activity_name")
allLabels <- c("subject_id", "activity_id", "activity_name")

#Step 1 - Read the files into R and name the fields
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")  
  colnames(xTest)<- features

yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
  yTestMerged = merge(yTest, activityLabels, by.x="V1", by.y="V1", sort = FALSE)
    colnames(yTestMerged) <- activities 

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
  colnames(xTrain)<- features

yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
  yTrainMerged = merge(yTrain, activityLabels, by.x="V1", by.y="V1", sort = FALSE)
    colnames(yTrainMerged) <- activities


subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  colnames(subjectTest) <- subjects
  colnames(subjectTrain) <- subjects


#Step 2 - Extract only the mean and standard devition
  extractFeatures <- grepl("mean\\(\\)|std\\(\\)", features)
    xTest = xTest[,extractFeatures]
    xTrain = xTrain[,extractFeatures]

#Step 3 - Bind data
  testData <- cbind(subjectTest, yTestMerged, xTest)
  trainData <- cbind(subjectTrain, yTrainMerged, xTrain)
    allData <- rbind(testData, trainData)

#Step 4 - Create tidy data set with the average of each variable for each activity and each subject
groupBy <- list(allData$subject_id, allData$activity_id, allData$activity_name)
  almosTidyData <- aggregate(allData, by = groupBy, na.rm = TRUE, FUN = mean)
    colnames(almosTidyData)[1:3] <- allLabels
      names(almosTidyData) <- gsub("[-]", "_", names(almosTidyData))
      names(almosTidyData) <- gsub("^t", "Time", names(almosTidyData))
      names(almosTidyData) <- gsub("^f", "Frequency", names(almosTidyData))
          tidyData <- almosTidyData[ -c(2, 4,5,6)]
  

#Step 5 - Write tidyData output to txt file on local machine
write.table(tidyData, "tidyData.txt", row.names = FALSE)
