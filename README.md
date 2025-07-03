📌 Overview
This project demonstrates data cleaning and exploratory data analysis (EDA) using SQL Server on a synthetic customer dataset. The goal is to clean inconsistencies, fix missing/outlier values, normalize categorical data, and uncover insights through SQL-based aggregations.

📂 Dataset Description
The dataset (CustomerData) simulates customer records with the following columns:

Column	Description
CustomerID	Unique identifier for each customer
FullName	Full name of the customer
Age	Customer's age (may contain outliers)
Gender	Gender values (inconsistent casing/formats)
Income	Annual income (with some negative/nulls)
Region	Region of residence
PurchaseFrequency	Frequency of purchases (mixed formats)
SatisfactionScore	Customer satisfaction score (1–10)
Churned	Whether the customer has churned (Yes/No)

🔧 Cleaning Steps
Handled invalid or missing Age values

Replaced unrealistic ages (<10 or >100) with NULL

Imputed NULLs with median age using PERCENTILE_CONT

Standardized Gender values

Mapped variations like 'male', 'FEMALE', etc. to 'Male' or 'Female'

Cleaned Income column

Removed negative values and replaced missing values with median income

Normalized PurchaseFrequency values

Unified inconsistent entries like 'monthly' and 'Monthly'

Standardized Churned field

Mapped 'Y', 'yes', 'No', etc. to 'Yes' or 'No'

Corrected invalid SatisfactionScore entries

Replaced values outside 1–10 range with NULL and imputed with median

Removed duplicate records

Used ROW_NUMBER() to detect and delete duplicates

📊 Exploratory Data Analysis (EDA)
After cleaning, several SQL queries were used to explore the data:

Customer distribution by Region

Average Income by Region

Average SatisfactionScore by Purchase Frequency

Churn breakdown (Yes/No)

💡 Key Insights
Most customers are concentrated in a few regions

Satisfaction varies with purchase frequency — suggesting correlation with engagement

Income discrepancies across regions offer pricing strategy opportunities

Churn rate is significant and warrants retention analysis

🚀 Tools & Tech Stack
SQL Server (SSMS)

SQL Window Functions, CASE, PERCENTILE_CONT, JOIN, CTE

📁 How to Run
Import the CSV into SQL Server and create the CustomerData table

Run the provided SQL script to clean and analyze the data

(Optional) Connect to Power BI for dashboarding and visualization

