# Human Activity Recognition Using Smartphones: Averaging subject and activity means+std

Peer-reviewed project assignment of week 4 for the course  "Getting and Cleaning Data" on [Coursera](https://www.coursera.org/learn/data-cleaning/).

## Overview

* The magic happens in `run_analysis.R` which imports and summarises the trainig and test data.
* The script averages the mean and standard deviation for all measurements which offer this data grouped by subject and activity.
* The result is stored in a tidy csv file. See `CodeBook.md`for details.

## Analysis
1. Prepare feature vector X for test and training data:
    + Load train and test data with fread and combine into single table.
    + Drop unnecessary columns (only mean and std required).
    + Assign human readable column names.
2. Prepare y vector for test and training data:
    + Load train and test data with fread and combine into single table. (only one column = id of activity)
    + replace values (1..6) with human readable activity label as provided by "activity_labels.txt" e.g SITTING, STANDING ...
3. Prepare subject vector for test and training data by importing them.
4. Combine results into one big data.table (to rule them all...) by widening the data.table (adding columns).
5. Summarize mean and std columns by averaging groups based on subject and activity. Write output to csv file.

## Output
The script returns a tidy csv file containing the averages of the mean and standard deviation for all measurements. See `CodeBook.md`for details.

## Installation and Requirements
* **Input files:** This script assumes that the raw data is in a folder called `UCI_HAR` loaced in the parent directory of the current directory. This setting can be changed by modifing `UCI_HAR_root_path`. The raw data can be downloaded here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* **Output file:** The script creates a single csv file in the working directory called `act_sub_average.csv`. This behavior can be changed with the variable `output_filepath`.
* **Libraries:** dplyr, data.table and magrittr are required.
* **Session info:** This script has been tested with R version 4.0.3 (2020-10-10), Platform: x86_64-w64-mingw32/x64 (64-bit), Running under: Windows 10 x64 (build 17763)