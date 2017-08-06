# CleaningDataAssignment

This repo is submitted for the Getting and Cleaning Data Course Project. 

It contains the following:

1. An R Script called run_analysis.R
2. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
3. A tidy dataset called tidy.txt that is the result of the run_analysis.R script.

Please note when using the R script for your own purposes, be sure to set the working directory for the correct file path on your own computer. There is a line of code at the beginning of the script to do this using setwd().

The run_analysis.R script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Please note this script creates a tidy dataset in long format. For more information please read Tidy Data by Hadley Wickham (2014), which can be found here: http://vita.had.co.nz/papers/tidy-data.html 
