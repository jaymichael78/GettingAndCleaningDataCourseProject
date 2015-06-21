#**Getting and Cleaning Data Course Project**
The goal of this course project is to prepare a tidy data set from <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

>The raw data is from a Samsung sensor signal (accelerometer and gyroscope) experiment. This is covered in detail in the CodeBook.  


###In this repo: 
```
1. README.md
2. run_analysis.R: The script  
3. CodeBook: Information about the attributes and variables in the final file.
```

###run_analysis.R steps (How the Script works)
```
Note: This script assumes the files have been downloaded and extracted into the main working directory.
Files remain in the same dircteories as extracted.

*Step 1 - Read the files into R and name the fields

*Step 2 - Extract only the mean and standard devition

*Step 3 - Bind data

*Step 4 - Create tidy data set with the average of each variable for each activity and each subject

*Step 5 - Write tidyData output to txt file on local machine
```