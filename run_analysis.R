# merge the training and test sets to create one data set
# extract measurements on the mean and standard deviation for each measurement
# add descriptive activity names for each activity in the dataset
# Label the data with descriptive variable names
# Create a second (derivative) data set with the avg of each variable for each
# activity and subject

setwd("~/Dropbox/EDC/coursera/gettingAndCleaningData/project/data/")
# First load in training data from the "train" directory 

xTrain <- read.table("./train/X_train.txt", header = FALSE,
                  sep = "", 
                  quote = "", #by disabling quoting, we can load apostrophes
                  dec = ".",
                  na.strings = "NA",
                  check.names = TRUE,
                  strip.white = FALSE,
                  flush = FALSE,
                  stringsAsFactors = FALSE)

# subset data to only keep the values dealing with means and standard deviations
# in the training data

xTrain <- xTrain[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,516:517,526,529:530,539,542:543,552,556:558,559:561)]


#let's verify the data loaded by looking at the first few records
head(xTrain, n=3)

#now we load in id numbers for each of the training rows
#These are kept in the subject_train.txt files

subjectTrain <- read.table("./train/subject_train.txt", header = FALSE,
                     sep = "", 
                     quote = "", #by disabling quoting, we can load apostrophes
                     dec = ".",
                     na.strings = "NA",
                     check.names = TRUE,
                     strip.white = FALSE,
                     flush = FALSE,
                     stringsAsFactors = FALSE)

#let's verify the data loaded by looking at the first few records
head(subjectTrain, n=3)

#now we load in activity codes from y_train.txt for each of the training rows

yTrain <- read.table("./train/y_train.txt", header = FALSE,
                           sep = "", 
                           quote = "", #by disabling quoting, we can load apostrophes
                           dec = ".",
                           na.strings = "NA",
                           check.names = TRUE,
                           strip.white = FALSE,
                           flush = FALSE,
                           stringsAsFactors = FALSE)

#let's verify the data loaded by looking at the first few records
head(yTrain, n=3)

# We now have all of the training data loaded.  Time to bring these three files
# into a single data frame before merging with the test data. We'll put 
# subject numbers first (subjectTrain) followed by the activity codes (yTrain).
# Finally we'll add the data for each subject, activity by bind the data columns
# in XTrain.

train.df <- cbind(subjectTrain,yTrain)
train.df <- cbind(train.df,xTrain)

# The variable names for the subjects (column1) and activities (column2) need
# to labeled in train.df - we do this now and we add descriptive variable
# names for the columns 

names(train.df) <- c("id","activity","tBodyAcc-mean()-X","tBodyAcc-mean()-Y",
                     "tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y",
                     "tBodyAcc-std()-Z","tGravityAcc-mean()-X",
                     "tGravityAcc-mean()-Y","tGravityAcc-mean()-Z",
                     "tGravityAcc-std()-X","tGravityAcc-std()-Y",
                     "tGravityAcc-std()-Z","tBodyAccJerk-mean()-X",
                     "tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z",
                     "tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y",
                     "tBodyAccJerk-std()-Z","tBodyGyro-mean()-X",
                     "tBodyGyro-mean()-Y","tBodyGyro-mean()-Z",
                     "tBodyGyro-std()-X","tBodyGyro-std()-Y",
                     "tBodyGyro-std()-Z","tBodyGyroJerk-mean()-X",
                     "tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z",
                     "tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y",
                     "tBodyGyroJerk-std()-Z","tBodyAccMag-mean()",
                     "tBodyAccMag-std()","tGravityAccMag-mean()",
                     "tGravityAccMag-std()","tBodyAccJerkMag-mean()",
                     "tBodyAccJerkMag-std()","tBodyGyroMag-mean()",
                     "tBodyGyroMag-std()","tBodyGyroJerkMag-mean()",
                     "tBodyGyroJerkMag-std()","fBodyAcc-mean()-X",
                     "fBodyAcc-mean()-Y","fBodyAcc-mean()-Z","fBodyAcc-std()-X",
                     "fBodyAcc-std()-Y","fBodyAcc-std()-Z",
                     "fBodyAcc-meanFreq()-X","fBodyAcc-meanFreq()-Y",
                     "fBodyAcc-meanFreq()-Z","fBodyAccJerk-mean()-X",
                     "fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z",
                     "fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y",
                     "fBodyAccJerk-std()-Z","fBodyAccJerk-meanFreq()-X",
                     "fBodyAccJerk-meanFreq()-Y","fBodyAccJerk-meanFreq()-Z",
                     "fBodyGyro-mean()-X","fBodyGyro-mean()-Y",
                     "fBodyGyro-mean()-Z","fBodyGyro-std()-X",
                     "fBodyGyro-std()-Y","fBodyGyro-std()-Z",
                     "fBodyGyro-meanFreq()-X","fBodyGyro-meanFreq()-Y",
                     "fBodyGyro-meanFreq()-Z","fBodyAccMag-mean()",
                     "fBodyAccMag-std()","fBodyBodyAccJerkMag-mean()",
                     "fBodyBodyAccJerkMag-std()",
                     "fBodyBodyAccJerkMag-meanFreq()","fBodyBodyGyroMag-mean()",
                     "fBodyBodyGyroMag-std()","fBodyBodyGyroMag-meanFreq()",
                     "fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()",
                     "fBodyBodyGyroJerkMag-meanFreq()",
                     "angle(tBodyAccJerkMean),gravityMean)",
                     "angle(tBodyGyroMean,gravityMean)",
                     "angle(tBodyGyroJerkMean,gravityMean)",
                     "angle(X,gravityMean)","angle(Y,gravityMean)",
                     "angle(Z,gravityMean)")


