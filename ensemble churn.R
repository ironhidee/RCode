library(h2o)
h2o.init(nthreads = -1)

train <- read.csv(file.choose(), h=T)
train$Responders<-as.factor(train$Responders)
train[,2:371] = data.matrix(train[,2:371])
train =as.h2o(train)


nfolds <- 3

# Train & Cross-validate a GBM
my_gbm <- h2o.gbm(x = 2:371,
                  y = "Responders",
                  training_frame = train,
                  distribution = 'bernoulli',
                  max_depth = 10,
                  min_rows = 2,
                  learn_rate = 0.02,
                  nfolds = nfolds,
                  fold_assignment = "Modulo",
                  keep_cross_validation_predictions = TRUE,
                  ntrees = 500,
                  stopping_rounds = 5,stopping_metric = "logloss",
                  seed = 1)

# Train & Cross-validate a RF
my_rf <- h2o.randomForest(x = 2:371,
                          y = "Responders",
                          training_frame = train,
                          nfolds = nfolds,
                          fold_assignment = "Modulo",
                          keep_cross_validation_predictions = TRUE,
                          seed = 1)

# Train & Cross-validate a DNN
my_dl <- h2o.deeplearning(x = 2:371,
                          y = 377,
                          training_frame = train,
                          hidden = c(371, 180),
                          nfolds = nfolds,
                          fold_assignment = "Modulo",
                          distribution = 'bernoulli',
                          stopping_metric = "logloss",
                          epochs = 300,
                          keep_cross_validation_predictions = TRUE,
                          seed = 1)


# Train & Cross-validate a (shallow) XGB-GBM
my_xgb1 <- h2o.xgboost(x = 2:371,
                       y = "Responders",
                       training_frame = train,
                       distribution = "bernoulli",
                       ntrees = 50,
                       max_depth = 8,
                       min_rows = 2,
                       learn_rate = 0.09,
                       nfolds = nfolds,
                       fold_assignment = "Modulo",
                       keep_cross_validation_predictions = TRUE,
                       seed = 1)


# Train & Cross-validate another (deeper) XGB-GBM
my_xgb2 <- h2o.xgboost(x = 2:371,
                       y = 377,
                       training_frame = train,
                       distribution = "bernoulli",
                       ntrees = 150,
                       max_depth = 12,
                       min_rows = 1,
                       learn_rate = 0.08,
                       sample_rate = 0.7,
                       col_sample_rate = 0.8,
                       nfolds = nfolds,
                       fold_assignment = "Modulo",
                       stopping_rounds = 20,
                       stopping_metric = 'logloss',
                       keep_cross_validation_predictions = TRUE,
                       seed = 1)


# Train a stacked ensemble using the H2O and XGBoost models from above
base_models <- list(my_gbm@model_id, my_rf@model_id, my_dl@model_id,  
                    my_xgb1@model_id, my_xgb2@model_id)

ensemble <- h2o.stackedEnsemble(x = 2:371,
                                y = "Responders",
                                training_frame = train,
                                base_models = base_models)




test <- read.csv(file.choose(), h=T)
test1 <- test[,1]
test <- test[,c(2:371)]
test <- data.matrix(test)
test <- as.h2o(test)

pred <- h2o.predict(ensemble, newdata = test)
pred<- as.data.frame(pred)
pred <- pred$p1

v1<-cbind(test1,pred)
colnames(v1) <- c("UCIC_ID","Responders")
write.csv(v1,"sub.csv", row.names = F)
