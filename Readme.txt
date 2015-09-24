Wine Quality Application

Summary
The application displays based on the user selection, graphs related to the relationship 
between certain Wine characteristics and the Wine quality.

DataSources
The dataset was choosen from the UCI Machine Learning Repository in:
https://archive.ics.uci.edu/ml/datasets/Wine+Quality

Only the red wine data set was used for this assignment.

The data set contains:
- Ten different wine characteristics (pH, sulphates, etc) measured for each sample
- A Quality classification for each sample, from one (worst quality) to ten (best quality)
- 1599 observations 

Input

The side panel provides the user the possibility to choose between 
two type of data discovery graphs or to view plots with the linear model results.

It also allows the user to select which variables to consider for the analysis, from the ten included in the dataset.

To avoid unnecessary recalcultations, a submit button was added to plot results when all variables are selected.

Output
The main panel has a brief description of the application and displays results in a grid with two columns.
Each graph relates to one of the variables selected and is generated with the ggplot2 library.
The linear model (fit variable) is calculated through a reactive function.  