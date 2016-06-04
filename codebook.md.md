
## Getting and Cleaning Data Codebook

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

### Variable Descriptions

`activityTest`  = "test/Y_test.txt"
`activityTrain` = "train/Y_train.txt"
`subjectTest`  = "test/subject_test.txt"
`subjectTrain` = "train/subject_train.txt"
`featuresTest`  = "test/X_test.txt"
`featuresTrain` = "train/X_train.txt"
`activityLabels` = "activity_labels.txt"
`featuresNames` = "features.txt"
`subject` row binds `subjectTrain` & `subjectTest`
`activity` row binds `activityTrain` & `activityTest`
`features` row binds `featuresTrain` & `featuresTest`
`answer1` is the merged training and tests sets into one dataset.
`answer2` is the same dataset but with only the mean and SD columns extracted.
`answer3` has had the activity column updated with descriptive activity names.
`answer4` has had the variable names updated to be more descriptive (eg "f" changed to "frequency")
`answer5` is the completed tidy dataset with the average of each variable for each activity and subject.
