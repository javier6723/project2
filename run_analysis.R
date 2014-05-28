#GETTING AND CLEANING DATA ASSIGNMENT
# R VERSION
#OPERATIVE SYSTEM USED UBUNTU 12.04

#READING FEATURES INTO R TO SET DESCRITIVE NAMES ON THE VARIABLES
features<-read.table("./UCI HAR Dataset/features.txt")
#saving the features in a vector variable to name the columns
names1<-as.vector(features[,2])
#turning capital letters to lower case letters in the names
names<-tolower(names1); rm(names1)
#removing no letters characters("-","(",")",".",","))
#and setting self descriptive names
names<-gsub("-","",names)
names<-gsub("\\(","",names)
names<-gsub("\\)","",names)
names<-gsub("\\.","",names)
names<-gsub(",","",names)
names<-gsub("acc","acceleration",names)
names<-gsub("gyro","gyroscope",names)
names<-gsub("tb","timeb",names)
names<-gsub("tg","timeg",names)
names<-gsub("fb","frequencyb",names)

#READING THE ROW DATA SETS
#reading test data sets into R
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",col.names=c("subject"))
#reading X_test with the names of the features using the variable called names
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt",col.names=names)
Y_test<-read.table("./UCI HAR Dataset/test/y_test.txt",col.names=c("activity"))


#reading train data sets into R
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",col.names=c("subject"))
#reading X_train with the names of the features using the variable called names
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt",col.names=names)
Y_train<-read.table("./UCI HAR Dataset/train/y_train.txt",col.names=c("activity"))


#MERGING THE TEST AND TRAINIG SETS INTO A SINGLE DATA SET
#merging the test and train datasets by row
X_all<-rbind(X_test,X_train)
Y_all<-rbind(Y_test,Y_train)
subject<-rbind(subject_test,subject_train)

#reading tha activity names into R
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
#saving the activity labels in a vector variable to name the columns
labels<-as.character(activity_labels[,2])

#setting descriptives names to the activity labels and turning the variable 
# into a factor variable
Y_all$activity<-factor(Y_all$activity,labels=labels)


human_activity_recogn_tidy_data<-cbind(subject,Y_all,X_all)

#turning subjects as a factor variables
human_activity_recogn_tidy_data$subject<-as.factor(human_activity_recogn_tidy_data$subject)

#EXTRACTING ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT 
names2<-names(human_activity_recogn_tidy_data)
subset<-grep("subject|activity|mean|std",names2,value=T)

#FIRST TIDY DATA SET
human_activity_recogn_tidy_data<-human_activity_recogn_tidy_data[subset[1:length(subset)]]
rm(names2)

#CREATING THE FINAL TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
human_activity_recogn_tidy_data2<-aggregate(human_activity_recogn_tidy_data[,3:88],by=human_activity_recogn_tidy_data[,1:2],mean)

#WRITING THE DATASET IN THE CURRRENT WORK DIRECTORY FIRST DATASET
write.table(human_activity_recogn_tidy_data,"tidy_data_1.txt",col.names=T)

#WRITING THE DATASET IN THE CURRRENT WORK DIRECTORY
write.table(human_activity_recogn_tidy_data2,"tidy_data.txt",col.names=T)