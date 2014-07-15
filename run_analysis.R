
### To get the selected column Name
#- From feature.txt file, select the mean and Std column name
#- do some cleaning up of the column naming


#extract columns name containing mean and standard deviation
{r meanstd, echo=TRUE, result="asis"}
setwd("E://courses//jh-dataexplore//ws_get_clean_data//UCI HAR Dataset")
colD <- read.table("features.txt")

# get column containing mean and std
colDerv <- colD[grepl(c("mean|std"),colD$V2, ignore.case=F),]
head(colDerv)

# get rid off the () and hyphen from variable Name 
# get rid off some incorrect naming
colDerv$V2 <- gsub('\\(\\)', "", colDerv$V2)
colDerv$V2 <- gsub("-","", colDerv$V2)
colDerv$V2 <- gsub("BodyBody", "Body", colDerv$V2)

# maintain the camel case for easy reading 
# change mean and std to all uppercase so it stand outs
colDerv$V2 <- gsub("mean", "MEAN", colDerv$V2)
colDerv$V2 <- gsub("std", "STD", colDerv$V2)



### Subset training dataset on column name (mean, std) derived from step above

# note:  colDerv$V1 is the column position
#        colDerv$V2 is the columnn Name 
setwd("E://courses//jh-dataexplore//ws_get_clean_data//UCI HAR Dataset//train")
trainData <- read.table("x_train.txt")
trainData.sub <- subset(trainData, select=c(colDerv$V1))

# give the subset data meaningful column names
names(trainData.sub) <- colDerv$V2


# Get the personID 
trainSub <- read.table("subject_train.txt")

# Verify the number of activity record per persion
table(trainSub)

# insert the personID into the trainData set by
trainData.sub$subject <- trainSub[,1]

# Verify that insertion is correct by
nrow(trainData.sub[trainData.sub$subject==1,])
nrow(trainData.sub[trainData.sub$subject==30,])


### Similarly, subset training dataset

# note:  colDerv$V1 is the column position
#        colDerv$V2 is the columnn Name 
setwd("E://courses//jh-dataexplore//ws_get_clean_data//UCI HAR Dataset//test")
testData <- read.table("x_test.txt")
testData.sub <- subset(testData, select=c(colDerv$V1))

# give the subset data meaningful column names
names(testData.sub) <- colDerv$V2


# Get the personID 
testSub <- read.table("subject_test.txt")


# Verify the number of activity record per persion
table(testSub)

# insert the personID into the trainData set by
testData.sub$subject <- testSub[,1]

# Verify that insertion is correct by
nrow(testData.sub[testData.sub$subject==9,])
nrow(testData.sub[testData.sub$subject==20,])


### Append the two dataset into one dataset
mergeData <-rbind(trainData.sub, testData.sub)
mergeData <- mergeData[c(80,2:79)]

mergeData.avg <- aggregate(mergeData[,2:79], by=list(mergeData$subject),mean)
colnames(mergeData.avg)[1] <- "subject"


### write the dataframe into dataset, in txt format
setwd("E://courses//jh-dataexplore//ws_get_clean_data//project")
write.csv(mergeData,"tidydetail.txt")
write.csv(mergeData.avg,"tidymean.txt")