# We should also add an indicator variable (test.df$source) that lets the user 
# know that this observation comes from the training data set
train.df$source <- 1

# We have our training data frame complete- we remove the files from memory to 
# save space and then start loading the test data

rm(subjectTrain)
rm(yTrain)
rm(xTrain)

# Now we repeat the steps above to load the test data

# First load in test data (X_test) from the "test" directory 

xTest <- read.table("./test/X_test.txt", header = FALSE,
                     sep = "", 
                     quote = "", #by disabling quoting, we can load apostrophes
                     dec = ".",
                     na.strings = "NA",
                     check.names = TRUE,
                     strip.white = FALSE,
                     flush = FALSE,
                     stringsAsFactors = FALSE)

# subset data to only keep the values dealing with means and standard deviations
# in the test data
xTest <- xTest[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,516:517,526,529:530,539,542:543,552,556:558,559:561)]



#let's verify the data loaded by looking at the first few records
head(xTest, n=3)

#now we load in id numbers for each of the test rows

subjectTest <- read.table("./test/subject_test.txt", header = FALSE,
                           sep = "", 
                           quote = "", #by disabling quoting, we can load apostrophes
                           dec = ".",
                           na.strings = "NA",
                           check.names = TRUE,
                           strip.white = FALSE,
                           flush = FALSE,
                           stringsAsFactors = FALSE)

#let's verify the data loaded by looking at the first few records
head(subjectTest, n=3)

#now we load in activity codes for each of the test rows

yTest <- read.table("./test/y_test.txt", header = FALSE,
                     sep = "", 
                     quote = "", #by disabling quoting, we can load apostrophes
                     dec = ".",
                     na.strings = "NA",
                     check.names = TRUE,
                     strip.white = FALSE,
                     flush = FALSE,
                     stringsAsFactors = FALSE)

#let's verify the data loaded by looking at the first few records
head(yTest, n=3)

# We now have all of the test data loaded.  Time to bring these three files
# into a single data frame before merging with the training data. We'll put 
# subject numbers first (subjectTest) followed by the activity codes (yTest).
# Finally we'll add the data for each subject, activity by bind the data columns
# in XTest.

test.df <- cbind(subjectTest,yTest)
test.df <- cbind(test.df,xTest)

# The variable names for the subjects (column1) and activities (column2) need
# to labeled in test.df - we do this now


