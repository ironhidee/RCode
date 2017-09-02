setwd("E:/ana")
train<-read.csv(file.choose(), h=T)
test1<-read.csv(file.choose(), h=T)
test2<-read.csv(file.choose(), h=T)

require(dplyr)
require(xgboost)
require(dummies)



#Creating the dummy variables
train.final <- dummy.data.frame(train, names=c("max_spent_ind", "nbr_air_miles_mem"), sep="_")
x<-train.final[,c(2:49)]
y<-train.final[,50]


testA.final <- dummy.data.frame(test1, names=c("max_spent_ind", "nbr_air_miles_mem"), sep="_")
testA.final<-testA.final[,c(2:49)]

testB.final <- dummy.data.frame(test2, names=c("max_spent_ind", "nbr_air_miles_mem"), sep="_")
testB.final<-testB.final[,c(2:49)]

xgb <- xgboost(data = data.matrix(x), 
               label = as.numeric(y), 
               eta = 0.06,
               gamma = 2,
               max_depth = 15, 
               nround=300, 
               subsample = 0.5,
               colsample_bytree = 0.3,
               seed = 123,
               eval_metric = "mlogloss",
               objective = "multi:softmax",
               num_class = 4,
               nthread = 4
)

p1<-predict(xgb,data.matrix(testA.final))
p2<-predict(xgb,data.matrix(testB.final))

table(p1)

for (i in 1:length(p1)) {
  if (p1[i]==1){
    p1[i]="Credit"
  }
  else if (p1[i]== 2){
    p1[i]="Elite"
  }
  else {
    p1[i]="Supp"
  }
}

for (i in 1:length(p2)) {
  if (p2[i]==1){
    p2[i]="Credit"
  }
  else if (p2[i]== 2){
    p2[i]="Elite"
  }
  else {
    p2[i]="Supp"
  }
}


s1<-cbind(testA.final,p1)
s2<-cbind(testB.final,p2)

colnames(s1)[49] <- "card_offered"
colnames(s2)[49] <- "card_offered"


#Second go
train.final1<- dummy.data.frame(train, names=c("max_spent_ind", "nbr_air_miles_mem", "card_offered"), sep="_")
x1<-train.final1[,c(-1,-53)]
y1<-train.final1[,53]

testA.final1 <- dummy.data.frame(s1, names=c("card_offered"), sep="_")
testB.final1 <- dummy.data.frame(s2, names=c("card_offered"), sep="_")

xgb1 <- xgboost(data = data.matrix(x1), 
                label = as.numeric(y1), 
                eta = 0.08,
                max_depth = 25, 
                gamma = 2,
                nround=250, 
                subsample = 0.4,
                colsample_bytree = 0.3,
                seed = 125,
                eval_metric = "mlogloss",
                objective = "multi:softmax",
                num_class = 5,
                nthread = 4
)


p11<-predict(xgb1,data.matrix(testA.final1))
p22<-predict(xgb1,data.matrix(testB.final1))

for (i in 1:length(p11)) {
  if (p11[i]==1){
    p11[i]="Credit"
  }
  else if (p11[i]== 2){
    p11[i]="Elite"
  }
  else if (p11[i]== 3){
    p11[i]="None"
  }
  else {
    p11[i]="Supp"
  }
}

for (i in 1:length(p22)) {
  if (p22[i]==1){
    p22[i]="Credit"
  }
  else if (p22[i]== 2){
    p22[i]="Elite"
  }
  else if (p22[i]== 3){
    p22[i]="None"
  }
  else {
    p22[i]="Supp"
  }
}

v1<-cbind(test1[,1],p11)
v2<-cbind(test2[,1],p22)

colnames(v1) <- c("cust_key","card_offered")
colnames(v2) <- c("cust_key","card_offered")

write.csv(v1,"sub1.csv", row.names = F)
write.csv(v2,"sub2.csv", row.names = F)


