# Stat154 Project2

Sichun Wang, Yue Chen

## Data Collection and Exploration

We imported and explored the data first to get a idea of the data structure. Then, we used ggplot2 to plot the distribution of the points corresponding to different images, as well as the boxplots between different features. In addition, we used corrplot to generate the correlogram, analyzing the relationships of different features. 

## Data Split 
In order to split the data that follows the independent and identical distribution, we came up with two methods:

1. We broke the data into small grids based on coordinates and randomly assign the points that are within each grid to a set. 
2. We broke the data into small grids based on coordinates and randomly assign each grid to a set.

The baseline test error by setting all point as clear (-1) is 39%.

## Exploratory Data Anlysis
To understand the dataset holistically, we attempted to use boxplot and PCA analysis to reduce the dimension of the data. We plotted the PCA data projection on the top 2 PCs for visualization. 

## Modeling
We used five models to classify the data, including Linear Discriminant Analysis (LDA), Quadratic Discriminant Analysis (QDA), Logistic Regression, Support Vector Machine (SVM), and Random Forest. 

We assessed the models through cross validation accuracy, test accuracy, ROC curve and AUC value. Then, we found the cutoff value based on the total smallest classification error. 

## Diagnostics
We did in-depth analyses of our model through exploring the model convergence, parameter estimation, and misclassification pattern. We used ggplot2 to create the plots of test accuracy based on the sample size and the parameter, the time complexity of the sample size and the parameter, and the misclassified points on the test set. In order to improve our algorithm, we plotted the features distribution with correct and incorrect classifications that overlie on the histograms of Expert Label.   

## Reference
[Daytime Arctic Cloud Detection Baesd on Multi-Angle Satellite Data With Case Studies] (https://github.com/peterwangshichun/Stat154Project2/blob/master/yu2008.pdf)
