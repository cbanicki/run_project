==================================================================
Run_Analysis.R - tidy data set for 'Getting and Cleaning Data', 
an online course offerred by Johns Hopkins, Bloomberg School of Public Health.
Version 1.0
==================================================================
Chad Banicki
chad.banicki@gmail.com
==================================================================


==================================================================
			Bacground
==================================================================

30 volunteers performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone equiped with an accelerometer and gyroscope.  Among the data collected, are mean and standard deviation values for numerous 
activity variables that include Acceleration, Gyro, and Jerk by both time and frequency. 

As a simple explanation, acceleration is akin to body movement (velocity) change rate, body jerk (aka jolt) is a derivative of acceleration, i.e. the rate of change of acceleration, and gyro is a body rotation measurment.

A description of the experiment, as well as data collectedare publicly available and can be found at the links below:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



==================================================================
			Objective
==================================================================

While all of the data are avaiable, they are spread accross multiple files and folders.  The objective of this script is to assimilate a number of disparate data files into a single, tidy data set, which better lends itself to summary and analysis.

The objective of this script, taken from the project assignment:

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



==================================================================
			Performance
==================================================================



This script is a single function taking no arguments that will:

1) Gather data files from a public website.

2) Download them to the working directory on your computer.

3) Clean the data files by consolidating them into a single table and adding descriptive headers. 

4) Create a tidy data set summarizing the data by Volunteer Subject Number, Volunteer Activity, and mean and standard deviation values for activity measurements.


==================================================================
			Output
==================================================================

The output of the script will produce a .txt file (975119_getdata-035.txt) that is space delimited. 



Notes: 
======
- While likely open for interpretation; for this script, the 'Mean' and 'Standard Deviation' variables were broadly defined as any measurment variable containing either 'mean' or 'std'.  For example, fields like fBodyAccMag-mean()
and fBodyAccMag-std() were included, but so were fields like fBodyAccMag-meanFreq(); even though they don't explicitly end in -mean().  An exception to this are fields like angle(X,gravityMean), as they might be considered an angle measurments.   
