library(DataComputing)
library(gridExtra)
library(dplyr)
library(tidyr)
library(caret)
library(ggfortify)
library(MASS)
library(e1071)
library(ROCR)
library(randomForest)
select = dplyr::select
theme_update(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
set.seed(04212019)


CVgeneric = function(classifier, 
                     train_set = NULL, 
                     labels = NULL, 
                     PCA = F,
                     K = 5, loss = classification_error, cost = 1, split_method = "A",...){ 
  #classifier: classification method; a string. KNN requires an additional parameter: k
  #train: training features with X, Y data, excluding labels; a data frame
  #labels: response variable; a binary vector (of any type)
  #split_method: A character string ("A" or "B") specifying the data splitting method. 
  if (split_method == "A"){
    data_split = data_split_A
    if(is.null(train_set)){
      train_set = rbind(data_train_A, data_validation_A) %>% select(-ExpertLabel)
    }
    if(is.null(labels)){
      labels = c(data_train_A$ExpertLabel, data_validation_A$ExpertLabel)
    }
  }
  else if (split_method == "B"){
    data_split = data_split_B
    if(is.null(train_set)){
      train_set = rbind(data_train_B, data_validation_B) %>% select(-ExpertLabel)
    }
    if(is.null(labels)){
      labels = c(data_train_B$ExpertLabel, data_validation_B$ExpertLabel)
    }
  }
  else {stop("Split Method Not Recognized")}
  
  classifier = tolower(classifier) #Making sure everything is lower case
  data = cbind(ExpertLabel = labels, train_set)
  data_CV = data_split(data, split_k = K) #using the same spliting method as in 2a
  classify = function(train, test){ #Helper function that takes care of classification method
    if (classifier %in% c("glm", "logistic", "logit")){
      fit = train(factor(ExpertLabel)~., data= train, method = "glm", family = "binomial")
      type = "raw"
    }
    else if(classifier %in% c("lda","qda")){
      fit = train(factor(ExpertLabel)~., data = train, method = classifier)
      type = "raw"
    }
    else if(classifier == "knn"){
      if(nrow(train)>= 10000){stop("Data set is too large for KNN")}
      fit = train(factor(ExpertLabel)~., data = train, method = classifier, preProcess= c("center","scale"))
      type = "raw"
    }
    else if(classifier == "svm"){
      if (K > 3){stop("K is too large for SVM")}
      fit = svm(factor(ExpertLabel)~., data = train, ...)
      type = "raw"
    }
    else if(classifier %in% c("rf", "randomforest")){
      fit = randomForest(formula = factor(ExpertLabel)~., data = train, ...)
      type = "response"
    }
    else{stop("Method not supported")}

    prediction = predict(fit, test, type = type)
    return(loss(prediction, test$ExpertLabel))
  }
  #####CV
  CV_accuracies = numeric(K)
  CV_n = numeric(K) #Recording how fair the splitting is
  for (i in 1:K){
    print(paste("Working on Fold ", i, " out of ", K, ".", sep = ""))
    cv_test = filter(data_CV, labels == i) %>% select(-c(Y, X, labels))
    cv_train = filter(data_CV, labels != i) %>% select(-c(Y, X, labels))
    if (PCA){#Whether do PCA before hand
      pca = princomp(scale(cv_train %>% select(-ExpertLabel)))
      pca_test = predict(pca, scale(cv_test %>% select(-ExpertLabel))) #Need to use the loadings of the training PCA set for testing
      cv_train = cbind(cv_train %>% select(ExpertLabel), pca$scores)
      cv_test = cbind(cv_test %>% select(ExpertLabel), pca_test)
    }
    
    CV_n[i] = nrow(cv_test)
    error = classify(train = cv_train, test = cv_test)
    CV_accuracies[i] = 1- error
  }
  average_accuracy = sum(CV_accuracies*CV_n)/sum(CV_n)
  if (PCA){method = paste("PCA-", toupper(classifier), sep = "")}
  else{method = toupper(classifier)}
  return(list(Accuracies = CV_accuracies, FoldSize = CV_n, method = method, AverageAccuracy = average_accuracy, K = K))
}
####################################################################################################3
#Required functions to run CVgeneric:
data_split_A = function(data, grid = 10, split_k = 3){
  data = mutate(data, ID = 1:nrow(data)) %>% 
    mutate(x_grid = cut(data$X, grid, include.lowest = T, labels = F)) %>% 
    mutate(y_grid = cut(data$Y, grid, include.lowest = T, labels = F))
  IDs = c()
  labels = c()
  for (i in 1:grid){
    for(j in 1:grid){
      subdf = data %>% filter((x_grid == i) & (y_grid == j))
      ID_temp = subdf$ID
      if(length(ID_temp) > 0){ #It's possible that there are grids that don't have any labeled points
        labels = c(labels, createFolds(1:length(ID_temp), k = split_k, list = F))
      }
      IDs = c(IDs, ID_temp)
    }
  }
  data = left_join(data, data.frame(ID = IDs, labels = labels), by = c("ID" = "ID")) %>% select(-c("x_grid", "y_grid", "ID"))
  return(data)
}

data_split_B = function(data, grid = 10, split_k = 3){
  data = mutate(data, ID = 1:nrow(data)) %>% 
    mutate(x_grid = cut(data$X, grid, include.lowest = T, labels = F)) %>% 
    mutate(y_grid = cut(data$Y, grid, include.lowest = T, labels = F))
  labels_grid = createFolds(1:(grid**2), k = split_k, list = F)
  IDs = c()
  labels = c()
  for (i in 1:grid){
    for(j in 1:grid){
      subdf = data %>% filter((x_grid == i) & (y_grid == j))
      ID_temp = subdf$ID
      if(length(ID_temp) > 0){ #It's possible that there are grids that don't have any labeled points
        labels = c(labels, rep(labels_grid[(i-1)*grid + j], length(ID_temp)))
      }
      IDs = c(IDs, ID_temp)
    }
  }
  data = left_join(data, data.frame(ID = IDs, labels = labels), by = c("ID" = "ID")) %>% select(-c("x_grid", "y_grid", "ID"))
  return(data)
}

classification_error = function(pred, actual){#pred and actual are two ordered vectors of the same length
  if(length(pred) != length(actual)){
    stop("Vectors Differ in Length")
  }
  else{
    pred = as.character(pred) #Converting to character strings in case we are comparing factors
    actual = as.character(actual)
    return(mean(pred!=actual))
  }
}