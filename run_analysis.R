
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
  
  
  # Turn this on for testing but remove before publishing
  setwd("C://R//Data//Project")
  

  
  
  
  #####################################################################################################
  #                                           Collect Data
  #####################################################################################################
  
  
  #check whether you have already dowloaded the data, then download and unzip if not 
  if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
      
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      
      fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
      
      download.file(fileURL, fileName, mode = "wb")
      
      #download.file(fileURL,destfile="Q1q3.xlsx",mode="wb")
      
      #xData <- getURL(fileURL, ssl.verifypeer = FALSE)
      
      dateDownloaded <- date()
      
      print("didn't exist!")
      
      unzip(fileName, files = NULL, list = FALSE, overwrite = TRUE,
            junkpaths = FALSE, exdir = ".", unzip = "internal",
            setTimes = FALSE)
    
      
    }
    
  else {
    

    print("file existed!")
    
  }
  
  require(data.table)
  
  
  
  # Format activity labels and features data to be used in final data set
  
  activity_labels <- fread("UCI HAR Dataset//activity_labels.txt")
  
  features <- fread("UCI HAR Dataset//features.txt")
  
  #transform the column headers to one row so they can be used as the header
  
  features <- t(features)
  

  
  #####################################################################################################
  #                                           Test Section
  #####################################################################################################
    
#   x_test <- fread("UCI HAR Dataset//test//X_test.txt")
#   
#  
#   # Add a row number column for reference
#   
#   x_test$RowId <- 1:nrow(x_test)
#   
#   
#   
#   # Get activity codes for Test
#   
#      y_test <- fread("UCI HAR Dataset//test//y_test.txt")
#      
#      #colnames(y_test) <- "ActivityCode"
# 
#      y_test$RowId <- 1:nrow(y_test)
#      
#      
#   # Merge the activity codes into the Test data set 
#   x_test <- merge(x_test, y_test, by="RowId")
#   
#   
#   # Get Volunteer codes for Test
#   subject_test <- fread("UCI HAR Dataset//test//subject_test.txt")  
#   
#   
#   subject_test$RowId <- 1:nrow(subject_test)
#     
#    #colnames(subject_test) <- "Subject"
#   
#   
#   # Merge the subject codes into the Test data set 
#   x_test <- merge(x_test, subject_test, by="RowId")
#   
#   #Add feature column names to Test
#   colnames(x_test) <- c(features[2,])
#   
#   #New Column Just to identify the Source of data in table
#   x_test$Source <- rep("Test",nrow(x_test)) 
#   
 
  
# ########################################################################################################
#                                         Train Section
# ######################################################################################################## 

  
  
  x_train <- fread("UCI HAR Dataset//train//X_train.txt")
  
  #colnames(x_train) <- c(features[2,])
  

  
  
  # Add a row number column for reference
  
  x_train$RowId <- 1:nrow(x_train)
  
  
  
  # Get activity codes for train
  
  y_train <- fread("UCI HAR Dataset//train//y_train.txt")

  
  y_train$RowId <- 1:nrow(y_train)
  
  
  # Merge the activity codes into the train data set 
  x_train <- merge(x_train, y_train, by="RowId")
  
  
  # Get Volunteer codes for train
  subject_train <- fread("UCI HAR Dataset//train//subject_train.txt")  
  
  
  subject_train$RowId <- 1:nrow(subject_train)
  
  #colnames(subject_train) <- "Subject"
  
  
  # Merge the subject codes into the train data set 
  x_train <- merge(x_train, subject_train, by="RowId")
  

  
  #New Column Just to identify the Source of data in table
  x_train$Source <- rep("Train",nrow(x_train)) 
  
  
  #Add feature column names to Train
  colnames(x_train) <- c(features[2,],"RowId","ActivityCode","SubjectCode","DataSource")
  
   head(x_train)
  
############################################################################################################
  

  

}




 