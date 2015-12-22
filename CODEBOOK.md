==================================================================
Run_Analysis.R - tidy data set for 'Getting and Cleaning Data', 
an online course offerred by Johns Hopkins, Bloomberg School of Public Health.
Version 1.0
==================================================================
Chad Banicki
chad.banicki@gmail.com
==================================================================

A google docs version of the codebook can be found here:
https://docs.google.com/document/d/10An5EkzfLs0_4yGqi3LambaK11nq3xmwop9kic2V6UQ/edit?usp=sharing


==================================================================
			Overview
==================================================================

The objective of this project is to create an R script to collect, compile, and summarize data into a tidy format; well suited for further analysis.  This document serves as a codebook to describe the process and variables as they relate to the stated project objective. 

The data for the project were collected from a study conducted using accelerometers from the Samsung Galaxy S smartphone, (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The raw data files collected are located here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

==================================================================
			Variables
==================================================================


- Volunteer Subjects: 

30 anonymous persons identified only by numbers 1-30. 

- Activities Performed: 
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

- Activity Data Gathered:
The accelerometer data is captured in 3-axial angular velocity, with each axis identified by either x,y, or z.
 The base measures either time (t) or frequency (f)
The signals were used to estimate the Acceleration features:
Gravity 
Gyro
Jerk
Magnitude
From these signals, estimates are collected in the data:
Data

-RowId:
A unique identifier that is common across the original data files was preserved for joining purposes only.  For example,  the SubjectCode rowId can be used to link to the activity performed. 

-SubjectCode:
Volunteers are identified only by a number from 1-30

-ActivityLabel: 
This field is used to identify which of the six activities (listed above) a subject performed during the measurement.  

- Measurement Fields:

Only measurements involving a mean or standard deviation were preserved from the original data files in the tidy data.  
The average of each of these measures was calculated:

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
  "frequencyBodyGyroJerkMagnitude_StandardDeviation"


==================================================================
			Transformations
==================================================================


-Verbosity

The original data field names were replaced by more descriptive names.  
t ?  time
f ? frequency
mean() ?  mean
std() ?  standardDeviation
Mag ?  Magnitude
Acc ?  Acceleration
Freq ?  Frequency

