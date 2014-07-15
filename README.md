Project: Getting and Cleaning Data Course Project
========================================================
### Content of some important files
  
1. UCI HAR Dataset\features.txt - contain the column heading of the observations found in the following 2 files.
2. UCI HAR Dataset\train\X_train.txt - each row represent a set of reading take from an individual (a subset for training)
3. UCI HAR Dataset\train\subject_train.txt - each row contains the personID.  
That personID also represents that person who generates the corresponding row of data in the X_train.txt file 
4. UCI HAR Dataset\test\X_test.txt - each row represent a set of readings taken from an individual (a subset for testing)
5. UCI HAR Dataset\test\subject_test.txt - each row contains the personID.  
That personID also represents that person who generates the corresponding row of data in the X_test.txt file  


## How the run_analysis.R scripts work.

### Assumption
the UCI HAR zip file is download to a directory name: ("E://courses//jh-dataexplore//ws_get_clean_data//UCI HAR Dataset" - known hereafter as TOPDIR


### input files
dataset from UCI HAR

### output files
two comma delimited (csv) files
tidydetail.txt  -  mean and standard deviation features
tidymean.txt - mean for each feature per person (ie only 30 rows datafile)


(1) To get the selected column Name
- Go to the directory TOPDIR
- From feature.txt file, select the mean and Std column name
- do some cleaning up of the column naming, removing non-alpha character, duplicated naming
  (turn this into some more meaningful naming)
- maintain the camelcase and turn mean, std into UPPERCASE for easy readability
- extract the mean/std column name and the corresponding column psoition and store in 
  temporary dataframe colDerv


(2) Subset training dataset on based column name (mean, std) derived from step above
- go to TOPDIR/train
- read x_train.txt in as a dataframe
- subset training dataframe using the column postion recorded in the temporary dataframe colDerv (per step1)
- Change all the column header of this data subset into something meaninful (ie according to the column name recorded in ColDerv dataframe)
- read the subject_train.txt as a dataframe
- Add a new column (called subject) to the subset.  Insert the value of the personID (from the subject_train.txt) to the subject column
- verify the the insertion of person ID is correct by counting the number of rows from the training subsetted data.


(3) subset testing dataset
-  goto TOPDIR/test
-  repeat similar steps to what was described per step 2 aove.


(4) concatenate the train and testing database
- concatenate them together using rbind() function
- re-arrange the column header such that subject become the first column.  Call this mergeData
- Get the mean of the column for every column per pseron and store that in another frame. (mergeData.avt)


(5) Store the dataframe as comma delimited file
   store mergeData as  file Tidydetail.txt
   store mergeData as  file Tidymean.txt



===========
Code Book

Introduction
The data presented in the dataset below are extracted from UCI "Human Activity Recognition Using Smartphone Dataset".  The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.  It contains data derived from six activities WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).   
 The sensor signals obtained from accelerometer and gyroscope were preprocessed.  In the original dataset, the data were classified into X, Y, Z axis with various summarization such as mean, standard deviation, medium absolute deviation, minimum, maximum, entropy, energy etc., totaling 561 features.

Summarization
This project is to combine the original training and test data into one and extract only those columns containing the mean and standard deviation. This totals 79 columns. An extra column subject is added in order to associate the activity with a particular person.  Thus the subject column has value from 1 to 30 representing the 30 different volunteers.   The rest of the features reading (79 columns) are normalized and bounded within [-1,1].


Column definitions:
The column names are tidied up.  All non-alpha characters are removed.   However camel case is maintained and MEAN and STD are capitalized for easier readability.  These column names are given below.

Column	           Column
Position           Name
1                  subject
2                  tBodyAccMEANX
3                  tBodyAccMEANY
4                  tBodyAccMEANZ
5                   tBodyAccSTDX
6                   tBodyAccSTDY
7                   tBodyAccSTDZ
8               tGravityAccMEANX
9               tGravityAccMEANY
10              tGravityAccMEANZ
11               tGravityAccSTDX
12               tGravityAccSTDY
13               tGravityAccSTDZ
14             tBodyAccJerkMEANX
15             tBodyAccJerkMEANY
16             tBodyAccJerkMEANZ
17              tBodyAccJerkSTDX
18              tBodyAccJerkSTDY
19              tBodyAccJerkSTDZ
20                tBodyGyroMEANX
21                tBodyGyroMEANY
22                tBodyGyroMEANZ
23                 tBodyGyroSTDX
24                 tBodyGyroSTDY
25                 tBodyGyroSTDZ
26            tBodyGyroJerkMEANX
27            tBodyGyroJerkMEANY
28            tBodyGyroJerkMEANZ
29             tBodyGyroJerkSTDX
30             tBodyGyroJerkSTDY
31             tBodyGyroJerkSTDZ
32               tBodyAccMagMEAN
33                tBodyAccMagSTD
34            tGravityAccMagMEAN
35             tGravityAccMagSTD
36           tBodyAccJerkMagMEAN
37            tBodyAccJerkMagSTD
38              tBodyGyroMagMEAN
39               tBodyGyroMagSTD
40          tBodyGyroJerkMagMEAN
41           tBodyGyroJerkMagSTD
42                 fBodyAccMEANX
43                 fBodyAccMEANY
44                 fBodyAccMEANZ
45                  fBodyAccSTDX
46                  fBodyAccSTDY
47                  fBodyAccSTDZ
48             fBodyAccMEANFreqX
49             fBodyAccMEANFreqY
50             fBodyAccMEANFreqZ
51             fBodyAccJerkMEANX
52             fBodyAccJerkMEANY
53             fBodyAccJerkMEANZ
54              fBodyAccJerkSTDX
55              fBodyAccJerkSTDY
56              fBodyAccJerkSTDZ
57         fBodyAccJerkMEANFreqX
58         fBodyAccJerkMEANFreqY
59         fBodyAccJerkMEANFreqZ
60                fBodyGyroMEANX
61                fBodyGyroMEANY
62                fBodyGyroMEANZ
63                 fBodyGyroSTDX
64                 fBodyGyroSTDY
65                 fBodyGyroSTDZ
66            fBodyGyroMEANFreqX
67            fBodyGyroMEANFreqY
68            fBodyGyroMEANFreqZ
69               fBodyAccMagMEAN
70                fBodyAccMagSTD
71           fBodyAccMagMEANFreq
72           fBodyAccJerkMagMEAN
73            fBodyAccJerkMagSTD
74       fBodyAccJerkMagMEANFreq
75              fBodyGyroMagMEAN
76               fBodyGyroMagSTD
77          fBodyGyroMagMEANFreq
78          fBodyGyroJerkMagMEAN
79           fBodyGyroJerkMagSTD
80      fBodyGyroJerkMagMEANFreq


Two processed datasets are derived: tidydetail.txt, tidymean.txt.   They contain the same set of features (80 columns).  Tidydetail.txt contains all the vector features obtained, ranging from 280 to 480+ rows per person   Tidymean.txt contains the mean all the column per person - one record per person, totally 30 rows in this file.
