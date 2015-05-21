README for run_analysis.R
=========================

The run_analysis.R script perform the following high-level steps:

* loads the data.table library for faster performance
* leads the training and test data
* populates training and test data column names with the 561 feature names from features.txt
* subsets training and test data into mean and std dev measurements only
* loads and populates subject ID for each observation
* loads and populates activity label for each observation, based on labels in activity_labels.txt
* activity labels are converted into factors
* training and test data are combined
* column names are cleaned up to remove special characters
* create new data frame containing the average of each column as a function of (subject, activity)
* column names of summary data frame is updated
* summary data frame is written to file 'summaryDf.txt'
