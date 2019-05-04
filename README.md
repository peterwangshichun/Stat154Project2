# Stat154 Project2

Shichun Wang, Yue Chen

## Data 

MISR data were obtained from NASA Langley Research Center Atmospheric Sciences Data Center. We used three datasets, including image1.txt, image2.txt, and image3.txt (not in the repository). Each of these datasets contains several rows each with 11 columns, including y coordinates, x coordinates, expert label, NDAI, SD, CORR, Radiance angle DF, Radiance angle CF, Radiance angle BF, and Radiance angle AF, Radiance angle AN. All five radiance angles are raw features and NDAI, SD, and CORR are computed based on subject domain knowledge.   

## Reproducibility

Rmd files input the data from the same repository. To ensure data importation goes smoothly, please download the data to the same folder as the Rmd files. Each part of the project has its own Rmd files, and previous functions and results will be stored in a .R file to be sourced by the Rmd file in the next part. If any changes are made in the Rmd file, please also update the corresponding R file to make sure later parts are sourcing the updated version.     

## Programming Language

R/Rstudio (3.5/3.6)

## Package

* gridExtra
* dplyr
* tidyr
* caret
* ggfortify
* MASS
* e1071
* randomForest

## Reference
[Daytime Arctic Cloud Detection Based on Multi-Angle Satellite Data With Case Studies](https://github.com/peterwangshichun/Stat154Project2/blob/master/yu2008.pdf)
