Executive Summary
This project analyzes a bank loan dataset to predict loan default risk. Using historical loan data, the analysis identifies key predictors of default and develops predictive models to assist the bank in risk-based decision-making.
Key outcomes:
•	Random Forest model achieved the highest predictive accuracy (92.17%) and effectively identified high-risk borrowers.
•	Important predictors: debt-to-income ratio (DEBTINC), delinquencies (DELINQ), derogatory reports (DEROG), and loan amount (LOAN).
•	Created a dashboard (using Shiny) that automates identifying high-risk borrowers using Random Forest model.
This analysis demonstrates the ability to frame research questions, apply statistical methods, conduct predictive modeling, and communicate results for strategic decisions.

1. Objective
To predict whether a loan applicant will default and identify high-risk borrowers using historical financial and demographic data, enabling the bank to reduce risk and make data-driven lending decisions.

2. Analytical Approach
1.	Data Exploration & Preprocessing
•	Dataset: 5,960 loan applications with 13 features.
 
•	Addressed missing values (5,271 missing points) using KNN imputation and categorical grouping (“Others”).
 
•	Checked for zero values and outliers to ensure data quality.
•	Target variable DEFAULT (binary: 0 = no default, 1 = default) was highly imbalanced (~9% defaults).
 
               
2.	Handling Imbalanced Data
o	Applied ROSE (Random OverSampling Examples) to generate a balanced training set.
 
3.	Model Selection
o	Implemented Logistic Regression, Decision Trees (C5.0), and Random Forest.
o	Evaluated performance using accuracy, sensitivity, specificity, and AUC-ROC.

3. Exploratory Data Analysis (EDA)
•	Key insights:
o	Majority of loans for Debt Consolidation (70%) vs. Home Improvement (30%).
o	Most borrowers had no derogatory reports (85%) and few delinquencies (72%).
o	Higher loan amounts, debt-to-income ratios, and number of derogatory reports correlated with defaults.
o	Borrowers with longer credit histories (CLAGE) were less likely to default.
•	Variable Analysis:
o	Categorical: JOB, REASON
o	Numeric: LOAN, MORTDUE, VALUE, YOJ, CLAGE, CLNO, DEBTINC
o	Ordinal: DEROG, DELINQ, NINQ
4. Model Development & Evaluation
Model	Accuracy	Sensitivity	Specificity	AUC
Logistic Regression	76.01%	76.52%	70.73%	0.79
Random Forest (60/40)	92.17%	95.94%	52.85%	0.82
Decision Tree (C5.0)	88.68%	95.47%	39.47%	0.77
Random Forest (70/30)	91.64%	95.32%	53.26%	0.82
Insights:
•	Random Forest consistently outperformed others in predicting defaults.
•	Logistic Regression offered more balanced sensitivity and specificity, useful for balanced risk assessment.
•	Decision Tree was less effective in identifying defaulters (low specificity).
In addition, Shiny dashboard was developed to predict the creditworthiness of loan applicants based on the Random Forest model. The primary reason for creating this dashboard was to provide lenders, and decision-makers to instantly get a prediction on whether the applicant is likely to default on a loan.

5. Key Insights
•	High-risk borrowers tend to have:
o	High debt-to-income ratio (DEBTINC)
o	More delinquencies (DELINQ)
o	More derogatory reports (DEROG)
o	Higher loan amounts (LOAN)
•	Borrowers with longer credit histories and fewer inquiries are lower risk.
•	Imbalanced dataset handling (ROSE) was crucial to accurately identify defaulters.
6. Recommendations
1.	Integrate Random Forest predictions into the bank’s loan approval workflow.
2.	Implement risk-based pricing: lower rates for low-risk borrowers, stricter terms for high-risk borrowers.
3.	Focus on key predictors (DEBTINC, DELINQ, DEROG, LOAN) for early intervention strategies.
4.	Provide financial counseling or alternative repayment options to high-risk borrowers.
5.	Maintain regulatory compliance with ECOA by using transparent, data-driven lending decisions.