names(test.df) <- c("id","activity","tBodyAcc-mean()-X","tBodyAcc-mean()-Y",
                    "tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y",
                    "tBodyAcc-std()-Z","tGravityAcc-mean()-X",
                    "tGravityAcc-mean()-Y","tGravityAcc-mean()-Z",
                    "tGravityAcc-std()-X","tGravityAcc-std()-Y",
                    "tGravityAcc-std()-Z","tBodyAccJerk-mean()-X",
                    "tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z",
                    "tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y",
                    "tBodyAccJerk-std()-Z","tBodyGyro-mean()-X",
                    "tBodyGyro-mean()-Y","tBodyGyro-mean()-Z",
                    "tBodyGyro-std()-X","tBodyGyro-std()-Y",
                    "tBodyGyro-std()-Z","tBodyGyroJerk-mean()-X",
                    "tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z",
                    "tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y",
                    "tBodyGyroJerk-std()-Z","tBodyAccMag-mean()",
                    "tBodyAccMag-std()","tGravityAccMag-mean()",
                    "tGravityAccMag-std()","tBodyAccJerkMag-mean()",
                    "tBodyAccJerkMag-std()","tBodyGyroMag-mean()",
                    "tBodyGyroMag-std()","tBodyGyroJerkMag-mean()",
                    "tBodyGyroJerkMag-std()","fBodyAcc-mean()-X",
                    "fBodyAcc-mean()-Y","fBodyAcc-mean()-Z","fBodyAcc-std()-X",
                    "fBodyAcc-std()-Y","fBodyAcc-std()-Z",
                    "fBodyAcc-meanFreq()-X","fBodyAcc-meanFreq()-Y",
                    "fBodyAcc-meanFreq()-Z","fBodyAccJerk-mean()-X",
                    "fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z",
                    "fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y",
                    "fBodyAccJerk-std()-Z","fBodyAccJerk-meanFreq()-X",
                    "fBodyAccJerk-meanFreq()-Y","fBodyAccJerk-meanFreq()-Z",
                    "fBodyGyro-mean()-X","fBodyGyro-mean()-Y",
                    "fBodyGyro-mean()-Z","fBodyGyro-std()-X",
                    "fBodyGyro-std()-Y","fBodyGyro-std()-Z",
                    "fBodyGyro-meanFreq()-X","fBodyGyro-meanFreq()-Y",
                    "fBodyGyro-meanFreq()-Z","fBodyAccMag-mean()",
                    "fBodyAccMag-std()","fBodyBodyAccJerkMag-mean()",
                    "fBodyBodyAccJerkMag-std()",
                    "fBodyBodyAccJerkMag-meanFreq()",
                    "fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()",
                    "fBodyBodyGyroMag-meanFreq()","fBodyBodyGyroJerkMag-mean()",
                    "fBodyBodyGyroJerkMag-std()",
                    "fBodyBodyGyroJerkMag-meanFreq()",
                    "angle(tBodyAccJerkMean),gravityMean)",
                    "angle(tBodyGyroMean,gravityMean)",
                    "angle(tBodyGyroJerkMean,gravityMean)",
                    "angle(X,gravityMean)","angle(Y,gravityMean)",
                    "angle(Z,gravityMean)")

# We should also add an indicator variable (test.df$source) that lets the user 
# know that this observation comes from the test data set - 
test.df$source <- 2

# At this point our test and train data are both in data frames and are ready
# to merge to create one data set named "har.df" (har - human activity 
# recognition data frame).  The columns are all identical and test 
# and train are labeled so we use rbind() for the merge

har.df <- rbind(train.df, test.df)


# let's create a labeled factor for the activities (activity) in the merged file

har.df$activity.ftr <- factor(har.df$activity,
    levels = c(1,2,3,4,5,6),
    labels = c("walking", "walking_upstairs", "walking_downstairs","sitting",
    "standing","laying"))

# we want to create a tidy data frame with the mean of each of the measures by
# user id the dataset.  The plyr library offers a way to subset on id and 
# activity (.(id,activity.ftr)) and calculate the mean (numcolwise(mean)) for 
# each group. We generate a new dataframe (tidyHar.df) for these data 

library(plyr)
head(ddply(har.df, .(id,activity.ftr), numcolwise(mean)))
tidyHar.df <- ddply(har.df, .(id,activity.ftr), numcolwise(mean))

#Now that we have a tidy dataset organized by id and activity, we rename the 
# columns to reflect that we have the mean of each value in the dataset.

