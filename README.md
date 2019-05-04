# Stat154 Project2

Sichun Wang, Yue Chen

## Data 

We obtain the data from Image. There are three datasets in Image, including image1.txt, image2.txt, and image3.txt. Each of these datasets contains several rows each with 11 columns, including y coordinates, x coordinates, expert label, NDAI, SD, CORR, Radiance angle DF, Radiance angle CF, Radiance angle BF, and Radiance angle AF, Radiance angle AN. All five radiance angles are raw features and NDAI, SD, and CORR are computed based on subject domain knowledge.   

## Reproducibility

Rmd files input the data from the same repository. To ensure data importation goes smoothly, please download the data to the same folder as the Rmd files. If one want to adjust anything, he/she can just change in the specific folder and the others will be automatically corrected.      

## Programming Language

R

## Package

* gridExtra
* dplyr
* tidyr
* caret
* ggfortify
* MASS
* e1071

## Reference
[Daytime Arctic Cloud Detection Based on Multi-Angle Satellite Data With Case Studies](https://github.com/peterwangshichun/Stat154Project2/blob/master/yu2008.pdf)
