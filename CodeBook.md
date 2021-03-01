# Cood book for output of run_analysis.R
The script `run_analysis.R` creates a tidy csv file with averarges of all mean() and std() measurements of the UCI_HAR dataset.

## Columns
* **Subject:** An integer between 1 and 30 identifying the subject (i.e. the person wearing the smartphone).
* **Activity:** A character label characterizing the activity of the subject for this row (i.e. what is the person doing):
    + WALKING
    + WALKING_UPSTAIRS
    + WALKING_DOWNSTAIRS
    + SITTING
    + STANDING
    + LAYING
* **Averaged measurement columns:** The 66 measurements as double with mean (suffix `mean()`) and standard deviation (suffix `std()`) for all channels and axes identified by X,Y,Z:
    + tBodyAcc-XYZ
    + tGravityAcc-XYZ
    + tBodyAccJerk-XYZ
    + tBodyGyro-XYZ
    + tBodyGyroJerk-XYZ
    + tBodyAccMag
    + tGravityAccMag
    + tBodyAccJerkMag
    + tBodyGyroMag
    + tBodyGyroJerkMag
    + fBodyAcc-XYZ
    + fBodyAccJerk-XYZ
    + fBodyGyro-XYZ
    + fBodyAccMag
    + fBodyAccJerkMag
    + fBodyGyroMag
    + fBodyGyroJerkMag
    
## Synthesis
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

## Session Info
The result data set attached to this repository `act_sub_average.csv` has been created with the following R session:
```
R version 4.0.3 (2020-10-10)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 17763)

Matrix products: default

locale:
[1] LC_COLLATE=German_Germany.1252  LC_CTYPE=German_Germany.1252    LC_MONETARY=German_Germany.1252 LC_NUMERIC=C                   
[5] LC_TIME=German_Germany.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] data.table_1.13.6 magrittr_1.5      dplyr_1.0.0      

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.4.6     rstudioapi_0.11  knitr_1.28       tidyselect_1.1.0 R6_2.4.1         rlang_0.4.6      fansi_0.4.1      tools_4.0.3     
 [9] packrat_0.5.0    xfun_0.14        cli_2.0.2        htmltools_0.4.0  ellipsis_0.3.1   assertthat_0.2.1 digest_0.6.25    tibble_3.0.1    
[17] lifecycle_0.2.0  crayon_1.3.4     purrr_0.3.4      vctrs_0.3.0      rsconnect_0.8.16 glue_1.4.1       evaluate_0.14    rmarkdown_2.2   
[25] compiler_4.0.3   pillar_1.4.4     generics_0.0.2   pkgconfig_2.0.3 
```