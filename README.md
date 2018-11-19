Getting and Cleaning Data Course Projectless <br>
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The data data collected from the accelerometers from the Samsung Galaxy S smartphone is available here
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This repository contains the following files:<br>
• README.md, this file, which provides an overview of the data set and how it was created.<br>
• tidydata.txt, which contains the data set.<br>
• CodeBook.md, the code book, which describes the contents of the data set.<br>
• run_analysis.R, the R script that was used to create the data set.<br>

The R script called run_analysis.R is used to create the new data set by implementing the following steps:<br>
• Download and unzip the data. <br>
• Merges the training and the test sets to create one data set.<br>
• Extracts only the measurements on the mean and standard deviation for each measurement.<br>
• Uses descriptive activity names to name the activities in the data set.<br>
• Appropriately labels the data set with descriptive variable names.<br>
• Creates a second, independent tidy data set with the average of each variable for each activity and each subject.<br>
• Write the data set to tidydata.txt file.<br>
