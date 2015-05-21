library(data.table)

#setwd('~/Sandbox/GettingCleaningData/Assign')

trainDf <- read.table('train/X_train.txt')
testDf <- read.table('test/X_test.txt')

featureNames <- read.table('features.txt', stringsAsFactors=F, col.names=c('id', 'name'))

# label columns
names(trainDf) <- featureNames$name
names(testDf) <- featureNames$name

# extract only mean and std dev measurements
trainDf <- trainDf[, grepl("mean\\(\\)|std\\(\\)", names(trainDf))]
testDf <- testDf[, grepl("mean\\(\\)|std\\(\\)", names(testDf))]

trainSubjects <- read.table('train/subject_train.txt', col.names=c('id'))
testSubjects <- read.table('test/subject_test.txt', col.names=c('id'))

trainDf$subjectid <- trainSubjects$id
testDf$subjectid <- testSubjects$id

activityLabels <- read.table('activity_labels.txt', stringsAsFactors=F, col.names=c('id', 'label'))

trainActivity <- read.table('train/y_train.txt', stringsAsFactors=F, col.names=c('id'))
testActivity <- read.table('test/y_test.txt', stringsAsFactors=F, col.names=c('id'))

# lookup activity name by id
trainActivity$label <- activityLabels$label[trainActivity$id]
testActivity$label <- activityLabels$label[testActivity$id]

# convert activity name to factor
trainActivity$label <- factor(trainActivity$label, levels=activityLabels$label)
testActivity$label <- factor(testActivity$label, levels=activityLabels$label)

trainDf$activity <- trainActivity$label
testDf$activity <- testActivity$label

# merge training and test datasets
allDf <- rbind(trainDf, testDf)

# clean up column names
names(allDf) <- gsub('-', '', names(allDf))
names(allDf) <- gsub('mean\\(\\)', 'Mean', names(allDf))
names(allDf) <- gsub('std\\(\\)', 'StdDev', names(allDf))

summaryDf <- aggregate(allDf[, 1:66], list(subjectid=allDf$subjectid, activity=allDf$activity), mean)

# label columns
names(summaryDf) <- sub('^t', 'tAvg', names(summaryDf))
names(summaryDf) <- sub('^f', 'fAvg', names(summaryDf))

write.table(summaryDf, file='summaryDf.txt', row.name=F)
