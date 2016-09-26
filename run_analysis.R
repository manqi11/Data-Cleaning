#Download file
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="UCI_HAR.zip",method="curl")
download.date<-date()
unzip("UCI_HAR.zip")

#Read in train and test datasets
trainX<-read.table("./UCI HAR Dataset/train/X_train.txt",header=F)
trainY<-read.table("./UCI HAR Dataset/train/y_train.txt",header=F)
trainSubj<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=F)
testX<-read.table("./UCI HAR Dataset/test/X_test.txt",header=F)
testY<-read.table("./UCI HAR Dataset/test/y_test.txt",header=F)
testSubj<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=F)

#Combine train and test datasets
CombinedX<-rbind(trainX,testX)
CombinedY<-rbind(trainY,testY)
CombinedSubj<-rbind(trainSubj,testSubj)

#Check what the data looks like
View(CombinedX)
View(CombinedY)
View(CombinedSubj)

#Appropriately labels the data set with descriptive variable names.
features<-read.table("./UCI HAR Dataset/features.txt",row.names=1,header=F,stringsAsFactors = F)
View(features)
colnames(CombinedX)<-features$V2

#Extract only the measurements on the mean and standard deviation for each measurement
varKeep<-grep("mean|std",colnames(CombinedX))
CombinedX<-CombinedX[,varKeep]

#Combine all datasets together
CombinedAll<-cbind(CombinedY,CombinedSubj,CombinedX)
View(CombinedAll)
colnames(CombinedAll)[1:2]<-c("Activity","SubjectID")
View(CombinedAll)

#Uses descriptive activity names to name the activities in the data set
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=F,stringsAsFactors = F)
View(activity_labels)
table(activity_labels$V2,activity_labels$V1)
CombinedAll$Activity<-gsub(1, "WALKING", CombinedAll$Activity)
CombinedAll$Activity<-gsub(2, "WALKING_UPSTAIRS", CombinedAll$Activity)
CombinedAll$Activity<-gsub(3, "WALKING_DOWNSTAIRS", CombinedAll$Activity)
CombinedAll$Activity<-gsub(4, "SITTING", CombinedAll$Activity)
CombinedAll$Activity<-gsub(5, "STANDING", CombinedAll$Activity)
CombinedAll$Activity<-gsub(6, "LAYING", CombinedAll$Activity)
table(CombinedAll$Activity)

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
group<-CombinedAll$Activity
activity_group <-split(CombinedAll, list(group,CombinedAll$SubjectID))
summary(activity_group)

newData<-sapply(activity_group,FUN=function(x) colMeans(x[,3:ncol(x)]))
View(newData)# newData is not a tidy dataset
newData<-t(newData)

#Split the label names and rename the columns
New_labels<-strsplit(rownames(newData),"\\.")
View(New_labels)
TidyData<-cbind(sapply(New_labels,function(x) x[[1]]),sapply(New_labels,function(x) x[[2]]),newData)
colnames(TidyData)[1:2]<-c("activity","subject")


#Save the tidy data into a new file
write.table(TidyData,file="./UCI HAR Dataset/tidyData.txt",col.names=T,row.names=F,sep="\t",quote=F)

