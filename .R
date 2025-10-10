# Load necessary libraries
install.packages(c("VIM", "MICE"))
install.packages("pillar")
install.packages("caret")
install.packages(("imblance"))
install.packages("DataExplorer")  # Install the package
install.packages("janitor")
install.packages("fastDummies")
install.packages("C50")
install.packages("imbalance")
install.packages("ROSE")
install.packages("corrplot")
install.packages("tidyverse")
install.packages("forecast")
install.packages("glmnet")

#install.packages("htmltools")

# Load the library
library(fastDummies)
library(DataExplorer)
library(VIM)
library(dplyr)
library(ggplot2)
library(caret)
library(ROSE)
library(C50)
library(corrplot)
library(e1071)
library(tidyverse)
library(randomForest)
library(forecast)
library(pROC)
library(imbalance)
library(glmnet)

# Data Pre-processing and Exploration
## Loading the data
df <- read.csv("C://Users//jahna//Downloads//Data Analytics//Practicum Analysis//Project - 2//loan.csv")
loan.df <- df ##representing dataframe into loan.df

## Inspecting the data
dim(loan.df)
class(loan.df)
colnames(loan.df)


## Checking for Missing Values
# Convert empty strings ("") to NA in the whole dataframe
loan.df[loan.df == ""] <- NA
sum(is.na(loan.df))  
#[1] 5271
plot_missing(loan.df)

# Replace missing values in JOB and REASON with "Other"
loan.df$JOB[is.na(loan.df$JOB) | loan.df$JOB == ""] <- "Other"
loan.df$REASON[is.na(loan.df$REASON) | loan.df$REASON == ""] <- "Other"

# Check the data to confirm the changes
sum(is.na(loan.df))  

loan.df <- (na.omit(loan.df))
dim(loan.df)
#[1] 3515   13

colSums(is.na(loan.df))
plot_missing(loan.df)
head(loan.df)

# Count zero values in each column
zero_values <- sum(loan.df == 0, na.rm = TRUE)
# Display columns with zero counts
print(zero_values)

#Data Inspection
head(loan.df)
tail(loan.df)

# Structure and Dimension of the dataset
str(loan.df)
summary(loan.df)

## Changing variable name "BAD" to "DEFAULT"
colnames(loan.df)[colnames(loan.df) == "BAD"] <- "DEFAULT"


##Distribution of variables
# Bar plot for BAD (Categorical)
ggplot(loan.df, aes(x = as.factor(DEFAULT))) +
  geom_bar(fill = "skyblue") +
  labs(title = "Distribution of Loan Defaults", x = "DEFAULT (0 = No Default, 1 = Default)", y = "Count") +
  theme_minimal()

## Proportions
prop.table(table(loan.df$DEFAULT)) * 100

# Bar plot for REASON (Categorical)
ggplot(loan.df, aes(x = REASON)) +
  geom_bar(fill = "lightgreen") +
  labs(title = "Distribution of Loan Reasons", x = "Reason", y = "Count") +
  theme_minimal()

## Proportions
prop.table(table(loan.df$REASON)) * 100

# Bar plot for JOB (Categorical)
ggplot(loan.df, aes(x = JOB)) +
  geom_bar(fill = "lightcoral") +
  labs(title = "Distribution of Job Categories", x = "Job", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Proportions
prop.table(table(loan.df$JOB)) * 100

# Histogram for Years on Job (YOJ)
ggplot(loan.df, aes(x = YOJ)) +
  geom_histogram(binwidth = 2, fill = "lightcoral", color = "black") +
  labs(title = "Distribution of Years on Job (YOJ)", x = "Years on Job", y = "Count") +
  theme_minimal()

## Proportions
prop.table(table(loan.df$YOJ)) * 100

# Histogram for Loan Amount (LOAN)
ggplot(loan.df, aes(x = LOAN)) +
  geom_histogram(binwidth = 5000, fill = "lightcoral", color = "black") +
  labs(title = "Distribution of Loan Amount", x = "Loan Amount", y = "Count") +
  theme_minimal()

# Histogram for Mortgage Due (MORTDUE)
ggplot(loan.df, aes(x = MORTDUE)) +
  geom_histogram(binwidth = 10000, fill = "lightblue", color = "black") +
  labs(title = "Distribution of Mortgage Due", x = "Mortgage Due", y = "Count") +
  theme_minimal()

# Histogram for Property Value (VALUE)
ggplot(loan.df, aes(x = VALUE)) +
  geom_histogram(binwidth = 10000, fill = "lightgreen", color = "black") +
  labs(title = "Distribution of Property Value", x = "Property Value", y = "Count") +
  theme_minimal()

# Histogram for Derogatory Reports (DEROG)
ggplot(loan.df, aes(x = DEROG)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "Distribution of Derogatory Reports", x = "Derogatory Reports", y = "Count") +
  theme_minimal()

# Histogram for Delinquent Reports (DELINQ) as Numeric
ggplot(loan.df, aes(x = as.numeric(DELINQ))) +
  geom_histogram(binwidth = 1, fill = "lightgreen", color = "black") +
  labs(title = "Distribution of Delinquent Reports", x = "Delinquent Reports", y = "Count") +
  theme_minimal()

# Histogram for Age of Oldest Credit Line (CLAGE)
ggplot(loan.df, aes(x = CLAGE)) +
  geom_histogram(binwidth = 10, fill = "lightcoral", color = "black") +
  labs(title = "Distribution of Age of Oldest Credit Line", x = "Age of Oldest Credit Line", y = "Count") +
  theme_minimal()

# Histogram for Number of Inquiries (NINQ) as Numeric
ggplot(loan.df, aes(x = as.numeric(NINQ))) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "Distribution of Number of Inquiries", x = "Number of Inquiries", y = "Count") +
  theme_minimal()

