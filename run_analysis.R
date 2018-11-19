library(data.table)
library(dplyr)

#download the file and unzip it
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/dataset.zip")
unzip(zipfile = "./data/dataset.zip", exdir = "./data")

#get the list of files
datapath <- file.path("./data", "UCI HAR Dataset")
files <- list.files(datapath, recursive = TRUE)

#read data from the files into the variables
ActivityTestData <- read.table(file.path(datapath, "test","y_test.txt"), header = FALSE)
ActivityTrainData <- read.table(file.path(datapath, "train", "y_train.txt"), header = FALSE)

SubjectTestData <- read.table(file.path(datapath, "test", "subject_test.txt"), header = FALSE)
SubjectTrainData <- read.table(file.path(datapath, "train","subject_train.txt"), header = FALSE)

FeaturesTestData <- read.table(file.path(datapath, "test","X_test.txt"), header = FALSE)
FeaturesTrainData <- read.table(file.path(datapath,"train","X_train.txt"), header = FALSE)

#merge the train data and test data into one set and give names
subject <- rbind(SubjectTrainData, SubjectTestData)
activity <- rbind(ActivityTrainData, ActivityTestData)
features <- rbind(FeaturesTrainData, FeaturesTestData)

colnames(subject) <- "subject"
colnames(activity) <- "activity"
featuresNames <- read.table(file.path(datapath,"features.txt"), header = FALSE)
colnames(features) <- t(featuresNames[2])
fullData <- cbind(features, activity, subject)

#extract column indices with mean or std in them
colMeanSTD <- grep(".*Mean.*|.*Std.*", names(fullData), ignore.case=TRUE)

#add acitvity and subject columns to the list
selectedCol <- c(colMeanSTD, 562, 563)
requiredData <- fullData[,selectedCol]

#read activity labels and factorize it
activityLabels <- read.table(file.path(datapath, "activity_labels.txt"),header = FALSE)
requiredData$activity <- as.character(requiredData$activity)
for (i in 1:6){
        requiredData$activity[requiredData$activity == i] <- as.character(activityLabels[i,2])
}
requiredData$activity <- as.factor(requiredData$activity)

#Appropriately labels the data set with descriptive variable names
names(requiredData)<-gsub("Acc", "Accelerometer", names(requiredData))
names(requiredData)<-gsub("Gyro", "Gyroscope", names(requiredData))
names(requiredData)<-gsub("BodyBody", "Body", names(requiredData))
names(requiredData)<-gsub("Mag", "Magnitude", names(requiredData))
names(requiredData)<-gsub("^t", "Time", names(requiredData))
names(requiredData)<-gsub("^f", "Frequency", names(requiredData))
names(requiredData)<-gsub("tBody", "TimeBody", names(requiredData))
names(requiredData)<-gsub("-mean()", "Mean", names(requiredData), ignore.case = TRUE)
names(requiredData)<-gsub("-std()", "STD", names(requiredData), ignore.case = TRUE)
names(requiredData)<-gsub("-freq()", "Frequency", names(requiredData), ignore.case = TRUE)
names(requiredData)<-gsub("angle", "Angle", names(requiredData))
names(requiredData)<-gsub("gravity", "Gravity", names(requiredData))

#Creates a second,independent tidy data set
requiredData$subject <- as.factor(requiredData$subject)
requiredData <- data.table(requiredData)

newData<-aggregate(. ~subject + activity, requiredData, mean)
newData<-newData[order(newData$subject,newData$activity),]
write.table(newData, file = "tidydata.txt",row.name=FALSE)








