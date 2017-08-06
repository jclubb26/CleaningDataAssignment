# Be sure to set your working directory for your own file path

getwd()
setwd("C:\\Users\\FIRSTBEAT\\Documents\\R\\Coursera")

if(!file.exists("Getting and Cleaning Data Assignment")){
  dir.create("Getting and Cleaning Data Assignment")
}

# 1 Merges the training and the test sets to create one data set.

# Download and unzip file

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, dest = "Getting and Cleaning Data Assignment/UCIHARDataset.zip", mode = "wb")
unzip("Getting and Cleaning Data Assignment/UCIHARDataset.zip", 
      exdir = "Getting and Cleaning Data Assignment")

list.files("Getting and Cleaning Data Assignment/UCI HAR Dataset")

# Import test and train files

X_test <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/train/subject_train.txt")

# Read in activity and features labels and convert factors to characters

activity_labels <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])

features <- read.table(
  "Getting and Cleaning Data Assignment/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Rename column names in each dataset

colnames(X_test) = features[,2]
colnames(X_train) = features[,2]
colnames(y_test) = 'activityLabels'
colnames(y_train) = 'activityLabels'
colnames(subject_test) = 'subjectID'
colnames(subject_train) = 'subjectID'

# Create train and test data sets then bind together

train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)

all <- rbind(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Create a logical that returns subject ID, activity labels and columns including mean() and sd() variables

columns = colnames(all)

logical <- (grepl("subjectID", columns) | grepl("activityLabels", columns) | 
              grepl("-mean()..", columns) | grepl("-std()..", columns))

# Subset the 'all' dataset to include only the columns from the logical vector

meansd_data <- all[, logical == TRUE]

# 3. Uses descriptive activity names to name the activities in the data set

meansd_data[,2] <- activity_labels[meansd_data[,2], 2]

# 4. Appropriately labels the data set with descriptive variable names.

names(meansd_data) <- gsub("-", ".", names(meansd_data))
names(meansd_data) <- gsub("f", "Freq.", names(meansd_data))
names(meansd_data) <- gsub("tB", "Time.B", names(meansd_data))
names(meansd_data) <- gsub("tG", "Time.G", names(meansd_data))
names(meansd_data) <- gsub("mean()", "Avg", names(meansd_data))
names(meansd_data) <- gsub("std()", "SD", names(meansd_data))
names(meansd_data) <- gsub("\\()", "", names(meansd_data))
names(meansd_data)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

require(reshape2)
mean_data <- melt(meansd_data, id = c("subjectID", "activityLabels"))
summary_data <- dcast(mean_data, subjectID + activityLabels ~ variable, mean)

write.table(summary_data, file = "tidy.txt")

# If you wish to read this table back into R to view use:

tidy <- read.table("tidy.txt", header = TRUE)
  
  