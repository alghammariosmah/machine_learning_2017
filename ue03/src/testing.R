


library(ggplot2)
library(caret) 
data(diamonds)





# I can't comprehend what the plot is about
plot(diamonds$x, col=diamonds$price, pch = 19)


savedData <- as.data.frame(diamonds[, c('price','x')])

# data partitioning
set.seed(12345) # make it reproducible
indexes_train <- createDataPartition(savedData$price, p = 0.75, list = F) # indexes of training samples
indexes_test <- (1:nrow(savedData))[-indexes_train] # use all samples not in train as test samples

training <- savedData[indexes_train,]
testing <- savedData[indexes_test,]



# train

model <- train(x =  data.frame(training[,2]), 
               y = training[,1], # ensure this is a numeric for regression and a factor for classification
               method = 'glm', 
               trControl = trainControl(method = 'repeatedcv',
                                        number = 10,
                                        repeats = 20,
                                        allowParallel = T, 
                                        returnData = F,
                                        returnResamp = 'final',
                                        savePredictions = F,
                                        classProbs = F))
model$results
