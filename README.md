# Stat154Project2

Sichun Wang, Yue Chen

## Data Collection and Exploration

We imported and explored the data first to get a idea of the data structure. Then, we used ggplot2 to plot the distribution of the points corresponding to different images, as well as the boxplots between different features. In addition, we used corrplot to generate the correlogram, analyzing the relationships of different features. 

## Data Split 
In order to split the data that follows the independent and identical distribution, we came up with two methods:

1. We broke the data into small grids based on coordinates and randomly assign the points that are within each grid to a set. 
2. We broke the data into small grids based on coordinates and randomly assign each grid to a set.

The baseline test error by setting all point as clear (-1) is 39%.
