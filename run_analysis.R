library(data.table)
library(dplyr)
library(magrittr)


# filepaths
output_filepath <- "act_sub_average.csv"
UCI_HAR_root_path <- "../UCI_HAR/"

test_X_filepath <- paste0(UCI_HAR_root_path, "test/X_test.txt")
test_y_filepath <- paste0(UCI_HAR_root_path, "test/y_test.txt")
subject_test_filepath <- paste0(UCI_HAR_root_path, "test/subject_test.txt")
train_X_filepath <- paste0(UCI_HAR_root_path, "train/X_train.txt")
train_y_filepath <- paste0(UCI_HAR_root_path, "train/y_train.txt")
subject_train_filepath <- paste0(UCI_HAR_root_path, "train/subject_train.txt")
features_filepath <- paste0(UCI_HAR_root_path, "features.txt")
activity_labels_filepath <- paste0(UCI_HAR_root_path, "activity_labels.txt")



#' Reads two data files (e.g. csv files) with data.table::fread and returns 
#' one large combined data.table.
#'
#' @param filepath1 Filepath of the first file
#' @param filepath2 Filepath of the second file
#' @param ... additional arguments forwarded to fread()
#'
#' @return a row-binded (rbind(dt1, dt2)) data.table of both tables
#' @export
combined_fread <- function(filepath1, filepath2, ...) {
  rbind(fread(filepath1, ...), fread(filepath2, ...))
}

##########################
# 1. Prepare feature vector X for test and training data:
# 1.1 Load train and test data with fread and combine into single table.
# 1.2 Drop unnecessary columns (only mean and std required).
# 1.3 Assign human readable column names.

data_X <- combined_fread(test_X_filepath, train_X_filepath)

# drop columns of data_X which are not required
# (only  "mean()" or "std()" columns are required)
features <- fread(features_filepath) # col1: data_X col ID, col2: name of col.
feature_grep <- grep("mean\\(\\)|std\\(\\)", features$V2) # only mean() or std()
feature_cols <- unlist(features[feature_grep, 1])
feature_names <- unlist(features[feature_grep, 2])

data_X <- data_X[, ..feature_cols] # drop unnecessary columns
names(data_X) <- feature_names # rename columns


##########################
# 2. Prepare y vector for test and training data:
# 2.1 Load train and test data with fread and combine into single table. 
#     (only one column = id of activity)
# 2.2 replace values (1..6) with human readable activity label as provided by 
#     "activity_labels.txt" e.g SITTING, STANDING .
data_y <- combined_fread(
  test_y_filepath,
  train_y_filepath,
  col.names=c("ActID")
)

activity_labels <- fread(
  activity_labels_filepath,
  col.names = c("ActID", "Activity")
)

# replace ID with activity lable by joining them (inner-join)
data_y <- data_y[activity_labels, nomatch=0, on="ActID"]


##########################
# 3. Prepare subject vector for test and training data by importing them.
data_subject <- combined_fread(
  subject_test_filepath,
  subject_train_filepath,
  col.names=c("Subject")
)


##########################
# 4. Combine results into one big data.table (to rule them all...) 
#    by wideningthe data.table (adding columns).
data <- cbind(data_X, data_y, data_subject)


##########################
# 5. Summarize mean and std columns by averaging groups based on subject 
#   and activity. Write output to csv file.
result <- data %>% 
  select(-ActID) %>% 
  group_by(Subject, Activity) %>% 
  summarise(across(everything(), ~ mean(.x, na.rm = TRUE)))

fwrite(result, file=output_filepath)
