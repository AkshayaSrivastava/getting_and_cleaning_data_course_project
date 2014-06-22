getting_and_cleaning_data_course_project
========================================

This repo contains:
    - README.md, to show how files relate
    - run_analysis.R, code to clean data downloaded from the Course Project Site
    - run_analysis.R Codebook, to denote what the names mean and the naming convention
    - clean_smartphone_data.csv, the cleaned data

Along with this, the script run_analysis.R will run once the course project
data provided is unzipped and the entired UCI HAR Dataset folder is placed in the
same directory as run_analysis.R. As the progam is defined currently, it expects
the UCI HAR Dataset folder to be placed within this particular repo once cloned.

Due to GitHub limitiations, this repo does notprovided the data files as well. 
They can be found at: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R will load the files from the UCI HAR Dataset folder and then it
will extract the mean and standard deviation values for the various measurement
types, name them, and summarize them into a data frame, which will then be written
into the file "clean_smartphone_data.csv." Refer to code comments for detailed
information and instructions. Datasets have been previously downloaded, as it
was not required to download directly from the internet.

Required Packages:
reshape2

A note on naming conventions:
    a - accelerometer measurement
    b - body measurement
    fd - frequency domain
    td - time domain
    m - mean (if first letter),magnitude
    s - standard deviation
    g - gravity, gyroscope
    j - jerk
    x,y,z - direction
    
Refer to codebook for full breakdown of names. Naming convention modelled on 
American Community Survey datasets.
