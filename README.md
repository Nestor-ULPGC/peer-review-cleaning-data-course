# peer-review-cleaning-data-course

##First, after reading the readme file, we load the train data from the folder it is in.
##the y_train file gives us the info for each row, meanwhile the x_train file give us the values.
##The x file must be loaded with no header: the column's name is given by the file activity_label.txt

##I won't write here the loading folder due to privacity rights, so I'll start whith the data loaded
##in R. So, once we have x_train and y_train in R, we have to merge them, by row names:

train <- merge(y_train, x_train, all=TRUE, by="row.names")
rownames(train) <- train$Row.names
train$Row.names <- NULL

##It is seen the merged table has the same row number than the other two. Now we load the
##subject_train file and merge it too.


train <- merge(subject_train, train, all=TRUE, by="row.names")
rownames(train) <- train$Row.names
train$Row.names <- NULL


##Now, we need to do the same with the test files. Once loaded, we merge them:

xytest <- merge(x_test, y_test, all=TRUE, by="row.names")
rownames(xytest) <- xytest$Row.names
xytest$Row.names <- NULL

test <- merge(subject_test, xytest, all=TRUE, by="row.names")
rownames(test) <- test$Row.names
test$Row.names <- NULL

##So we have these data frames:

head(train)
     V1 V1.x      V1.y           V2          V3         V4         V5         V6         V7
1     1    5 0.2885845 -0.020294171 -0.13290514 -0.9952786 -0.9831106 -0.9135264 -0.9951121
10    1    5 0.2805857 -0.009960298 -0.10606516 -0.9948034 -0.9727584 -0.9862439 -0.9954046
100   1    1 0.2217267 -0.024376970 -0.07507641 -0.1117174  0.1111303 -0.2218326 -0.1588871
1000  6    5 0.2829528 -0.018973421 -0.11228912 -0.9967056 -0.9871497 -0.9668754 -0.9969798
1001  6    5 0.2765158 -0.017765302 -0.09999201 -0.9969584 -0.9918158 -0.9863694 -0.9973058
1002  6    5 0.2743897 -0.016128408 -0.10930551 -0.9982962 -0.9921333 -0.9892028 -0.9983320

head(test)
V1      V1.x          V2          V3         V4          V5         V6         V7
1     2 0.2571778 -0.02328523 -0.01465376 -0.9384040 -0.92009078 -0.6676833 -0.9525011
10    2 0.2757457 -0.01037199 -0.09977589 -0.9983731 -0.98693291 -0.9910219 -0.9986629
100   2 0.2666311 -0.04330947 -0.14096216 -0.4337781 -0.10164616 -0.4153248 -0.4800755
1000 10 0.1907914 -0.00781164 -0.01044686 -0.3438633  0.04087234 -0.4118839 -0.3868504
1001 10 0.3070670  0.01139759 -0.06809438 -0.2539696  0.05892125 -0.4263188 -0.2959150
1002 10 0.3444790 -0.02830795 -0.10095811 -0.2232959  0.24500040 -0.4065773 -0.2819389

V1.y
   5
   5
   1
   1
   1
   1
##Before continue, we are going to rename three columns. In the train data, we'll rename V1 as
## 'subject', V1.X as 'label', and V1.y as V1. In the test data, we'll rename V1 as 'subject',
## V1.x as 'V1' and V1.y as 'label'. We are gonna do this using the fix tool, so we get:

fix(train)
head(train)
subject label        V1           V2          V3         V4         V5         V6
1          1     5 0.2885845 -0.020294171 -0.13290514 -0.9952786 -0.9831106 -0.9135264
10         1     5 0.2805857 -0.009960298 -0.10606516 -0.9948034 -0.9727584 -0.9862439
100        1     1 0.2217267 -0.024376970 -0.07507641 -0.1117174  0.1111303 -0.2218326
1000       6     5 0.2829528 -0.018973421 -0.11228912 -0.9967056 -0.9871497 -0.9668754
1001       6     5 0.2765158 -0.017765302 -0.09999201 -0.9969584 -0.9918158 -0.9863694
1002       6     5 0.2743897 -0.016128408 -0.10930551 -0.9982962 -0.9921333 -0.9892028

