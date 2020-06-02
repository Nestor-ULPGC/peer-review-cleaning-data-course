> train <- merge(y_train, x_train, all=TRUE, by="row.names")

> rownames(train) <- train$Row.names

> train$Row.names <- NULL

> xytest <- merge(x_test, y_test, all=TRUE, by="row.names")

> rownames(xytest) <- xytest$Row.names

> xytest$Row.names <- NULL

> test <- merge(subject_test, xytest, all=TRUE, by="row.names")

> rownames(test) <- test$Row.names

> test$Row.names <- NULL

> save("test", file="C:/Users/nespm/Desktop/UCI HAR Dataset/test.RData")
> train <- merge(subject_train, train, all=TRUE, by="row.names")

> rownames(train) <- train$Row.names

> train$Row.names <- NULL
> traintest <- merge(test, train, all=TRUE, by="row.names")

> rownames(traintest) <- traintest$Row.names

> traintest$Row.names <- NULL
> extracted<-traintest%>%select(1:8, 43:48, 123:128, 563:571, 606:611,686:691) extracted <- within(extracted, {
+   recodedlabel.x <- Recode(label.x, 
+   '1= "walking"; 2= "walking_upstairs"; 3= "walking_downstairs"; 4= "sitting"; 5= "standing"; 6= "laying"',
+    as.factor=TRUE)
+ })

> fix(extracted)

> extracted <- within(extracted, {
+   recodedlabel.y <- Recode(label.y, 
+   '1= "walking"; 2= "walking_upstairs"; 3= "walking_downstairs"; 4= "sitting"; 5= "standing"; 6= "laying"',
+    as.factor=TRUE)
 extracted%>%
+ 	group_by(subject.x,recodedlabel.x)%>%
+ 	summarise_all(mean)
# A tibble: 55 x 43
# Groups:   subject.x [10]
   subject.x recodedlabel.x  V1.x     V2.x    V3.x    V4.x    V5.x   V6.x    V7.x   V42.x   V43.x
       <dbl> <fct>          <dbl>    <dbl>   <dbl>   <dbl>   <dbl>  <dbl>   <dbl>   <dbl>   <dbl>
 1         2 laying         0.281 -0.0182  -0.107  -0.974  -0.980  -0.984 -0.977   0.753   0.647 
 2         2 sitting        0.277 -0.0157  -0.109  -0.987  -0.951  -0.960 -0.989  -0.106   0.199 
 3         2 standing       0.278 -0.0184  -0.106  -0.987  -0.957  -0.950 -0.989  -0.370   0.130 
 4         2 walking        0.276 -0.0186  -0.106  -0.424  -0.0781 -0.425 -0.461  -0.347   0.0847
 5         2 walking_downs~ 0.278 -0.0227  -0.117   0.0464  0.263  -0.103 -0.0627 -0.326  -0.0439
 6         2 walking_upsta~ 0.247 -0.0214  -0.153  -0.304   0.108  -0.112 -0.361  -0.416  -0.196 
 7         4 laying         0.264 -0.0150  -0.111  -0.954  -0.942  -0.963 -0.958   0.915   0.342 
 8         4 sitting        0.272 -0.00716 -0.106  -0.980  -0.890  -0.932 -0.983   0.212   0.110 
 9         4 standing       0.280 -0.00949 -0.0962 -0.977  -0.862  -0.897 -0.979  -0.0759  0.167 
10         4 walking        0.279 -0.0148  -0.111  -0.441  -0.0788 -0.586 -0.463  -0.0859  0.128 
# ... with 45 more rows, and 32 more variables: V44.x <dbl>, V45.x <dbl>, V46.x <dbl>,
#   V47.x <dbl>, V122.x <dbl>, V123.x <dbl>, V124.x <dbl>, V125.x <dbl>, V126.x <dbl>,
#   V127.x <dbl>, label.x <dbl>, subject.y <dbl>, label.y <dbl>, V1.y <dbl>, V2.y <dbl>,
#   V3.y <dbl>, V4.y <dbl>, V5.y <dbl>, V6.y <dbl>, V41.y <dbl>, V42.y <dbl>, V43.y <dbl>,
#   V44.y <dbl>, V45.y <dbl>, V46.y <dbl>, V121.y <dbl>, V122.y <dbl>, V123.y <dbl>,
#   V124.y <dbl>, V125.y <dbl>, V126.y <dbl>, recodedlabel.y <dbl>

> grouped<-extracted%>%
+ 	group_by(subject.x,recodedlabel.x)%>%
+ 	summarise_all(mean)
+ })


> fix(traintest)