names(tidyHar.df) <- c("id","activity","mean(tBodyAcc-mean()-X)",
                    "mean(tBodyAcc-mean()-Y)",
                    "mean(tBodyAcc-mean()-Z)","mean(tBodyAcc-std()-X)",
                    "mean(tBodyAcc-std()-Y)",
                    "mean(tBodyAcc-std()-Z)",
                    "mean(tGravityAcc-mean()-X)",
                    "mean(tGravityAcc-mean()-Y)","mean(tGravityAcc-mean()-Z)",
                    "mean(tGravityAcc-std()-X)","mean(tGravityAcc-std()-Y)",
                    "mean(tGravityAcc-std()-Z)","mean(tBodyAccJerk-mean()-X)",
                    "mean(tBodyAccJerk-mean()-Y)","mean(tBodyAccJerk-mean()-Z)",
                    "mean(tBodyAccJerk-std()-X)","mean(tBodyAccJerk-std()-Y)",
                    "mean(tBodyAccJerk-std()-Z)","mean(tBodyGyro-mean()-X)",
                    "mean(tBodyGyro-mean()-Y)","mean(tBodyGyro-mean()-Z)",
                    "mean(tBodyGyro-std()-X)","mean(tBodyGyro-std()-Y)",
                    "mean(tBodyGyro-std()-Z)","mean(tBodyGyroJerk-mean()-X)",
                    "mean(tBodyGyroJerk-mean()-Y)","mean(tBodyGyroJerk-mean()-Z)",
                    "mean(tBodyGyroJerk-std()-X)","mean(tBodyGyroJerk-std()-Y)",
                    "mean(tBodyGyroJerk-std()-Z)","mean(tBodyAccMag-mean())",
                    "mean(tBodyAccMag-std())","mean(tGravityAccMag-mean())",
                    "mean(tGravityAccMag-std())","mean(tBodyAccJerkMag-mean())",
                    "mean(tBodyAccJerkMag-std())","mean(tBodyGyroMag-mean())",
                    "mean(tBodyGyroMag-std())","mean(tBodyGyroJerkMag-mean())",
                    "mean(tBodyGyroJerkMag-std())","mean(fBodyAcc-mean()-X)",
                    "mean(fBodyAcc-mean()-Y)","mean(fBodyAcc-mean()-Z)",
                    "mean(fBodyAcc-std()-X)",
                    "mean(fBodyAcc-std()-Y)","mean(fBodyAcc-std()-Z)",
                    "mean(fBodyAcc-meanFreq()-X)","mean(fBodyAcc-meanFreq()-Y)",
                    "mean(fBodyAcc-meanFreq()-Z)","mean(fBodyAccJerk-mean()-X)",
                    "mean(fBodyAccJerk-mean()-Y)","mean(fBodyAccJerk-mean()-Z)",
                    "mean(fBodyAccJerk-std()-X)","mean(fBodyAccJerk-std()-Y)",
                    "mean(fBodyAccJerk-std()-Z)","mean(fBodyAccJerk-meanFreq()-X)",
                    "mean(fBodyAccJerk-meanFreq()-Y)","mean(fBodyAccJerk-meanFreq()-Z)",
                    "mean(fBodyGyro-mean()-X)","mean(fBodyGyro-mean()-Y)",
                    "mean(fBodyGyro-mean()-Z)","mean(fBodyGyro-std()-X)",
                    "mean(fBodyGyro-std()-Y)","mean(fBodyGyro-std()-Z)",
                    "mean(fBodyGyro-meanFreq()-X)","mean(fBodyGyro-meanFreq()-Y)",
                    "mean(fBodyGyro-meanFreq()-Z)","mean(fBodyAccMag-mean())",
                    "mean(fBodyAccMag-std())","mean(fBodyBodyAccJerkMag-mean())",
                    "mean(fBodyBodyAccJerkMag-std())",
                    "mean(fBodyBodyAccJerkMag-meanFreq())",
                    "mean(fBodyBodyGyroMag-mean())","mean(fBodyBodyGyroMag-std())",
                    "mean(fBodyBodyGyroMag-meanFreq())","mean(fBodyBodyGyroJerkMag-mean())",
                    "mean(fBodyBodyGyroJerkMag-std())",
                    "mean(fBodyBodyGyroJerkMag-meanFreq())",
                    "mean(angle(tBodyAccJerkMean),gravityMean))",
                    "mean(angle(tBodyGyroMean,gravityMean))",
                    "mean(angle(tBodyGyroJerkMean,gravityMean))",
                    "mean(angle(X,gravityMean))","mean(angle(Y,gravityMean))",
                    "mean(angle(Z,gravityMean))")


# Now we create a text file of the data in tidyHar.df so that others can see the
# tidy dataframe (tidy.txt).  We went with the wide format of the data, I though
# about creating a long version- but I'd have to duplicate data in a column which
# wouldn't be tidy...

tidy.txt <- write.table(tidyHar.df,file="tidy.txt",sep="\t", row.names=FALSE)
