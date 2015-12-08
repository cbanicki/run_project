
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
  #setwd("C://R//Data//Project")
  

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
  
  
  activity_labels <- read.table("UCI HAR Dataset//activity_labels.txt", sep = " ", header=FALSE, na.strings = NA)
  
  head(activity_labels)
  

}




 