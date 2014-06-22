# Coursera- Getting and Cleaning Data- Course Project
# Author: Akshaya Srivastava
# TODO: Getting and Cleaning Data Course Project
# - gather and combine data from UCI HAR data
# - create tidy data set from UCI HAR data
# - output tidy data set for downstream analysis

# Step 1: gather data from UCI HAR data
# - .csv files have already been downloaded and are simply
# - being read into R. This script does not download the latest
# - data from the internet as this functionality isn't part of 
# - the requirements. 

# reading in data from test folder in .zip file
test_subj <- read.table("~/getting_and_cleaning_data_course_project/UCI HAR Dataset/test/subject_test.txt",sep="")
test_x <- read.table("~/getting_and_cleaning_data_course_project/UCI HAR Dataset/test/X_test.txt",sep="")
test_y <- read.table("~/getting_and_cleaning_data_course_project/UCI HAR Dataset/test/y_test.txt",sep="")

# test_y is the set of lables, and test_subj is the set of subjects that 
# correspond to the data in test_x. Thus, this data needs to be combined
tidy_test <- cbind(test_subj,test_x,test_y)

# reading in data from train folder in .zip file
train_subj <- read.table("~/getting_and_cleaning_data_course_project/UCI HAR Dataset/train/subject_train.txt",sep="")
train_x <- read.table("~/getting_and_cleaning_data_course_project/UCI HAR Dataset/train/X_train.txt",sep="")
train_y <- read.table("~/getting_and_cleaning_data_course_project/UCI HAR Dataset/train/y_train.txt",sep="")

# train_y is the set of lables, and train_subj is the set of subjects that 
# correspond to the data in train_x. Thus, this data needs to be combined
tidy_train <- cbind(train_subj,train_x,train_y)

# combining both data sets to get first useful dataset
tidy_data <- rbind(tidy_test,tidy_train)

# Step 2:Extract the mean and std columns from the tidy
# data to get second useful dataset
# - Specify the columns of interest
# - Extract specified columns only

# Specifying which columns to select
# Refer to UCI HAR Features.txt for more information
# Note: as subject has been prepended in tidy_data, variable indicies in UCI HAR 
# Features.txt have been incremented by 1
cols_to_sel <- c(2:7,42:47,82:87,122:127,162:167,202,207,215,216,228,229,241,242,254,255,267:272,346:351,425:430,504,505,517,518,530,531,540,541)

# Subset tidy_data to get only the data that is relevant to the course project
mean_std_tidy_data <- tidy_data[,cols_to_sel]

# Step 3: Add activities and subject numbers to the data set.
# - identify which activity should go to each row and build character vector for that
# - append the activity and the subject to the tidy data

# creating dummy vector to hold activity vector until it is added to the dataset
dummy <- "0"

# looping through the data to create the activity vector
for (i in 1:length(tidy_data[,563])){
    if (tidy_data[i,563] == 1){
        dummy <- c(dummy,"Walking")
    }
    if (tidy_data[i,563] == 2){
        dummy <- c(dummy,"Walking_Upstairs")
    }
    if (tidy_data[i,563] == 3){
        dummy <- c(dummy,"Walking_Downstairs")
    }
    if (tidy_data[i,563] == 4){
        dummy <- c(dummy,"Sitting")
    }
    if (tidy_data[i,563] == 5){
        dummy <- c(dummy,"Standing")
    }
    if (tidy_data[i,563] == 6){
        dummy <- c(dummy,"Laying")
    }
}

# removing first dummy entry and adding to the data with the subject ids
activities <- dummy[2:length(dummy)]
subject_id <- tidy_data[,1]
clean_dataset <- cbind(subject_id,mean_std_tidy_data,activities)

# Step 4: Add descriptive names for all the variable names, summarize the data
# and write out to file
# - create vector of descriptive names
# - set descriptive name vector as variable names
# - summarize data into averages in a flat table
# - write out to .csv file

# creating vector of names as denoted in "run_analysis.R Codebook.md"
# NOTE: The variable naming method has been modelled after the conventions used
# in the datasets provided by the American Community Survey
names_vec <- c("subject_id","mtdbax","mtdbay","mtdbaz","stdbax","stdbay","stdbaz",
               "mtdgax","mtdgay","mtgbaz","stdgax","stdgay","stdgaz","mtdbajx",
               "mtdbajy","mtdbajz","stdbajx","stdbajy","stdbajz","mtdbgx","mtdbgy",
               "mtdbajz","stdbgx","stdbgy","stdbgz","mtdbgjx","mtdbgjy","mtdbajz",
               "stdbgjx","stdbgjy","stdbgjz","mtdbam","stdbam","mtdgam","stdgam",
               "mtdbajm","stdbajm","mtdbgm","stdbgm","mtdbgjm","stdbgjm","mfdbax",
               "mfdbay","mfdbaz","sfdbax","sfdbay","sfdbaz","mfdbajx","mfdbajy",
               "mfdbajz","sfdbajx","sfdbajy","sfdbajz","mfdbgx","mfdbgy","mfdbajz",
               "sfdbgx","sfdbgy","sfdbgz","mfdbam","sfdbam","mfdbajm","sfdbajm",
               "mfdbgm","sfdbgm","mfdbgjm","sfdbgjm","activity")

# Setting names of dataset
names(clean_dataset)<-names_vec

# summarizing the mean of each measure for each subject and activity combination
# NOTE: Functions used require the reshape2 package
molten_data <- melt(clean_dataset, id.vars=c("subject_id,activity"))
final_dataset <- acast(data=molten_data,subect_id ~ acticity ~ variable,mean)

# writing to output .csv file, clean_smartphone_data.csv
write.csv(final_dataset,file="clean_smartphone_data.csv")

# End Code


