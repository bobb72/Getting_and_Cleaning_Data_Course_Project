# Here are the data for the project:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# You should create one R script called run_analysis.R that does the following:

# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.

setwd("C:/Users/Bob/Desktop/DS Specialization/3_Getting_&_Cleaning_Data/UCI HAR Dataset")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="../UCI HAR Dataset.zip")
unzip(zipfile="../UCI HAR Dataset.zip",exdir="..")

library(plyr)

# Read files:
activityTest  <- read.table("test/Y_test.txt", header = FALSE)
activityTrain <- read.table("train/Y_train.txt", header = FALSE)
subjectTest  <- read.table("test/subject_test.txt", header = FALSE)
subjectTrain <- read.table("train/subject_train.txt", header = FALSE)
featuresTest  <- read.table("test/X_test.txt", header = FALSE)
featuresTrain <- read.table("train/X_train.txt", header = FALSE)
activityLabels <- read.table("activity_labels.txt",header = FALSE)
featuresNames <- read.table("features.txt",head=FALSE)

# 1.Merges the training and the test sets to create one data set:
subject <- rbind(subjectTrain, subjectTest)
names(subject)<-c("subject")

names(activityLabels)<- c("activity","activityName")
activity<- rbind(activityTrain, activityTest)
names(activity)<-c("activity")

names(featuresNames)<- c("feature", "featureName")
features<- rbind(featuresTrain, featuresTest)
names(features)<- featuresNames$featureName

subj_activ<- cbind(subject, activity)
answer1 <- cbind(subj_activ,features)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement:
featuresMeanStD <- grep("mean\\(\\)|std\\(\\)",featuresNames$featureName,value=TRUE)
featuresMeanStD<-c("subject", "activity", as.character(featuresMeanStD))
answer2<- subset(answer1,select=featuresMeanStD)

# 3.Uses descriptive activity names to name the activities in the data set:
answer3<- answer2
answer3$activity<-factor(answer3$activity, levels = activityLabels[,1], labels = activityLabels[,2])

# 4.Appropriately labels the data set with descriptive variable names:
answer4<-answer3
names(answer4)<-gsub("^t", "time", names(answer4))
names(answer4)<-gsub("^f", "frequency", names(answer4))
names(answer4)<-gsub("Acc", "Accelerometer", names(answer4))
names(answer4)<-gsub("Gyro", "Gyroscope", names(answer4))
names(answer4)<-gsub("Mag", "Magnitude", names(answer4))
names(answer4)<-gsub("BodyBody", "Body", names(answer4))

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
answer5<-aggregate(. ~subject + activity, answer4, mean)
answer5<-answer5[order(answer5$subject,answer5$activity),]
write.table(answer5, file = "tidydata.txt",row.name=FALSE)

# Cleanup
rm(list=c("activity", "activityLabels", "activityTest", "activityTrain", "features", 
          "featuresMeanStD", "featuresNames", "featuresTest", "featuresTrain", "fileUrl",
          "subj_activ", "subject", "subjectTest", "subjectTrain"))