## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Objective](#objective)
3. [Analytical Approach](#analytical-approach)
   - [Data Exploration & Preprocessing](#data-exploration--preprocessing)
   - [Handling Imbalanced Data](#handling-imbalanced-data)
4. [Model Development & Evaluation](#model-development--evaluation)
5. [Key Insights](#key-insights)
6. [Recommendations](#recommendations)
7. [Shiny Dashboard](#shiny-dashboard)

## Executive Summary

This project analyzes a bank loan dataset to predict the risk of loan defaults. By identifying high-risk borrowers using predictive models, this analysis aids in making data-driven lending decisions.

### Key Outcomes:
- **Random Forest Model** achieved the highest accuracy at 92.17%, successfully identifying high-risk borrowers.
- Key predictors of loan defaults:
  - **Debt-to-Income Ratio (DEBTINC)**
  - **Delinquencies (DELINQ)**
  - **Derogatory Reports (DEROG)**
  - **Loan Amount (LOAN)**
- A **Shiny Dashboard** was created to automate high-risk borrower identification.

This report demonstrates the ability to apply statistical methods, predictive modeling, and communicate results to support strategic decision-making.

## Objective

The objective of this analysis is to predict the likelihood of loan defaults and identify high-risk borrowers, enabling the bank to:
- Reduce risk exposure
- Make data-driven lending decisions

## Analytical Approach

### Data Exploration & Preprocessing

- **Dataset**: 5,960 loan applications, each with 13 features.
- **Data Cleaning**:
  - Addressed missing values using **KNN imputation** and categorical grouping.
  - Checked for zero values and outliers to ensure data quality.
  - The target variable (**DEFAULT**) was highly imbalanced (~9% defaults).

### Handling Imbalanced Data

- Applied **ROSE (Random OverSampling Examples)** to generate a balanced training dataset, improving model accuracy for default prediction.

## Model Development & Evaluation

Various machine learning models were implemented and evaluated for predicting loan defaults:

| Model                     | Accuracy | Sensitivity | Specificity | AUC  |
|---------------------------|----------|-------------|-------------|------|
| Logistic Regression        | 76.01%   | 76.52%      | 70.73%      | 0.79 |
| Random Forest (60/40)      | 92.17%   | 95.94%      | 52.85%      | 0.82 |
| Decision Tree (C5.0)       | 88.68%   | 95.47%      | 39.47%      | 0.77 |
| Random Forest (70/30)      | 91.64%   | 95.32%      | 53.26%      | 0.82 |

### Insights:
- **Random Forest** consistently outperformed other models in terms of accuracy and sensitivity.
- **Logistic Regression** provided a balanced view of sensitivity and specificity.
- **Decision Tree (C5.0)** was less effective in identifying defaults due to lower specificity.

## Key Insights

From the exploratory data analysis and model evaluation, the following insights were derived:

- High-risk borrowers typically have:
  - High **Debt-to-Income Ratio (DEBTINC)**
  - More **Delinquencies (DELINQ)**
  - More **Derogatory Reports (DEROG)**
  - Larger **Loan Amounts (LOAN)**
- Borrowers with longer credit histories (**CLAGE**) and fewer inquiries (**NINQ**) are less likely to default.

## Recommendations

- **Integrate Random Forest Predictions** into the bank's loan approval workflow.
- Implement **Risk-Based Pricing**:
  - Lower interest rates for low-risk borrowers.
  - Stricter terms for high-risk borrowers.
- Focus on key predictors like **DEBTINC**, **DELINQ**, **DEROG**, and **LOAN** for early intervention strategies.
- Offer **financial counseling** or **alternative repayment options** for high-risk borrowers.
- Ensure **regulatory compliance (ECOA)** by using data-driven lending decisions.

## Shiny Dashboard

- A **Shiny Dashboard** was developed to automate the prediction of loan default risk using the **Random Forest Model**.
- The dashboard provides real-time predictions, enabling lenders to instantly assess an applicant’s default risk.