fix(test)
head(test)
subject        V1          V2          V3         V4          V5         V6         
1          2 0.2571778 -0.02328523 -0.01465376 -0.9384040 -0.92009078 -0.6676833 
10         2 0.2757457 -0.01037199 -0.09977589 -0.9983731 -0.98693291 -0.9910219 
100        2 0.2666311 -0.04330947 -0.14096216 -0.4337781 -0.10164616 -0.4153248 
1000      10 0.1907914 -0.00781164 -0.01044686 -0.3438633  0.04087234 -0.4118839 
1001      10 0.3070670  0.01139759 -0.06809438 -0.2539696  0.05892125 -0.4263188 
1002      10 0.3444790 -0.02830795 -0.10095811 -0.2232959  0.24500040 -0.4065773
label
     5
     5
     1
     1
     1
     1

##Now, to conclude the first step of the assingment, we proceed to merge the test and the
##train data.

traintest <- merge(test, train, all=TRUE, by="row.names")
rownames(traintest) <- traintest$Row.names
traintest$Row.names <- NULL
fix(traintest)

##So at this point, we have only one data set, called 'traintest' with 7352 rows and 1126 cols.
##The columns whose names are .x are those from test data and those with .y are from train data.

##Attending to the second part of the assignment, I've selected some columns from the file
##features.txt contained in the data folder. As there are, mainly, three measures, I've chosen
to select the columns which correspond to body acceleration, gravity acceleration and the body
##gyro. For each of these three measurements, I'll select the three axis (X, Y and Z) and the
##mean and the standard deviation.

##So the columns chosen are from 1 to 6 (BodyAcc),41 to 46 (GravityAcc) and 121 to 126 (BodyGyro)
##Their column numbers, in the merged dataset, are the ones from the features.txt file plus 2
##(due to the addition of subject and label columns) for the test data; and their numbers plus
##4 (two subject and two label columns) plus 561 (test data columns) for the train mean and std
##data. So that's 565 plus the number of the feature file. For using select, we load the dplyr
##package

library(dplyr)

extracted<-traintest%>%select(1:8, 43:48, 123:128, 563:571, 606:611,686:691)

##The first ranges have two more columns due to include both subject and label columns.

##Next, we have to rename the activities values with ther decriptive values, so 1 is walking,
## 2 walking upstairs, 3 walking downstairs, 4 sitting, 5 standing and 6 laying.

extracted <- within(extracted, {
  recodedlabel.x <- Recode(label.x, 
  '1= "walking"; 2= "walking_upstairs"; 3= "walking_downstairs"; 4= "sitting"; 5= "standing"; 6= "laying"',
   as.factor=TRUE)
})
 
##And the same for train labels

extracted <- within(extracted, {
  recodedlabel.y <- Recode(label.y, 
  '1= "walking"; 2= "walking_upstairs"; 3= "walking_downstairs"; 4= "sitting"; 5= "standing"; 6= "laying"',
   as.factor=TRUE)
})


##For the point 4 of the assignment, we would have to labelled appropriately the variables. We've done
##already this point in the first step (in that way we improve our computing time) so we only have
##the point 5 ahead. Now, we have to create an independent and tidy data set with the average of
##each variable for each activity and each subject. We are going to use the function group_by along
##with summarise all. We'll create a new data frame with that.

grouped<-extracted%>%
	group_by(subject.x,recodedlabel.x)%>%
	summarise_all(mean)
save("grouped", file="C:/Users/nespm/Desktop/UCI HAR Dataset/grouped.RData")

##And that's all. We've cleaned that data, merging and renaming it, we have extract some columns
## correspondent to means and stds and we have employed the dplyr package to get a new and tidy DF.
write.table(grouped, "C:/Users/nespm/Desktop/grouped.txt", sep=" ", col.names=FALSE, 
  row.names=TRUE, quote=TRUE, na="NA")
