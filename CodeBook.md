---
title: "Codebook"
output: html_document
---

## UCI HAR Dataset

Dataset available in <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones</a>

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


The original dataset contains data from accelerometer and gyroscope 3-axial signal (X, Y and Z). Data were captured at a constant rate of 50 Hz. These are the time domain features and contain the 't' prefix (e.g. tAcc-XYZ, tGyro-XYZ).

These signals were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. In addition, the authors of the original dataset separated the acceleration signal into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). The magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Frequency domain features were also obtained by using Fast Fourier Transform (FFT). FFT was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. Frequency domain features contain the 'f' prefix.




## Steps to obtain the tidy dataset

1. Merged the training and the test sets to create one single dataset in one table. This is done as Figure 1 shows (note that data in 'Inertial Signals' folder were not used).

![Merged dataset.](Figure.png) 

2. Extracted only the measurements on the mean and standard deviation for each measurement. Only features with "-mean(" or "-std(" are considered valid here (e.g. "tBodyAcc-mean()-X", "tBodyAcc-std()").  So, fBodyBodyGyroJerkMag-meanFreq() or angle(tBodyAccMean,gravity) were NOT considered. This was done because these other measurements with "mean" does not have a "std" counterpart.

3. Changed activity numeric values (1-6) to factor values ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING").

4. Included labels on all features (names on features.txt were used)

5. Calculated the mean of all features by SubjectID and Activity. All features now are the averages values. In order to emphasize that, they are identified as "[MEAN]".

Finally, the dataset was exported to CSV format (separator = ","). Script "run_analysis.R" perform all these steps on the original dataset provided by the authors.



## The Tidy Dataset

Each record contains:

<b>SubjectID</b>: type:numeric - Identifier of the subject

<b>Activity</b>: type:factor - Identifier of the activity, may assume one of the following:

* WALKING

* WALKING_UPSTAIRS

* WALKING_DOWNSTAIRS

* SITTING

* STANDING

* LAYING

Additionally, the tidy dataset contains the MEAN of each of the following attributes by SubjectID and Activity:

<font color="red">
<i>IMPORTANT 1: in the dataset, all columns are identified with "[MEAN]" to emphasize it is the mean that is being reported.</i>

<i>IMPORTANT 2: features were normalized and bounded within [-1;1] in the original dataset. As this tidy dataset just averaged values from the original one, it is also bounded within [-1;1].</i>
</font>

<b>tBodyAcc-mean()-X [MEAN]</b> type:numeric

<b>tBodyAcc-mean()-Y [MEAN]</b> type:numeric

<b>tBodyAcc-mean()-Z [MEAN]</b> type:numeric

<b>tBodyAcc-std()-X [MEAN]</b> type:numeric

<b>tBodyAcc-std()-Y [MEAN]</b> type:numeric

<b>tBodyAcc-std()-Z [MEAN]</b> type:numeric


<b>tGravityAcc-mean()-X [MEAN]</b> type:numeric

<b>tGravityAcc-mean()-Y [MEAN]</b> type:numeric

<b>tGravityAcc-mean()-Z [MEAN]</b> type:numeric

<b>tGravityAcc-std()-X [MEAN]</b> type:numeric

<b>tGravityAcc-std()-Y [MEAN]</b> type:numeric

<b>tGravityAcc-std()-Z [MEAN]</b> type:numeric



<b>tBodyAccJerk-mean()-X [MEAN]</b> type:numeric

<b>tBodyAccJerk-mean()-Y [MEAN]</b> type:numeric

<b>tBodyAccJerk-mean()-Z [MEAN]</b> type:numeric

<b>tBodyAccJerk-std()-X [MEAN]</b> type:numeric

<b>tBodyAccJerk-std()-Y [MEAN]</b> type:numeric

<b>tBodyAccJerk-std()-Z [MEAN]</b> type:numeric


<b>tBodyGyro-mean()-X [MEAN]</b> type:numeric

<b>tBodyGyro-mean()-Y [MEAN]</b> type:numeric

<b>tBodyGyro-mean()-Z [MEAN]</b> type:numeric

<b>tBodyGyro-std()-X [MEAN]</b> type:numeric

<b>tBodyGyro-std()-Y [MEAN]</b> type:numeric

<b>tBodyGyro-std()-Z [MEAN]</b> type:numeric


<b>tBodyGyroJerk-mean()-X [MEAN]</b> type:numeric

<b>tBodyGyroJerk-mean()-Y [MEAN]</b> type:numeric

<b>tBodyGyroJerk-mean()-Z [MEAN]</b> type:numeric

<b>tBodyGyroJerk-std()-X [MEAN]</b> type:numeric

<b>tBodyGyroJerk-std()-Y [MEAN]</b> type:numeric

<b>tBodyGyroJerk-std()-Z [MEAN]</b> type:numeric


<b>tBodyAccMag-mean() [MEAN]</b> type:numeric

<b>tBodyAccMag-std() [MEAN]</b> type:numeric


<b>tGravityAccMag-mean() [MEAN]</b> type:numeric

<b>tGravityAccMag-std() [MEAN]</b> type:numeric


<b>tBodyAccJerkMag-mean() [MEAN]</b> type:numeric

<b>tBodyAccJerkMag-std() [MEAN]</b> type:numeric


<b>tBodyGyroMag-mean() [MEAN]</b> type:numeric

<b>tBodyGyroMag-std() [MEAN]</b> type:numeric


<b>tBodyGyroJerkMag-mean() [MEAN]</b> type:numeric

<b>tBodyGyroJerkMag-std() [MEAN]</b> type:numeric


<b>fBodyAcc-mean()-X [MEAN]</b> type:numeric

<b>fBodyAcc-mean()-Y [MEAN]</b> type:numeric

<b>fBodyAcc-mean()-Z [MEAN]</b> type:numeric

<b>fBodyAcc-std()-X [MEAN]</b> type:numeric

<b>fBodyAcc-std()-Y [MEAN]</b> type:numeric

<b>fBodyAcc-std()-Z [MEAN]</b> type:numeric


<b>fBodyAccJerk-mean()-X [MEAN]</b> type:numeric

<b>fBodyAccJerk-mean()-Y [MEAN]</b> type:numeric

<b>fBodyAccJerk-mean()-Z [MEAN]</b> type:numeric

<b>fBodyAccJerk-std()-X [MEAN]</b> type:numeric

<b>fBodyAccJerk-std()-Y [MEAN]</b> type:numeric

<b>fBodyAccJerk-std()-Z [MEAN]</b> type:numeric


<b>fBodyGyro-mean()-X [MEAN]</b> type:numeric

<b>fBodyGyro-mean()-Y [MEAN]</b> type:numeric

<b>fBodyGyro-mean()-Z [MEAN]</b> type:numeric

<b>fBodyGyro-std()-X [MEAN]</b> type:numeric

<b>fBodyGyro-std()-Y [MEAN]</b> type:numeric

<b>fBodyGyro-std()-Z [MEAN]</b> type:numeric


<b>fBodyAccMag-mean() [MEAN]</b> type:numeric

<b>fBodyAccMag-std() [MEAN]</b> type:numeric


<b>fBodyBodyAccJerkMag-mean() [MEAN]</b> type:numeric

<b>fBodyBodyAccJerkMag-std() [MEAN]</b> type:numeric


<b>fBodyBodyGyroMag-mean() [MEAN]</b> type:numeric

<b>fBodyBodyGyroMag-std() [MEAN]</b> type:numeric


<b>fBodyBodyGyroJerkMag-mean() [MEAN]</b> type:numeric

<b>fBodyBodyGyroJerkMag-std() [MEAN]</b> type:numeric