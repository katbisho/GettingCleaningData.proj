#set working directory to file where data sets are saved
setwd("~/Documents/datasciencecoursera/GettingCleaningData.proj/UCI Har Dataset")

#load appropriate libraries
library(reshape2)

#save data from files to data sets in order to manipulate them
#read features.txt (column labels for x_train and x_test)
features <- read.table('features.txt', header = FALSE)
#only want to extract features on the mean and standard deviation
#temp is a temporary vector containing the list of features
temp <- features[ ,2]
#is_mean_std is a logical vector stating whether an element in temp is a mean or std
is_mean_std <- grepl("mean|std", temp)
#extract_features is a vector of only the names of the features pertaining to mean or std
extract_features <- temp[is_mean_std == TRUE]

#read activity_labels.txt, which are the descriptions given to the values of y_train and y_test
activity_labels <- read.table('activity_labels.txt', header = FALSE)
#read the train sets
subject_train <- read.table('./train/subject_train.txt', header = FALSE)
x_train <- read.table('./train/X_train.txt', header = FALSE)
y_train <- read.table('./train/Y_train.txt', header = FALSE)

#extract only features of x_train on mean and standard deviation
x_train <- x_train[ ,is_mean_std == TRUE]

#name the columns of subject_train, x_train, and y_train appropriately
#this will appropriately label the data set with descriptive variable names
colnames(subject_train) <- "SubjectID"
colnames(x_train) <- extract_features
colnames(y_train) <- "ActivityID"

#combine columns together to make TrainData data frame consisting of information from train
TrainData <- cbind(subject_train, y_train, x_train)


#read the test sets
subject_test <- read.table('./test/subject_test.txt', header = FALSE)
x_test <- read.table('./test/X_test.txt', header = FALSE)
x_test = x_test[is_mean_std == TRUE]
y_test <- read.table('./test/Y_test.txt', header = FALSE)

#extract only features of x_test on mean and standard deviation
x_test <- x_test[ ,is_mean_std == TRUE]

#name the columns of subject_test, x_test, and y_test appropriately
#this will appropriately label the data set with descriptive variable names
colnames(subject_test) <- "SubjectID"
colnames(x_test) <- extract_features
colnames(y_test) <- "ActivityID"

#combine columns together to make TestData data frame consisting of information from test
TestData <- cbind(subject_test, y_test, x_test)

#combine TrainData and TestData together row wise to make a large data frame consisting of all obersevations
#this is the one data set that combines test and train data together
Data <- rbind(TrainData, TestData)

#Give ActivityID column descriptive names based on the numeric value
#This uses descriptive activity names to name the activities in the data set
#Now the data set Data is the appropriately tidy data set for Step 4 of project
Data$ActivityID = factor(Data$ActivityID, levels = activity_labels[ ,1], labels = activity_labels[ ,2])

#Now, create a second, independed tidy data set with the average of each variable for each activity and each subject
IndependentData <- melt(Data, id = c("SubjectID", "ActivityID"))
Data_mean <- dcast(IndependentData, SubjectID + ActivityID ~ variable, mean)
