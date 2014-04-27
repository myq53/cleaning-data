#This script reads the UCI smartphone activity data and outputs a data frame to 
#the file output.txt containing average means and standard deviations of each
#measurement for each of the 180 combinations of subject and activity.  See 
#README.md for more information.

#Read the names of the 561 variables from "features.txt" and identify the 
#mean and standard deviation variables from among these using grep.
features <- read.table("features.txt")
meanFeatures <- grep("mean()",as.character(features[,2]),fixed=TRUE)
sdFeatures <- grep("std()",as.character(features[,2]),fixed=TRUE)

#Read the various files containing the measurements and the identities of the 
#subject and activity for both the training and test sets.
train <- read.table("X_train.txt")
actstrain <- read.table("y_train.txt")
subjtrain <- read.table("subject_train.txt")
test <- read.table("X_test.txt")
actstest <-read.table("y_test.txt")
subjtest <- read.table("subject_test.txt")

#Form data frames which merge the data from the training and test sets 
#(separately for the measurements, the subject, and the activity).
merged <- rbind(train,test)
mergedActs <- rbind(actstrain,actstest)
mergedSubj <- rbind(subjtrain,subjtest)

#Form smaller data frame "mergedMeanSD", which only contains data on means 
#and standard deviations, and name the columns using the names from features.txt.
mergedMeanSD <- merged[,c(meanFeatures,sdFeatures)]
colnames(mergedMeanSD) <- features[c(meanFeatures,sdFeatures),2]

#Split "mergedMeanSD" into a list "activitySets" of 180 data frames based on 
#subject number (1-30) and the activity that the subject was performing.
activitySets <- split(mergedMeanSD,c(mergedSubj,mergedActs))

#Read the names of the 6 activities from "activity_labels.txt", and form a 
#character vector "outrows" whose entries describe the 180 different combinations 
#of subject and activity.
actNames <- read.table("activity_labels.txt")
outrows <- paste(1:30,rep(sub("_"," ",actNames[,2]),times=rep(30,6)))

#Add a column to mergedMeanSD indicating (in words) the activity being performed
mergedMeanSD$Activity <- sub("_"," ",actNames[mergedActs[,1],2])

#Form a 66x180 matrix "activityMeans", each of whose rows corresponds to a single
#mean or standard deviation variable and consists of the means of that variable 
#for each of the 180 subject-activity combinations.
activityMeans <- sapply(activitySets,function (x){sapply(x,mean)})

#Formd a data frame "out" from the transpose of the matrix activityMeans, using 
#the row names from outrows and the column names from the original data.
out <- data.frame(t(activityMeans), row.names=outrows)
colnames(out)<-features[c(meanFeatures,sdFeatures),2]

#Write the data frame "out" to the text file "output.txt".
write.table(out, "output.txt", sep="\t",quote=FALSE,row.names=FALSE)
