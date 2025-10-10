Bank Loan Default Analysis Report

Jahnavi Kailasa Vani

Executive Summary

This project analyzes a bank loan dataset to predict loan default risk. Using historical loan data, the analysis identifies key predictors of default and develops predictive models to assist the bank in risk-based decision-making.

Key outcomes:

Random Forest model achieved the highest predictive accuracy (92.17%) and effectively identified high-risk borrowers.

Important predictors: debt-to-income ratio (DEBTINC), delinquencies (DELINQ), derogatory reports (DEROG), and loan amount (LOAN).

Created a Shiny dashboard to automate identification of high-risk borrowers using the Random Forest model.

This analysis demonstrates the ability to frame research questions, apply statistical methods, conduct predictive modeling, and communicate results for strategic decisions.

Objective

To predict whether a loan applicant will default and identify high-risk borrowers using historical financial and demographic data, enabling the bank to reduce risk and make data-driven lending decisions.

Analytical Approach
Data Exploration & Preprocessing

Dataset: 5,960 loan applications with 13 features

Addressed missing values (5,271 points) using KNN imputation and categorical grouping (“Others”)

Checked for zero values and outliers to ensure data quality

Target variable DEFAULT (binary: 0 = no default, 1 = default) was highly imbalanced (~9% defaults)

Handling Imbalanced Data

Applied ROSE (Random OverSampling Examples) to generate a balanced training set

Model Selection

Implemented Logistic Regression, Decision Trees (C5.0), and Random Forest

Evaluated performance using accuracy, sensitivity, specificity, and AUC-ROC

Exploratory Data Analysis (EDA)

Key insights:

Majority of loans were for Debt Consolidation (70%) vs. Home Improvement (30%)

Most borrowers had no derogatory reports (85%) and few delinquencies (72%)

Higher loan amounts, debt-to-income ratios, and derogatory reports correlated with defaults

Borrowers with longer credit histories (CLAGE) were less likely to default

Variable Analysis:

Type	Features
Categorical	JOB, REASON
Numeric	LOAN, MORTDUE, VALUE, YOJ, CLAGE, CLNO, DEBTINC
Ordinal	DEROG, DELINQ, NINQ
Model Development & Evaluation
Model	Accuracy	Sensitivity	Specificity	AUC
Logistic Regression	76.01%	76.52%	70.73%	0.79
Random Forest (60/40)	92.17%	95.94%	52.85%	0.82
Decision Tree (C5.0)	88.68%	95.47%	39.47%	0.77
Random Forest (70/30)	91.64%	95.32%	53.26%	0.82

Insights:

Random Forest consistently outperformed other models in predicting defaults

Logistic Regression offered balanced sensitivity and specificity, useful for overall risk assessment

Decision Tree was less effective in identifying defaulters (low specificity)

Shiny Dashboard:

Developed to predict creditworthiness of loan applicants using the Random Forest model

Enables lenders to instantly get predictions on potential defaults

Key Insights

High-risk borrowers tend to have:

High debt-to-income ratio (DEBTINC)

More delinquencies (DELINQ)

More derogatory reports (DEROG)

Higher loan amounts (LOAN)

Borrowers with longer credit histories and fewer inquiries are lower risk

Handling the imbalanced dataset (using ROSE) was crucial for accurate default identification

Recommendations

Integrate Random Forest predictions into the bank’s loan approval workflow

Implement risk-based pricing: lower rates for low-risk borrowers, stricter terms for high-risk borrowers

Focus on key predictors (DEBTINC, DELINQ, DEROG, LOAN) for early intervention strategies

Provide financial counseling or alternative repayment options to high-risk borrowers

Maintain regulatory compliance (ECOA) through transparent, data-driven lending decisions
