# week3-statistical-analysis-predictive-modeling-r
Week 3 internship project on statistical analysis and predictive modeling using R and the Titanic dataset.
# Week 3 - Statistical Analysis and Predictive Modeling using R

## Project Overview

This project focuses on statistical analysis and predictive modeling using R and the Titanic dataset.

The Titanic dataset is used to perform exploratory statistical analysis, hypothesis testing, correlation analysis, and classification modeling.

A Logistic Regression model is developed to predict whether a passenger survived based on important passenger characteristics.

This project continues the data analysis work completed in Week 1 and Week 2.

## Objectives

- Perform statistical analysis using R
- Explore the Titanic dataset
- Calculate summary statistics
- Analyze correlations between numerical variables
- Perform hypothesis testing
- Study relationships between variables
- Build a classification model
- Use Logistic Regression for prediction
- Split the dataset into training and testing data
- Perform cross-validation
- Evaluate model performance
- Generate a confusion matrix
- Analyze model limitations
- Communicate statistical and predictive insights

## Dataset

The Titanic dataset contains information about passengers who travelled on the RMS Titanic.

Important variables include:

| Variable | Description |
|---|---|
| PassengerId | Unique passenger identification |
| Survived | Survival status |
| Pclass | Passenger class |
| Name | Passenger name |
| Sex | Gender |
| Age | Passenger age |
| SibSp | Number of siblings/spouses |
| Parch | Number of parents/children |
| Fare | Ticket fare |
| Embarked | Port of embarkation |

The cleaned dataset from Week 1 is used for this project.

## Why Titanic Dataset?

The Titanic dataset is suitable for predictive modeling because it contains both numerical and categorical variables.

The target variable `Survived` has two possible outcomes:

- 0 - Did not survive
- 1 - Survived

Therefore, Logistic Regression can be used as a classification model.

## Tools and Technologies

- R
- RStudio
- ggplot2
- dplyr
- caret
- CSV Dataset
- GitHub

## Statistical Analysis

The following statistical techniques are used:

- Descriptive statistics
- Mean
- Median
- Minimum and maximum
- Standard deviation
- Correlation analysis
- Normality analysis
- Hypothesis testing
- Chi-square test

## Hypothesis Testing

### Hypothesis

Null Hypothesis (H0):

There is no significant relationship between passenger gender and survival.

Alternative Hypothesis (H1):

There is a significant relationship between passenger gender and survival.

A Chi-square test is performed to test this hypothesis.

## Predictive Model

Logistic Regression is used to predict passenger survival.

The target variable is:

`Survived`

Predictor variables include:

- Age
- Sex
- Pclass
- SibSp
- Parch
- Fare

## Model Evaluation

The model is evaluated using:

- Accuracy
- Precision
- Recall
- F1 Score
- Confusion Matrix

## Cross-Validation

Cross-validation is used to improve the reliability of model evaluation.

The training dataset is divided into multiple folds and the model is trained and evaluated repeatedly.

## Project Workflow

```text
Titanic Dataset
       ↓
Data Import
       ↓
Data Inspection
       ↓
Statistical Analysis
       ↓
Hypothesis Testing
       ↓
Correlation Analysis
       ↓
Train-Test Split
       ↓
Logistic Regression
       ↓
Cross-Validation
       ↓
Model Prediction
       ↓
Confusion Matrix
       ↓
Performance Evaluation
       ↓
Final Interpretation
