setwd("E:/ana")
train<-read.csv(file.choose(), h=T)
test1<-read.csv(file.choose(), h=T)
test2<-read.csv(file.choose(), h=T)

require(dplyr)
require(xgboost)
require(dummies)



#Creating the dummy variables
train.final <- dummy.data.frame(train, names=c("max_spent_ind"), sep="_")
x<-train.final[,c(2:44)]
y<-train.final[,45]


testA.final <- dummy.data.frame(test1, names=c("max_spent_ind"), sep="_")
testA.final<-testA.final[,c(2:44)]

testB.final <- dummy.data.frame(test2, names=c("max_spent_ind"), sep="_")
testB.final<-testB.final[,c(2:44)]




require(caret)

xgbGrid <- expand.grid(
  nrounds = 150,
  max_depth = 5,
  eta = 0.08,
  gamma = 2,
  colsample_bytree = 0.8,
  subsample = 0.8,
  min_child_weight = 2
)


xgbTrControl <- trainControl(
  method = "cv",
  number = 5,
  repeats = 2,
  verboseIter = FALSE,
  returnData = FALSE,
  allowParallel = TRUE
)

xgbTrain <- train(
  x = data.matrix(x), 
  y = data.matrix(y),
  trControl = xgbTrControl,
  tuneGrid = xgbGrid,
  method = "xgbTree"
)






# Example of Stacking algorithms
# create submodels
control <- trainControl(method="cv", number=10, repeats=2, savePredictions=TRUE, 
                        classProbs=TRUE,index=createFolds(x$card_offered, 10))

lists<-c("rf","xgbTree")
all.models <- caretList(card_offered~., data=x,trControl=control,methodList=lists)

# stacking
stack.xgb <- caretStack(all.models, method="rf",
                        trControl=control)

model<-list(rfmodel,xgbmodel)
greedy<-caretEnsemble(all.models,iter=10L)

print(stack.xgb)