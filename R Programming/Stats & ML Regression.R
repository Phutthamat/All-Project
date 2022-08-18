## R : Linear Regression / Logistic Regression / Neural Network

install.packages("mlbench")
library(mlbench)
data("BreastCancer")
data("BostonHousing")

## 1. Build Linear Regression
## predict medv (BostonHousing)
head(BostonHousing)
View(BostonHousing)

## Linear Regression
## mpg = f(hp) > Coefficients
lmBoston <- lm(medv ~ rm + age + tax, data = BostonHousing)

lmBoston

summary(lmBoston)

coefs <- coef(lmBoston)
coefs[[1]] ##Intercept
coefs[[2]] ##rm
coefs[[3]] ##age
coefs[[4]] ##tax,

## medv= intercept + b0*rm + b1*age + b2*tax
## rm = 5, age = 50 , tax = 255

coefs[[1]] + coefs[[2]]*5 + coefs[[3]]*50 + coefs[[4]]*255

## Build Full Model
lmBoston_Full <- lm(medv ~ ., data = BostonHousing)
lmBoston_Full

BostonHousing$predicted <- predict(lmBoston_Full)
head(BostonHousing)

## Train RMSE
squared_error <- (BostonHousing$medv - BostonHousing$predicted) ** 2
squared_error

rmse <- sqrt(mean(squared_error))
rmse

## Split data for model training
set.seed(8) ## lock sampale data
n <-nrow(BostonHousing)
id <- sample(1:n, size = n* 0.8) ## 0.7 = 70% train data
train_data <- BostonHousing[id , ]
test_data <- BostonHousing[-id, ]

## Train Model
model1 <- lm(medv~ rm + age + tax, data = train_data)
p_train <- predict(model1)

error_train <- train_data$medv - p_train 
(rmse_train <- sqrt(mean(error_train ** 2 )))

rmse_train

## Test Model
p_test <- predict(model1, newdata = test_data)
error_test <- test_data$medv - p_test
(rmse_test <- sqrt(mean (error_test ** 2 )))

cat("RMSE Train", rmse_train, "\nRMSE Test", rmse_test)



## 2. Build Logistic Regression
## predict class (BreastCancer)

BreastCancer %>% head()
str(BreastCancer)

## Split data 
set.seed(8) ## lock sampale data
n <-nrow(BreastCancer)
id <- sample(1:n, size = n* 0.7) ## 0.7 = 70% train data
train_data_2 <- BreastCancer[id , ]
test_data_2 <- BreastCancer[-id, ]

## Train Model
logit_model <- glm(Class ~ Cell.shape ,
                   data = train_data_2 , 
                   family = "binomial")
p_train <- predict(logit_model, type="response") ##probability

p_train

train_data_2$pred <- if_else(p_train >= 0.05, 1, 0)

train_data_2$pred 

mean(train_data_2$Class == train_data_2$pred)

## Test Model

p_test<- predict(logit_model, newdata = test_data_2, type="response") ##probability

test_data_2$pred <- if_else(p_test >= 0.05, 1, 0)

mean(test_data_2$Class == test_data_2$pred)


## confusion Matrix
conM <- table(test_data_2$pred, test_data_2$Class, dnn= c("Predicted", "Actual"))

## Model Evaluation
conM[1, 1]
conM[1, 2]
conM[2, 1]
conM[2, 2]

cat ("Accuracy",(conM[1, 1] + conM[2, 2]) / sum(conM))

cat ("Precision",conM[2, 2] /( conM[2, 1] + conM[2, 2]))

cat("Recall", conM[2, 2] / (conM[1,2]+conM[2,2]))

#2*((precision*recall)/(precision+recall)) = F1 Score 0.816568
cat("F1 Score", 2 *((0.69 * 1)/(0.69 + 1)))


## 3. Build Neural Network
## predict class (BreastCancer)
head(BreastCancer)


# install packages
install.packages(c("nnet", "NeuralNetTools"))
library(nnet)
library(NeuralNetTools)
library(dplyr)


# train test split
set.seed(8)
n_BreastCancer <- nrow(BreastCancer)
shuffle_BC <- sample(1:n_BreastCancer, size = n_BreastCancer*0.7)
BC_train <- BreastCancer[shuffle_BC , ]
BC_test <- BreastCancer[-shuffle_BC , ]



# model training
nn_model <- nnet(Class ~ Cell.shape, 
                 data = BC_train ,
                 size = 3)

# plot networks
plotnet(nn_model)

summary(nn_model)

# model evaluation
p <- predict(nn_model, newdata = BC_test, type = "class")
mean(p == BC_test$Class)

