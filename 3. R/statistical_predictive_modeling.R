# ============================================
# WEEK 3
# STATISTICAL ANALYSIS AND PREDICTIVE MODELING
# ============================================

# Install packages if required
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("caret")

library(ggplot2)
library(dplyr)
library(caret)

# ============================================
# 1. IMPORT DATASET
# ============================================

data <- read.csv(
  "data/titanic_cleaned.csv",
  stringsAsFactors = FALSE
)

print(head(data))
print(str(data))
print(summary(data))
print(dim(data))

# ============================================
# 2. CONVERT VARIABLES
# ============================================

data$Sex <- as.factor(data$Sex)
data$Pclass <- as.factor(data$Pclass)
data$Embarked <- as.factor(data$Embarked)

# ============================================
# 3. SUMMARY STATISTICS
# ============================================

summary_stats <- data %>%
  summarise(
    Mean_Age = mean(Age, na.rm = TRUE),
    Median_Age = median(Age, na.rm = TRUE),
    SD_Age = sd(Age, na.rm = TRUE),
    Mean_Fare = mean(Fare, na.rm = TRUE),
    Median_Fare = median(Fare, na.rm = TRUE),
    SD_Fare = sd(Fare, na.rm = TRUE),
    Survival_Rate = mean(Survived, na.rm = TRUE) * 100
  )

print(summary_stats)

write.csv(
  summary_stats,
  "output/summary_statistics.csv",
  row.names = FALSE
)

# ============================================
# 4. AGE DISTRIBUTION
# ============================================

png(
  "output/age_distribution.png",
  width = 1000,
  height = 700
)

ggplot(
  data,
  aes(x = Age)
) +
  geom_histogram(
    bins = 30,
    fill = "steelblue",
    color = "black"
  ) +
  labs(
    title = "Age Distribution",
    x = "Age",
    y = "Number of Passengers"
  ) +
  theme_minimal()

dev.off()

# ============================================
# 5. FARE DISTRIBUTION
# ============================================

png(
  "output/fare_distribution.png",
  width = 1000,
  height = 700
)

ggplot(
  data,
  aes(x = Fare)
) +
  geom_histogram(
    bins = 30,
    fill = "steelblue",
    color = "black"
  ) +
  labs(
    title = "Fare Distribution",
    x = "Fare",
    y = "Number of Passengers"
  ) +
  theme_minimal()

dev.off()

# ============================================
# 6. SURVIVAL BY GENDER
# ============================================

png(
  "output/survival_by_gender.png",
  width = 1000,
  height = 700
)

ggplot(
  data,
  aes(
    x = Sex,
    fill = factor(Survived)
  )
) +
  geom_bar() +
  labs(
    title = "Survival by Gender",
    x = "Gender",
    y = "Number of Passengers",
    fill = "Survived"
  ) +
  theme_minimal()

dev.off()

# ============================================
# 7. SURVIVAL BY CLASS
# ============================================

png(
  "output/survival_by_class.png",
  width = 1000,
  height = 700
)

ggplot(
  data,
  aes(
    x = Pclass,
    fill = factor(Survived)
  )
) +
  geom_bar() +
  labs(
    title = "Survival by Passenger Class",
    x = "Passenger Class",
    y = "Number of Passengers",
    fill = "Survived"
  ) +
  theme_minimal()

dev.off()

# ============================================
# 8. CORRELATION ANALYSIS
# ============================================

numeric_data <- data %>%
  select(
    Survived,
    Age,
    SibSp,
    Parch,
    Fare
  )

correlation_matrix <- cor(
  numeric_data,
  use = "complete.obs"
)

print(correlation_matrix)

write.csv(
  correlation_matrix,
  "output/correlation_matrix.csv"
)

# ============================================
# 9. CORRELATION HEATMAP
# ============================================

png(
  "output/correlation_heatmap.png",
  width = 1000,
  height = 700
)

