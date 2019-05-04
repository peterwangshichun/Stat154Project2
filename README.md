# Stat154 Project2

Shichun Wang, Yue Chen

## Data 

MISR data were obtained from NASA Langley Research Center Atmospheric Sciences Data Center. We used three datasets, including image1.txt, image2.txt, and image3.txt (not in the repository). Each of these datasets contains several rows each with 11 columns, including y coordinates, x coordinates, expert label, NDAI, SD, CORR, Radiance angle DF, Radiance angle CF, Radiance angle BF, and Radiance angle AF, Radiance angle AN. All five radiance angles are raw features and NDAI, SD, and CORR are computed based on subject domain knowledge.   

## Reproducibility

Rmd files input the data from the same repository. To ensure data importation goes smoothly, please download the data to the same folder as the Rmd files. Each part of the project has its own Rmd files, and previous functions and results will be stored in a .R file to be sourced by the Rmd file in the next part. If any changes are made in the Rmd file, please also update the corresponding R file to make sure later parts are sourcing the updated version.     

## Programming Language

R/Rstudio (3.5/3.6)

## Package

* ggplot2
* gridExtra
* dplyr
* tidyr
* caret
* ggfortify
* MASS
* e1071
* ROCR
* randomForest

## Reference
[Shi, T., Yu, B., Clothiaux, E., & Braverman, A. (2008). Daytime Arctic Cloud Detection Based on Multi-Angle Satellite Data with Case Studies. Journal of the American Statistical Association,103(482), 584-593.](https://github.com/peterwangshichun/Stat154Project2/blob/master/yu2008.pdf)

## Summary of Project

### Data Collection and Exploration

We imported and explored the data first to get a idea of the data structure. Then, we used ggplot2 to plot the distribution of the points corresponding to different images, as well as the boxplots between different features. In addition, we used corrplot to generate the correlogram, analyzing the relationships of different features. 

### Data Split

In order to split the data that follows the independent and identical distribution, we came up with two methods:
1. We broke the data into small grids based on coordinates and randomly assign the points that are within each grid to a set. 
2. We broke the data into small grids based on coordinates and randomly assign each grid to a set.
 
The baseline test error by setting all point as clear (-1) is 39%.

### Exploratory Data Analysis

To understand the dataset holistically, we attempted to use boxplot and PCA analysis to reduce the dimension of the data. We plotted the PCA data projection on the top 2 PCs for visualization. 

### Modeling

We used five models to classify the data, including Linear Discriminant Analysis (LDA), Quadratic Discriminant Analysis (QDA), Logistic Regression, Support Vector Machine (SVM), and Random Forest. 

We assessed the models through cross validation accuracy, test accuracy, ROC curve and AUC value. Then, we found the cutoff value based on total smallest classification error. 

### Diagnostics

We did in-depth analyses of our model through exploring the model convergence, parameter estimation, and misclassification pattern. We used ggplot2 to create the plots of test accuracy based on the sample size and the parameter, the time complexity of the sample size and the parameter, and the misclassified points on the test set. In order to improve our algorithm, we plotted the features distribution with correct and incorrect classifications that overlie on the histograms of Expert Label.   
