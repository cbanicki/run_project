
run_analysis <- function() {
  

  # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  # 
  # Here are the data for the project: 
  #   
  #   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  # 
  # You should create one R script called run_analysis.R that does the following. 
  # 1. Merges the training and the test sets to create one data set.
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  # 3. Uses descriptive activity names to name the activities in the data set
  # 4. Appropriately labels the data set with descriptive variable names. 
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
#   Please upload the tidy data set created in step 5 of the instructions. 
#   Please upload your data set as a txt file created with write.table() using row.name=FALSE (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).
  
  
  
  # Used just for testing, comment out
  #  setwd("C://R//Data//Project")
  

  #####################################################################################################
  #                                           Collect Data
  #####################################################################################################
  
  output <- tryCatch(
  
    {
      #Check whether you have already dowloaded the data into the working director, and if not, download and unzip it 
      
      message("Checking local drive for data file. If it's not there then trying URL for new file.")

  if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
      
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      
      fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
      
      download.file(fileURL, fileName, mode = "wb")
      
      dateDownloaded <- date()
      
      unzip(fileName, files = NULL, list = FALSE, overwrite = TRUE,
            junkpaths = FALSE, exdir = ".", unzip = "internal",
            setTimes = FALSE)
    }
    
},
    error=function(cond) {
      message(paste("Error getting data:", fileURL))
      message("Original Error Message:")
      message(cond)
      # Return NA
      stop("Check connection and try again.")
      return(NA)
    },
    warning=function(cond) {
      message(paste("Warning getting data", fileURL))
      message("Original warning message:")
      message(cond)
},
  
  finally={
  
  require(data.table)
  # Collect activity labels
  activity_labels <- fread("UCI HAR Dataset//activity_labels.txt")
  
 
  # Add column names for activity labels
  colnames(activity_labels) <- c("ActivityCode","ActivityName")
  
  
  # Collect features
  features <- fread("UCI HAR Dataset//features.txt")
  
  
  # Transform the column headers to one row so they can be used as the header
  features <- t(features)
  

  
  #####################################################################################################
  #                                           Test Section
  #####################################################################################################
    
  
  # Collect the x_test data
  x_test <- fread("UCI HAR Dataset//test//X_test.txt")
  
 
  # Add a row number column for a reference key
  x_test$RowId <- 1:nrow(x_test)
  
  
  # Get activity codes for Test and add a column name
  y_test <- fread("UCI HAR Dataset//test//y_test.txt")
     
  colnames(y_test) <- "ActivityCode"
     
     
  # Add the row number key to y_test
  y_test$RowId <- 1:nrow(y_test)
     
  
  #Add activity label to y_test   
  y_test <- merge(y_test, activity_labels, by="ActivityCode")   
     
  # Merge the activity codes into the Test data set 
  x_test <- merge(x_test, y_test, by="RowId")
  
  
  # Get Volunteer codes for Test
  subject_test <- fread("UCI HAR Dataset//test//subject_test.txt")  
  
  #Add key to subject_test to identify rows
  subject_test$RowId <- 1:nrow(subject_test)
    
  # Merge the subject codes into the Test data set 
  x_test <- merge(x_test, subject_test, by="RowId")
  
  #New key Column Just to identify the Source of data in table
  x_test$Source <- rep("Test",nrow(x_test)) 
  
  #Add feature column names to Test
  colnames(x_test) <- c("RowId",features[2,],"ActivityCode","ActivityLabel","SubjectCode","DataSource")
  
  
# ########################################################################################################
#                                         Train Section
# ######################################################################################################## 

  
  # Collect the x_train data
  x_train <- fread("UCI HAR Dataset//train//X_train.txt")
  
  # Add a row number column for a reference key
  x_train$RowId <- 1:nrow(x_train)
  
  # Get activity codes for y_train
  y_train <- fread("UCI HAR Dataset//train//y_train.txt")

  
  # Add feature column names to y_train so that it can be joined to activity names
  colnames(y_train) <- c("ActivityCode")
  
  # Add a reference key to y_train
  y_train$RowId <- 1:nrow(y_train)
  
  # Merge activity labels with y_train
  y_train <- merge(y_train, activity_labels, by="ActivityCode")
  
  # Merge x_train and y_train 
  x_train <- merge(x_train, y_train, by="RowId")
  
  # Get Volunteer codes for train
  subject_train <- fread("UCI HAR Dataset//train//subject_train.txt")  
  
  # Add a row key to subject_train
  subject_train$RowId <- 1:nrow(subject_train)
  
  # Merge the subject codes into the train data set 
  x_train <- merge(x_train, subject_train, by="RowId")
  
  #New Column just to identify the Source of data in table
  x_train$Source <- rep("Train",nrow(x_train)) 
  
  #Add feature column names to Train
  colnames(x_train) <- c("RowId",features[2,],"ActivityCode","ActivityLabel","SubjectCode","DataSource")
  

  # ########################################################################################################
  #                                         Combine Test and Train 
  # ########################################################################################################   
  
  # For Part 1, (as well as Part 3), all the data is in one file and I have added the descriptive fields, but still need to make sure we have all numerical values in the data
  x_combined <- rbind.data.frame(x_test,x_train)
  
  # For Part 2, only columns with mean or std
  x_mean_std <- subset(x_combined, select = x_combined[,c("RowId","SubjectCode","ActivityLabel", colnames(x_combined)[grep("mean()",colnames(x_combined))],colnames(x_combined)[grep("std()",colnames(x_combined))])])
  
  # Define user-friendly column headers to replace current ones
  names(x_mean_std) <- c("RowId",	"SubjectCode",	"ActivityLabel",
  "timeBodyAcceleration_Mean_X",	"timeBodyAcceleration_Mean_Y",	"timeBodyAcceleration_Mean_Z",
  "timeGravityAcceleration_Mean_X",	"timeGravityAcceleration_Mean_Y",	"timeGravityAcceleration_Mean_Z",
  "timeBodyAccelerationJerk_Mean_X",	"timeBodyAccelerationJerk_Mean_Y",	"timeBodyAccelerationJerk_Mean_Z",
  "timeBodyGyro_Mean_X",	"timeBodyGyro_Mean_Y",	"timeBodyGyro_Mean_Z",
  "timeBodyGyroJerk_Mean_X",	"timeBodyGyroJerk_Mean_Y",	"timeBodyGyroJerk_Mean_Z",
  "timeBodyAccelerationMagnitude_Mean",	"timeGravityAccelerationMagnitude_Mean",	"timeBodyAccelerationJerkMagnitude_Mean",
  "timeBodyGyroMagnitude_Mean",	"timeBodyGyroJerkMagnitude_Mean",	"frequencyBodyAcceleration_Mean_X",
  "frequencyBodyAcceleration_Mean_Y",	"frequencyBodyAcceleration_Mean_Z",	"frequencyBodyAcceleration_MeanFreq_X",
  "frequencyBodyAcceleration_MeanFreq_Y",	"frequencyBodyAcceleration_MeanFreq_Z",	"frequencyBodyAccelerationJerk_Mean_X",
  "frequencyBodyAccelerationJerk_Mean_Y",	"frequencyBodyAccelerationJerk_Mean_Z",	"frequencyBodyAccelerationJerk_MeanFreq_X",
  "frequencyBodyAccelerationJerk_MeanFreq_Y",	"frequencyBodyAccelerationJerk_MeanFreq_Z",	"frequencyBodyGyro_Mean_X",
  "frequencyBodyGyro_Mean_Y",	"frequencyBodyGyro_Mean_Z",	"frequencyBodyGyro_MeanFreq_X",
  "frequencyBodyGyro_MeanFreq_Y",	"frequencyBodyGyro_MeanFreq_Z",	"frequencyBodyAccelerationMagnitude_Mean",
  "frequencyBodyAccelerationMagnitude_MeanFreq",	"frequencyBodyAccelerationJerkMagnitude_Mean",	"frequencyBodyAccelerationJerkMagnitude_MeanFreq",
  "frequencyBodyGyroMagnitude_Mean",	"frequencyBodyGyroMagnitude_MeanFreq",	"frequencyBodyGyroJerkMagnitude_Mean",
  "frequencyBodyGyroJerkMagnitude_MeanFreq",	"timeBodyAcceleration_StandardDeviation_X",	"timeBodyAcceleration_StandardDeviation_Y",
  "timeBodyAcceleration_StandardDeviation_Z",	"timeGravityAcceleration_StandardDeviation_X",	"timeGravityAcceleration_StandardDeviation_Y",
  "timeGravityAcceleration_StandardDeviation_Z",	"timeBodyAccelerationJerk_StandardDeviation_X",	"timeBodyAccelerationJerk_StandardDeviation_Y",
  "timeBodyAccelerationJerk_StandardDeviation_Z",	"timeBodyGyro_StandardDeviation_X",	"timeBodyGyro_StandardDeviation_Y",
  "timeBodyGyro_StandardDeviation_Z",	"timeBodyGyroJerk_StandardDeviation_X",	"timeBodyGyroJerk_StandardDeviation_Y",
  "timeBodyGyroJerk_StandardDeviation_Z",	"timeBodyAccelerationMagnitude_StandardDeviation",	"timeGravityAccelerationMagnitude_StandardDeviation",
  "timeBodyAccelerationJerkMagnitude_StandardDeviation",	"timeBodyGyroMagnitude_StandardDeviation",	"timeBodyGyroJerkMagnitude_StandardDeviation",
  "frequencyBodyAcceleration_StandardDeviation_X",	"frequencyBodyAcceleration_StandardDeviation_Y",	"frequencyBodyAcceleration_StandardDeviation_Z",
  "frequencyBodyAccelerationJerk_StandardDeviation_X",	"frequencyBodyAccelerationJerk_StandardDeviation_Y",	"frequencyBodyAccelerationJerk_StandardDeviation_Z",
  "frequencyBodyGyro_StandardDeviation_X",	"frequencyBodyGyro_StandardDeviation_Y",	"frequencyBodyGyro_StandardDeviation_Z",
  "frequencyBodyAccelerationMagnitude_StandardDeviation",	"frequencyBodyAccelerationJerkMagnitude_StandardDeviation",	"frequencyBodyGyroMagnitude_StandardDeviation",
  "frequencyBodyGyroJerkMagnitude_StandardDeviation" )
  
  # Rename descriptive column names
  colsName <- names(x_mean_std)[2:3]
  
  # Rename mean columns
  colsMean <- names(x_mean_std)[4:82]

  #Take the mean values
  x_mean_std.mean <- x_mean_std[,lapply(.SD,mean,na.rm=TRUE), by = colsName, .SDcols=colsMean] 
  
  # Gather Volunteer (i.e. subject codes)
  x_mean_std.mean$SubjectCode <- factor(x_mean_std.mean$SubjectCode, levels =  c("1","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21","22", "23", "24", "25", "26", "27", "28", "29", "30"), ordered = TRUE)
  
  x_mean_std.mean$SubjectCode <-  as.numeric(levels(x_mean_std.mean$SubjectCode)[x_mean_std.mean$SubjectCode]) 
  
  # Order data by subject code for original data
  # messydata <-   na.omit(x_mean_std[order(x_mean_std.mean$SubjectCode)])
  
  # Order tidy data by volunteer number
  tidydata <-   na.omit(x_mean_std.mean[order(x_mean_std.mean$SubjectCode)])

  # Write tidy data to a file
  write.table(tidydata, file = "975119_getdata-035.txt", row.names = FALSE)
  
  print("Process Complete. Find 975119_getdata-035.txt in working directory.")
  
  }
    
  )
  
  return(output)
  
}


 