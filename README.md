# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Loads the following files from UCI HAR Dataset 
(filesaved in ~/Documents/datasciencecoursera/GettingCleaningData.proj)
    -Activity_labels.txt
    -feature.txt
    -training datasets
    -test datasets
2. Keeps only those columns in the training and datasets which are either activities, subjects, or reflect a mean or standard deviation
3. Merges the training datasets and test datasets into two different dataframes
4. Merges the two dataframes into one large data frame called Data
5. Converts the activity column in Data to reflect the label specified in activity_labels.txt
5. Converts the activity and subject columns into factors
6. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is saved in a dataframe called Data_mean.# GettingCleaningData.proj
