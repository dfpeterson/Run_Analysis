---
title: "README.md"
author: "David Peterson"
date: "Saturday, December 21, 2014"
output: html_document
---

This repo contains the run\_analysis.R file with the run\_anaysis() function which
reads the activity_labels.txt, features.txt, subject_test.txt, y_test.txt,
x_test.txt, subject_train.txt, y_train.txt, x_test.txt files. It then attaches
the features to the x_test and x_train data, attaches the subject_test and y_test 
to x_test and subject_train and y_train to y_train and attaches the descriptive
activity_labels to the combined data. It pulls out only the mean and standard
deviation data and rearranges it from a 82 column data frame to a 5 column data
frame containing the mean of the standard deviations and the means for each 
subject, activity and measurement