# Histogram for Number of Credit Lines (CLNO)
ggplot(loan.df, aes(x = CLNO)) +
  geom_histogram(binwidth = 5, fill = "lightgreen", color = "black") +
  labs(title = "Distribution of Number of Credit Lines", x = "Number of Credit Lines", y = "Count") +
  theme_minimal()

# Histogram for Debt-to-Income Ratio (DEBTINC)
ggplot(loan.df, aes(x = DEBTINC)) +
  geom_histogram(binwidth = 5, fill = "lightcoral", color = "black") +
  labs(title = "Distribution of Debt-to-Income Ratio", x = "Debt-to-Income Ratio", y = "Count") +
  theme_minimal()


##Variable Selection
set.seed(1)
library(randomForest)
randomP.model <- randomForest(DEFAULT ~ .,  data = loan.df)

## variable importance plot
var_importance <- varImp(randomP.model)
# Print variable importance summary
print(var_importance)

# Plot the variable importance
randomForest::varImpPlot(randomP.model, 
                         sort=TRUE, 
                         main="Variable Importance Plot")

## Generating Dummy Variables for Correlation Analysis, as Correlation is Applicable Only to 
##Numeric Variables
##Creating dummies for categorical
loan.df1 <- dummy_cols(loan.df,
                       remove_selected_columns = TRUE,
                       remove_first_dummy = TRUE)

dim(loan.df1)
loan.df1%>% head(2)

# Correlation Matrix
correlation_matrix <- cor(loan.df1)
correlation_matrix
# Create a basic correlation plot
corrplot(correlation_matrix, method = "number")


# Target variable: DEFAULT (0 = No Default, 1 = Default)

# Bar plot for REASON (Categorical)
ggplot(loan.df, aes(x = REASON, fill = factor(DEFAULT))) +
  geom_bar(position = "dodge") +
  labs(title = "Loan Reason vs. Default", x = "Reason", y = "Count", fill = "Default (0 = No, 1 = Yes)") +
  theme_minimal()

