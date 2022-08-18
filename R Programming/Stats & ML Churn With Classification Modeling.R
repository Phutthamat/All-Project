library(tidyverse)
library(caret)

##Binary classification
df <- read_csv("churn.csv")
View(df)
glimpse(df)

## convert churn to factor
df$churn <- factor(df$churn)
table(df$churn)

## missing value
mean(complete.cases(df)) ## 1 = not missing value

## Preview
df %>% head

## 1. split data
set.seed(42)
id <- createDataPartition(y = df$churn, 
                          p = 0.7,
                          list = FALSE)
train_df <- df[id,]
test_df <- df[-id,]

nrow(train_df) ; nrow(test_df)

## 2. Train Model
## Logistic Regression
set.seed(42)
ctrl <- trainControl(
  method = "cv",
  number = 3,
  verboseIter = TRUE
)

logistic_model <- train(churn~.,
                        data =  train_df,
                        method = "glm",
                        trControl = ctrl)

logistic_model ##Accuracy 86%


knn_model <- train(churn~.,
                   data =  train_df,
                   method = "knn",
                   preProcess = c("center","scale"), ## Pre Process data
                   trControl = ctrl)

knn_model  ##Accuracy 89%

rf_model <- train(churn~.,
                  data =  train_df,
                  method = "rf",
                  trControl = ctrl)

rf_model ##Accuracy 95%

## compare three models
result <- resamples(list(
  logistic_regression = logistic_model,
  knn = knn_model,
  randomForest = rf_model
))
summary(result) 

## 3. Test Model
p <- predict(rf_model, newdata = test_df)

p

mean(p == test_df$churn) ##Accuracy 95%


## Confusion Matrix
table(p, test_df$churn, dnn=c("Prediction", "Actual"))
# Accuracy (1274+159)/(1274+53+13+159) = 0.95
mean(p == test_df$churn)

#Recall 1274/(1274+13) = 0.9898
#Precision 1274/(1274+53) = 0.96
#f1_score <- 2*recall*precision / (precision+recall)

confusionMatrix(p,
                test_df$churn,
                mode = "prec_recall")


