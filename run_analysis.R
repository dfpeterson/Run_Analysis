run_analysis <- function() {
  library(reshape2)
  library(plyr)
  #read the raw label files into R
  labels.activity <- read.table("activity_labels.txt", col.names=c("V1","Activity.Name"))
  labels.features <- read.table("features.txt", stringsAsFactors=FALSE)
  #remove the parentheses from the features list to make cleaner column names
  labels.features <- cbind(labels.features, names=gsub("()","",labels.features$V2, fixed=TRUE), stringsAsFactors=FALSE)
  #read the raw test and train files into R
  test.subject <- read.table("test/subject_test.txt", col.names="subject")
  test.y <- read.table("test/y_test.txt", col.names="activity")
  test.x <- read.table("test/X_test.txt", col.names=labels.features$names)
  train.subject <- read.table("train/subject_train.txt", col.names="subject")
  train.y <- read.table("train/y_train.txt", col.names="activity")
  train.x <- read.table("train/X_train.txt", col.names=labels.features$names)
  #combines the test and train data set data together with the subject number and activity info
  test.x <- cbind(test.subject, test.y, sample="test", test.x, stringsAsFactors=FALSE)
  train.x <- cbind(train.subject, train.y, sample="train", train.x, stringsAsFactors=FALSE)
  #merges the train and tet sets together
  all.x <- rbind(train.x,test.x)
  #give descriptive activity names to the combined data set
  all.x <- merge(all.x, labels.activity, by.x="activity", by.y="V1", sort=FALSE)
  #selects only the standard deviation and mean variables from the combined set
  subjects.by.std.and.mean <- all.x[,grep("mean|std|subject|Activity.Name|sample",names(all.x))]
  #reshapes the data into a summarized form and then sorts it
  melted.subjects <- melt(subjects.by.std.and.mean, c(1,2,82))
  clean.subjects <- aggregate(melted.subjects$value, melted.subjects[,1:4], mean)
  clean.subjects <- arrange(clean.subjects, subject, Activity.Name, variable)
  names(clean.subjects) <- c("Subject.ID","Sample.Source","Activity.Name","Variable.Name","Mean.Value")
  return(clean.subjects)
}