heatmap(
  correlation_matrix,
  main = "Correlation Heatmap"
)

dev.off()

# ============================================
# 10. HYPOTHESIS TESTING
# ============================================

gender_test <- chisq.test(
  table(data$Sex, data$Survived)
)

print(gender_test)

capture.output(
  gender_test,
  file = "output/hypothesis_test.txt"
)

# ============================================
# 11. TRAIN-TEST SPLIT
# ============================================

set.seed(123)

data$Survived <- as.factor(data$Survived)

train_index <- createDataPartition(
  data$Survived,
  p = 0.80,
  list = FALSE
)

train_data <- data[train_index, ]
test_data <- data[-train_index, ]

print(dim(train_data))
print(dim(test_data))

# ============================================
# 12. LOGISTIC REGRESSION MODEL
# ============================================

model <- glm(
  Survived ~ Age + Sex + Pclass + SibSp + Parch + Fare,
  data = train_data,
  family = binomial
)

print(summary(model))

capture.output(
  summary(model),
  file = "output/model_summary.txt"
)

# ============================================
# 13. CROSS-VALIDATION
# ============================================

set.seed(123)

control <- trainControl(
  method = "cv",
  number = 5
)

cv_model <- train(
  Survived ~ Age + Sex + Pclass + SibSp + Parch + Fare,
  data = train_data,
  method = "glm",
  family = binomial,
  trControl = control
)

print(cv_model)

capture.output(
  cv_model,
  file = "output/cross_validation.txt"
)

# ============================================
# 14. PREDICTION
# ============================================

probability <- predict(
  model,
  newdata = test_data,
  type = "response"
)

prediction <- ifelse(
  probability >= 0.5,
  1,
  0
)

prediction <- factor(
  prediction,
  levels = c(0, 1)
)

actual <- factor(
  test_data$Survived,
  levels = c(0, 1)
)

# ============================================
# 15. CONFUSION MATRIX
# ============================================

confusion <- confusionMatrix(
  prediction,
  actual,
  positive = "1"
)

print(confusion)

capture.output(
  confusion,
  file = "output/confusion_matrix.txt"
)

# ============================================
# 16. SAVE PREDICTIONS
# ============================================

predictions <- data.frame(
  Actual = actual,
  Predicted = prediction,
  Probability = probability
)

write.csv(
  predictions,
  "output/model_predictions.csv",
  row.names = FALSE
)

# ============================================
# 17. CONFUSION MATRIX TABLE
# ============================================

confusion_table <- as.data.frame(
  table(
    Actual = actual,
    Predicted = prediction
  )
)

write.csv(
  confusion_table,
  "output/confusion_matrix.csv",
  row.names = FALSE
)

# ============================================
# 18. CONFUSION MATRIX VISUALIZATION
# ============================================

png(
  "output/confusion_matrix.png",
  width = 1000,
  height = 700
)

ggplot(
  confusion_table,
  aes(
    x = Actual,
    y = Predicted,
    fill = Freq
  )
) +
  geom_tile() +
  geom_text(
    aes(label = Freq),
    size = 8
  ) +
  labs(
    title = "Confusion Matrix",
    x = "Actual",
    y = "Predicted"
  ) +
  theme_minimal()

dev.off()

# ============================================
# 19. MODEL ACCURACY
# ============================================

accuracy <- mean(
  prediction == actual
)

print(
  paste(
    "Model Accuracy:",
    round(accuracy * 100, 2),
    "%"
  )
)

# ============================================
# 20. RESIDUAL PLOT
# ============================================

png(
  "output/residual_plot.png",
  width = 1000,
  height = 700
)

plot(
  model,
  which = 1
)

dev.off()

# ============================================
# 21. FINAL OUTPUT
# ============================================

print("Statistical analysis completed successfully.")

print("Hypothesis testing completed.")

print("Logistic Regression model completed.")

print("Cross-validation completed.")

print("Model evaluation completed.")

print("Week 3 project completed successfully.")
