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


### To get the selected column Name
- From feature.txt file, select the mean and Std column name
- do some cleaning up of the column naming


extract columns name containing mean and standard deviation

```r
setwd("E://courses//jh-dataexplore//ws_get_clean_data//UCI HAR Dataset")
colD <- read.table("features.txt")

# get column containing mean and std
colDerv <- colD[grepl(c("mean|std"), colD$V2, ignore.case = F), ]
head(colDerv)
```

```
##   V1                V2
## 1  1 tBodyAcc-mean()-X
## 2  2 tBodyAcc-mean()-Y
## 3  3 tBodyAcc-mean()-Z
## 4  4  tBodyAcc-std()-X
## 5  5  tBodyAcc-std()-Y
## 6  6  tBodyAcc-std()-Z
```

```r

# get rid off the () and hyphen from variable Name get rid off some
# incorrect naming
colDerv$V2 <- gsub("\\(\\)", "", colDerv$V2)
colDerv$V2 <- gsub("-", "", colDerv$V2)
colDerv$V2 <- gsub("BodyBody", "Body", colDerv$V2)

# maintain the camel case for easy reading change mean and std to all
# uppercase so it stand outs
colDerv$V2 <- gsub("mean", "MEAN", colDerv$V2)
colDerv$V2 <- gsub("std", "STD", colDerv$V2)

```



### Subset training dataset on column name (mean, std) derived from step above


```r
# note: colDerv$V1 is the column position colDerv$V2 is the columnn Name
setwd("E://courses//jh-dataexplore//ws_get_clean_data//UCI HAR Dataset//train")
trainData <- read.table("x_train.txt")
trainData.sub <- subset(trainData, select = c(colDerv$V1))

# give the subset data meaningful column names
names(trainData.sub) <- colDerv$V2


# Get the personID
trainSub <- read.table("subject_train.txt")

# Verify the number of activity record per persion
table(trainSub)
```

```
## trainSub
##   1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27 
## 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 
##  28  29  30 
## 382 344 383
```

```r

# insert the personID into the trainData set by
trainData.sub$subject <- trainSub[, 1]

# Verify that insertion is correct by
nrow(trainData.sub[trainData.sub$subject == 1, ])
```

```
## [1] 347
```

```r
nrow(trainData.sub[trainData.sub$subject == 30, ])
```

```
## [1] 383
```



### Similarly, subset training dataset


```r
# note: colDerv$V1 is the column position colDerv$V2 is the columnn Name
setwd("E://courses//jh-dataexplore//ws_get_clean_data//UCI HAR Dataset//test")
testData <- read.table("x_test.txt")
testData.sub <- subset(testData, select = c(colDerv$V1))

# give the subset data meaningful column names
names(testData.sub) <- colDerv$V2


# Get the personID
testSub <- read.table("subject_test.txt")


# Verify the number of activity record per persion
table(testSub)
```

```
## testSub
##   2   4   9  10  12  13  18  20  24 
## 302 317 288 294 320 327 364 354 381
```

```r

# insert the personID into the trainData set by
testData.sub$subject <- testSub[, 1]

# Verify that insertion is correct by
nrow(testData.sub[testData.sub$subject == 9, ])
```

```
## [1] 288
```

```r
nrow(testData.sub[testData.sub$subject == 20, ])
```

```
## [1] 354
```



### Append the two dataset into one dataset

```r
mergeData <- rbind(trainData.sub, testData.sub)
mergeData <- mergeData[c(80, 2:79)]

mergeData.avg <- aggregate(mergeData[, 2:79], by = list(mergeData$subject), 
    mean)
```



### write the dataframe into dataset, in csv format

```r
setwd("E://courses//jh-dataexplore//ws_get_clean_data//project")
write.csv(mergeData, "tidydetail.txt")
write.csv(mergeData.avg, "tidymean.txt")
```


