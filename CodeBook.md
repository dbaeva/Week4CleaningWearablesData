How columns were Derived?

##load needed libraries
#Goal 1: Merges the training and the test sets to create one data set.
##Step 1: download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##Step 2: Unzip the file, put an if statement based on the name from list.files()/ list.files('UCI HAR Dataset/') so this doesn't get unzipped every time
##Step 3: Load the data from each of the files into a data table , load the library just in case , ang give the meanigful column names
##create 2 new tables for test and train  and then rbind them , but before that add activity code decoding 
#Goal 3: Uses descriptive activity names to name the activities in the data set.
##getting clean column names, first everything to lower cawse and then replace all not a-z0-9 characters 
#Goal 4: Appropriately labels the data set with descriptive variable names.
##Assign the Column Names from Goal 3 
#Goal 2: Extracts only the measurements on the mean and standard deviation for each measurement.
##Grep the column names with dev/std then manually create a new table only with those columns 
#Goal 5: From the data set in step 4, creates a second, independent tidy data set with the average of each VARIABLE for each ACTIVITY and each SUBJECT
#Use aggregate function  to group by subject and activity name to find the average 
#Goal 6: Write it to a csv file 


column_name	column description 
subject	# a number 1 30 labeling subject
activity_code	Number Mapepd to activity description 
activity_description	Something like Walking
tbodyaccmeanx	tBodyAcc-mean()-X
tbodyaccmeany	tBodyAcc-mean()-Y
tbodyaccmeanz	tBodyAcc-mean()-Z
tbodyaccstdx	tBodyAcc-std()-X
tbodyaccstdy	tBodyAcc-std()-Y
tbodyaccstdz	tBodyAcc-std()-Z
tgravityaccmeanx	tGravityAcc-mean()-X
tgravityaccmeany	tGravityAcc-mean()-Y
tgravityaccmeanz	tGravityAcc-mean()-Z
tgravityaccstdx	tGravityAcc-std()-X
tgravityaccstdy	tGravityAcc-std()-Y
tgravityaccstdz	tGravityAcc-std()-Z
tbodyaccjerkmeanx	tBodyAccJerk-mean()-X
tbodyaccjerkmeany	tBodyAccJerk-mean()-Y
tbodyaccjerkmeanz	tBodyAccJerk-mean()-Z
tbodyaccjerkstdx	tBodyAccJerk-std()-X
tbodyaccjerkstdy	tBodyAccJerk-std()-Y
tbodyaccjerkstdz	tBodyAccJerk-std()-Z
tbodygyromeanx	tBodyGyro-mean()-X
tbodygyromeany	tBodyGyro-mean()-Y
tbodygyromeanz	tBodyGyro-mean()-Z
tbodygyrostdx	tBodyGyro-std()-X
tbodygyrostdy	tBodyGyro-std()-Y
tbodygyrostdz	tBodyGyro-std()-Z
tbodygyrojerkmeanx	tBodyGyroJerk-mean()-X
tbodygyrojerkmeany	tBodyGyroJerk-mean()-Y
tbodygyrojerkmeanz	tBodyGyroJerk-mean()-Z
tbodygyrojerkstdx	tBodyGyroJerk-std()-X
tbodygyrojerkstdy	tBodyGyroJerk-std()-Y
tbodygyrojerkstdz	tBodyGyroJerk-std()-Z
tbodyaccmagmean	tBodyAccMag-mean()
tbodyaccmagstd	tBodyAccMag-std()
tgravityaccmagmean	tGravityAccMag-mean()
tgravityaccmagstd	tGravityAccMag-std()
tbodyaccjerkmagmean	tBodyAccJerkMag-mean()
tbodyaccjerkmagstd	tBodyAccJerkMag-std()
tbodygyromagmean	tBodyGyroMag-mean()
tbodygyromagstd	tBodyGyroMag-std()
tbodygyrojerkmagmean	tBodyGyroJerkMag-mean()
tbodygyrojerkmagstd	tBodyGyroJerkMag-std()
fbodyaccmeanx	fBodyAcc-mean()-X
fbodyaccmeany	fBodyAcc-mean()-Y
fbodyaccmeanz	fBodyAcc-mean()-Z
fbodyaccstdx	fBodyAcc-std()-X
fbodyaccstdy	fBodyAcc-std()-Y
fbodyaccstdz	fBodyAcc-std()-Z
fbodyaccmeanfreqx	fBodyAcc-meanFreq()-X
fbodyaccmeanfreqy	fBodyAcc-meanFreq()-Y
fbodyaccmeanfreqz	fBodyAcc-meanFreq()-Z
fbodyaccjerkmeanx	fBodyAccJerk-mean()-X
fbodyaccjerkmeany	fBodyAccJerk-mean()-Y
fbodyaccjerkmeanz	fBodyAccJerk-mean()-Z
fbodyaccjerkstdx	fBodyAccJerk-std()-X
fbodyaccjerkstdy	fBodyAccJerk-std()-Y
fbodyaccjerkstdz	fBodyAccJerk-std()-Z
fbodyaccjerkmeanfreqx	fBodyAccJerk-meanFreq()-X
fbodyaccjerkmeanfreqy	fBodyAccJerk-meanFreq()-Y
fbodyaccjerkmeanfreqz	fBodyAccJerk-meanFreq()-Z
fbodygyromeanx	fBodyGyro-mean()-X
fbodygyromeany	fBodyGyro-mean()-Y
fbodygyromeanz	fBodyGyro-mean()-Z
fbodygyrostdx	fBodyGyro-std()-X
fbodygyrostdy	fBodyGyro-std()-Y
fbodygyrostdz	fBodyGyro-std()-Z
fbodygyromeanfreqx	fBodyGyro-meanFreq()-X
fbodygyromeanfreqy	fBodyGyro-meanFreq()-Y
fbodygyromeanfreqz	fBodyGyro-meanFreq()-Z
fbodyaccmagmean	fBodyAccMag-mean()
fbodyaccmagstd	fBodyAccMag-std()
fbodyaccmagmeanfreq	fBodyAccMag-meanFreq()
fbodybodyaccjerkmagmean	fBodyBodyAccJerkMag-mean()
fbodybodyaccjerkmagstd	fBodyBodyAccJerkMag-std()
fbodybodyaccjerkmagmeanfreq	fBodyBodyAccJerkMag-meanFreq()
fbodybodygyromagmean	fBodyBodyGyroMag-mean()
fbodybodygyromagstd	fBodyBodyGyroMag-std()
fbodybodygyromagmeanfreq	fBodyBodyGyroMag-meanFreq()
fbodybodygyrojerkmagmean	fBodyBodyGyroJerkMag-mean()
fbodybodygyrojerkmagstd	fBodyBodyGyroJerkMag-std()
fbodybodygyrojerkmagmeanfreq	fBodyBodyGyroJerkMag-meanFreq()
angletbodyaccmeangravity	angle(tBodyAccMean,gravity)
angletbodyaccjerkmeangravitymean	angle(tBodyAccJerkMean),gravityMean)
angletbodygyromeangravitymean	angle(tBodyGyroMean,gravityMean)
angletbodygyrojerkmeangravitymean	angle(tBodyGyroJerkMean,gravityMean)
anglexgravitymean	angle(X,gravityMean)
angleygravitymean	angle(Y,gravityMean)
anglezgravitymean	angle(Z,gravityMean)
