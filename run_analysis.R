# Script for processing UCI HAR Dataset. It does the following:
#
# 1. Merges the training and the test sets to create one dataset.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a independent tidy data set with the average of each variable for each activity and each subject.
#
# IMPORTANT: The working directory must the one where the folder "UCI HAR Dataset" is located.
#
# Dataset available in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity 
# Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International 
# Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

#Step 0: Check if files exist
datasetFiles = c("./UCI HAR Dataset/train/X_train.txt",
                 "./UCI HAR Dataset/train/y_train.txt",
                 "./UCI HAR Dataset/train/subject_train.txt",
                 "./UCI HAR Dataset/test/X_test.txt",
                 "./UCI HAR Dataset/test/y_test.txt",
                 "./UCI HAR Dataset/test/subject_test.txt",
                 "./UCI HAR Dataset/features.txt")
for (fileIndex in 1:length(datasetFiles)) {
  if (!file.exists(datasetFiles[fileIndex])) {
    print("The working directory must the one where the folder 'UCI HAR Dataset' is located.")
    stop(paste("File \"", datasetFiles[fileIndex], "\" not found!", sep=""))
  }
}

#Step 1: Merges the training and the test sets to create one dataset.
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F) # all features
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt", header=F) # activity
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F) # subject
train <- cbind(trainSubject, trainY, trainX)

testX <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F) # all features
testY <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F) # activity
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F) # subject
test <- cbind(testSubject, testY, testX)

mergedDS <- rbind(train, test) # merge train and test data


#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# >> It considers that only features with "-mean(" or "-std(" are valid here (e.g. "tBodyAcc-mean()-X", 
# "tBodyAcc-std()").  So, fBodyBodyGyroJerkMag-meanFreq() or angle(tBodyAccMean,gravity) were NOT considered.
features <- read.table("./UCI HAR Dataset/features.txt", header=F)
features <- as.character(features[,2])
mean_and_std_featureIndexes <- grep("-mean\\(|-std\\(", features, ignore.case=T)
mean_and_std_DS <- mergedDS[ , c(1, 2, mean_and_std_featureIndexes + 2)] # Note that mean_and_std_featureIndexes 
                                                                         # starts in 1, but feature indexes start
                                                                         # at 3 in the dataset (because there are 
                                                                         # SubjectID and Activity columns before).
                                                                         # So, I use mean_and_std_featureIndexes 
                                                                         # + 2 here.


#Step 3: Uses descriptive activity names to name the activities in the data set.
mean_and_std_DS[, 2] <- factor(mean_and_std_DS[, 2], labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


#Step 4: Appropriately labels the data set with descriptive variable names.
colnames(mean_and_std_DS)[1] = "SubjectID"
colnames(mean_and_std_DS)[2] = "Activity"
colnames(mean_and_std_DS)[3:(length(mean_and_std_featureIndexes) + 2)] = features[mean_and_std_featureIndexes]


#Step 5: Creates a independent tidy data set with the average of each variable for each activity and each subject.
# >> It uses melt and dcast for doing that. SubjectID and Activity are the IDs for the procedure.
library(reshape2)
meltDS <- melt(mean_and_std_DS, id=c("SubjectID", "Activity"), measure.vars=features[mean_and_std_featureIndexes])
tidyDS <- dcast(meltDS, SubjectID + Activity ~ variable, mean)

# Include "[MEAN]" on all variable names to make it clear that all values are the mean.
colnames(tidyDS)[3:(length(mean_and_std_featureIndexes) + 2)] = paste(features[mean_and_std_featureIndexes], "[MEAN]")

# Save the tidy dataset
write.table(tidyDS, file="UCI_HAR_TidyDataset.txt", row.names=FALSE, sep=",")