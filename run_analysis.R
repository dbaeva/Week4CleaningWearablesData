#Background
##What is an An accelerometer?
#####Wikipedia:It is a tool that measures proper acceleration.[1] Proper acceleration is the acceleration (the rate of change of velocity) of a body in
#####its own instantaneous rest frame;[2] this is different from coordinate acceleration, which is acceleration in a fixed coordinate system.
##### For example, an accelerometer at rest on the surface of the Earth will measure an acceleration due to Earth's gravity, straight upwards[3]
#####(by definition) of g ??? 9.81 m/s2. By contrast, accelerometers in free fall (falling toward the center of the Earth at a rate of about 9.81 m/s2) 
##### will measure zero.
#####Wikipedia: Accelerometer and gyroscope?
#####Accelerometers in mobile phones are used to detect the orientation of the phone. The gyroscope, or gyro for short, adds an additional 
#####dimension to the information supplied by the accelerometer by tracking rotation or twist

##load needed libraries
library(data.table)
library(stringr)


#Goal 1: Merges the training and the test sets to create one data set.

##Step 1: download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){ 
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata_projectfiles_UCI HAR Dataset.zip")
}

##Step 2: Unzip the file, put an if statement based on the name from list.files()/ list.files('UCI HAR Dataset/') so this doesn't get unzipped every time
if (!dir.exists("UCI HAR Dataset")){ 
  unzip("getdata_projectfiles_UCI HAR Dataset.zip")
}

##Step 3: Load the data from each of the files into a data table , load the library just in case , ang give the meanigful column names

###Activity Labels 
activityLabels<- read.table("UCI HAR Dataset/activity_labels.txt",sep= " ", header=FALSE, na.strings="NA" )
colnames(activityLabels) <- c('activity_code','activity_description')
###Features 
features<-read.table("UCI HAR Dataset/features.txt", header=FALSE, na.strings="NA" )

###TestFiles


###TrainingFiles
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", sep = " ",  header=FALSE, na.strings="NA" )
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt", sep = " ",  header=FALSE, na.strings="NA" )

###Test Files 
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", sep = " ",  header=FALSE, na.strings="NA" )
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt", sep = " ",  header=FALSE, na.strings="NA" )

###FYI
###dim(x_test)
###[1] 2947  561
###> dim(x_train)
###[1] 7352  561
###> dim(y_test)
###[1] 2947    1
###> dim(y_train)
###[1] 7352    1
###> dim(subject_train)
###[1] 7352    1
###> dim(subject_test)
###[1] 2947    1

##create 2 new tables for test and train  and then rbind them , but before that add activity code decoding 
y_test_with_activity_name <-merge(x=y_test, y=activityLabels, by.x='V1', by.y='activity_code', fill='Activity Name Not Available')
y_train_with_activity_name <-merge(x=y_train, y=activityLabels, by.x='V1', by.y='activity_code', fill='Activity Name Not Available')

testData <- data.table(subject_test, y_test_with_activity_name , x_test)
trainData <-data.table(subject_train, y_train_with_activity_name, x_train) 
completeSet <-rbind(testData,trainData) 


#Goal 3: Uses descriptive activity names to name the activities in the data set.
##getting clean column names, first everything to lowere
mapping<-data.table(features$V1,features$V2,sapply(features$V2,function(n){  tolower(str_replace_all(n,'[^A-z0-9]','')) } ))
columnList<-c(c('subjectnumber','activitycode','activityname'),mapping$V3)


#Goal 4: Appropriately labels the data set with descriptive variable names.
##Assign the Column Names 
colnames(completeSet)<-columnList

head(completeSet)

#Goal 2: Extracts only the measurements on the mean and standard deviation for each measurement.
columnListToExtract <-c(c('subjectnumber','activitycode','activityname'),grep('standard', columnList, value=TRUE),grep('std', columnList, value=TRUE)) 
completeSetOnlyWithMeanAndStd<- data.table(completeSet$subjectnumber, 			 completeSet$activitycode,            completeSet$activityname,            completeSet$tbodyaccstdx,           completeSet$tbodyaccstdy,            completeSet$tbodyaccstdz,            completeSet$tgravityaccstdx,         completeSet$tgravityaccstdy,        completeSet$tgravityaccstdz,         completeSet$tbodyaccjerkstdx,        completeSet$tbodyaccjerkstdy,        completeSet$tbodyaccjerkstdz,       completeSet$tbodygyrostdx,           completeSet$tbodygyrostdy,           completeSet$tbodygyrostdz,           completeSet$tbodygyrojerkstdx,      completeSet$tbodygyrojerkstdy,       completeSet$tbodygyrojerkstdz,       completeSet$tbodyaccmagstd,          completeSet$tgravityaccmagstd,      completeSet$tbodyaccjerkmagstd,      completeSet$tbodygyromagstd,         completeSet$tbodygyrojerkmagstd,     completeSet$fbodyaccstdx,           completeSet$fbodyaccstdy,            completeSet$fbodyaccstdz,            completeSet$fbodyaccjerkstdx,        completeSet$fbodyaccjerkstdy,       completeSet$fbodyaccjerkstdz,        completeSet$fbodygyrostdx,           completeSet$fbodygyrostdy,           completeSet$fbodygyrostdz,          completeSet$fbodyaccmagstd,          completeSet$fbodybodyaccjerkmagstd,  completeSet$fbodybodygyromagstd,     completeSet$fbodybodygyrojerkmagstd)
colnames(completeSetOnlyWithMeanAndStd)<-columnListToExtract


#Goal 5: From the data set in step 4, creates a second, independent tidy data set with the average of each VARIABLE for each ACTIVITY and each SUBJECT
### Definitions
#### variable; "a variable is one of the 561 columns in the two data sets, test and training.
#### Some of these variables are means, others are standard deviations, and still others measure things other than means or standard deviations."
aggregateBySubjectActivityName<-aggregate(.~subjectnumber+activitycode+activityname, completeSetOnlyWithMeanAndStd, mean)


#Goal 6: Write it to a csv file 
write.table(aggregateBySubjectActivityName,file='aggregateBySubjectActivityName.txt', sep = " ",  row.name=FALSE )