# Bar plot for JOB (Categorical)
ggplot(loan.df, aes(x = JOB, fill = factor(DEFAULT))) +
  geom_bar(position = "dodge") +
  labs(title = "Job vs. Default ", x = "Job", y = "Count", fill = "Default (0 = No, 1 = Yes)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Box plot for LOAN (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = LOAN, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Loan Amount vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "Loan Amount") +
  theme_minimal()

# Box plot for MORTDUE (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = MORTDUE, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Mortgage Due vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "Mortgage Due") +
  theme_minimal()

# Box plot for VALUE (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = VALUE, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Property Value vs. Default", x = "Default (0 = No, 1 = Yes)", y = "Property Value") +
  theme_minimal()

# Box plot for YOJ (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = YOJ, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Years on Job vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "Years on Job") +
  theme_minimal()

# Box plot for DEROG (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = DEROG, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Derogatory Reports vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "Derogatory Reports") +
  theme_minimal()

# Box plot for DELINQ (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = DELINQ, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Delinquency vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "Delinquency") +
  theme_minimal()

# Box plot for CLAGE (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = CLAGE, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Age of Oldest Credit Line (CLAGE) vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "CLAGE") +
  theme_minimal()

# Box plot for NINQ (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = NINQ, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Number of Inquiries (NINQ) vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "NINQ") +
  theme_minimal()

# Box plot for CLNO (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = CLNO, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Number of Credit Lines (CLNO) vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "CLNO") +
  theme_minimal()

# Box plot for DEBTINC (Numerical)
ggplot(loan.df, aes(x = factor(DEFAULT), y = DEBTINC, fill = factor(DEFAULT))) +
  geom_boxplot() +
  labs(title = "Debt-to-Income Ratio vs. Default ", x = "Default (0 = No, 1 = Yes)", y = "Debt-to-Income Ratio") +
  theme_minimal()


##Checking for Outliers
boxplot(loan.df1)

loan.df$DEFAULT <- as.factor(loan.df$DEFAULT)
loan.df$JOB <- as.factor(loan.df$JOB)
loan.df$REASON <- as.factor(loan.df$REASON)

#Set seed for reproducibility
set.seed(1)
# Split data into training and holdout sets
train_index <- createDataPartition(loan.df$DEFAULT, p = 0.6, list = FALSE)
train.df <- loan.df[train_index,]
holdout.df <-loan.df[-train_index,]

# Display dimensions of each partition
dim(train.df)
dim(holdout.df)

# Apply ROSE to balance the dataset
balanced_dataset <- ROSE(DEFAULT ~ ., data = train.df, seed = 123)$data

# View the distribution of the target variable in the balanced dataset
table(balanced_dataset$DEFAULT)

#check classes distribution
prop.table(table(balanced_dataset$DEFAULT))

# Check the structure of the balanced dataset
str(balanced_dataset)

# Calculate the imbalance ratio for the 'DEFAULT' column
imbalanceRatio(loan.df, classAttr = "DEFAULT")
##Logistic Regression
set.seed(1)
logreg_balanced <- glm(DEFAULT ~ ., data = balanced_dataset, family = "binomial")
# Get the exponentiated coefficients 
exp(logreg_balanced$coefficients)

# Predict on the holdout data
log.pred.balanced <- predict(logreg_balanced, newdata = holdout.df, type = "response")

# Modify ifelse to assign class "1" for probabilities > 0.5
log.class <- factor(ifelse(log.pred.balanced > 0.5, 1, 0), levels = c(1, 0))
test.pred <- factor(holdout.df$DEFAULT, levels = c("1", "0"))

# Evaluate the performance
confusionMatrix(log.class, test.pred, positive = "0")
cf <- confusionMatrix(log.class, test.pred, positive = "0")
fourfoldplot(as.table(cf),color=c("red", "green"),main = "Logistic Regression Confusion Matrix ")

##ROC Curve for Logistic Regression
roc_curve <- roc(holdout.df$DEFAULT, log.pred.balanced)
plot(roc_curve, col = "blue", main = "ROC Curve for Logistic Regression Model")

# Calculate AUC
auc_value <- auc(roc_curve)
print(paste("AUC:", auc_value))

##Random Forest
set.seed(123)
rf.model.balanced <- randomForest(DEFAULT ~ ., data = balanced_dataset, mtry = 3, ntree = 700)

# Check the model summary
print(rf.model.balanced)

# Predict on the holdout data
rf.pred.balanced <- predict(rf.model.balanced, holdout.df)
# Evaluate the performance
confusionMatrix(as.factor(rf.pred.balanced), holdout.df$DEFAULT)
cf <- confusionMatrix(as.factor(rf.pred.balanced), holdout.df$DEFAULT)
fourfoldplot(as.table(cf),color=c("coral", "lightblue"),main = "Random Forest Confusion Matrix ")

# Step 1: Predict probabilities for the Random Forest model
rf.prob <- predict(rf.model.balanced, holdout.df, type = "prob")[, 2]  # Get probabilities for class "1" (positive class)

# Step 2: Generate ROC curve and calculate AUC
rf.roc <- roc(holdout.df$DEFAULT, rf.prob, levels = rev(levels(holdout.df$DEFAULT)))

# Step 3: Plot the ROC curve
plot(rf.roc, col = "blue", main = "Random Forest ROC Curve")

# Step 4: Display the AUC
rf.auc <- auc(rf.roc)
print(paste("AUC for Random Forest: ", rf.auc))


##Desion Tree using C5.0
dt.model.balanced <- C5.0(balanced_dataset[, (-1)], balanced_dataset$DEFAULT)

# Check the model summary
summary(dt.model.balanced)
plot(dt.model.balanced)

# Predict on the holdout data
dt.pred.balanced <- predict(dt.model.balanced, holdout.df[-1])

# Evaluate the model performance using a confusion matrix
confusionMatrix(as.factor(holdout.df$DEFAULT), as.factor(dt.pred.balanced), positive = "0")
cf <- confusionMatrix(as.factor(holdout.df$DEFAULT), as.factor(dt.pred.balanced), positive = "0")
fourfoldplot(as.table(cf),color=c("coral", "lightgreen"),main = "Decision Tree Confusion Matrix ")

# Predict probabilities
dt.prob.balanced <- predict(dt.model.balanced, holdout.df[-1], type = "prob")
prob.default <- dt.prob.balanced[, "1"]

# Create ROC curve
roc_curve <- roc(holdout.df$DEFAULT, prob.default, levels = c("0", "1"))

# Plot the ROC curve
plot(roc_curve, col = "blue", main = "ROC Curve", lwd = 2)

# Calculate AUC
auc_value <- auc(roc_curve)
print(auc_value)



