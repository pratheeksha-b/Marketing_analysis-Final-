# Marketing_analysis-Final-
# Marketing Campaign Performance Analysis using Python & SQL

## Project Overview

This project presents an end-to-end analysis of marketing campaign data using both **Python** and **SQL** to evaluate campaign performance and generate actionable business insights. The objective was to understand the factors influencing **Return on Investment (ROI)**, **Conversion Rate**, **Click-Through Rate (CTR)**, and **Customer Engagement**, while demonstrating expertise in data analysis, statistical modeling, machine learning, and database querying.

Python was used for data preprocessing, exploratory data analysis (EDA), feature engineering, statistical hypothesis testing, machine learning, clustering, anomaly detection, and visualization. SQL was used to perform advanced business analytics through analytical queries, Common Table Expressions (CTEs), window functions, views, and stored procedures, enabling efficient reporting and KPI analysis.


## Project Objectives

* Analyze marketing campaign performance across multiple business dimensions.
* Measure key performance indicators such as ROI, CTR, Conversion Rate, Revenue, and Customer Engagement.
* Identify high-performing companies, campaign types, customer segments, and marketing channels.
* Discover trends and seasonal patterns affecting campaign performance.
* Validate business assumptions using statistical hypothesis testing.
* Predict campaign ROI using machine learning techniques.
* Segment campaigns based on performance characteristics.
* Detect anomalous campaigns that require business attention.
* Automate reporting using SQL views and stored procedures.


## Tools and Technologies

### Python

* Pandas
* NumPy
* Matplotlib
* SciPy
* Statsmodels
* Scikit-learn

### SQL

* MySQL
* Aggregate Functions
* GROUP BY and HAVING
* CASE Statements
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* Views
* Stored Procedures
* Date Functions


## Data Preparation

* Cleaned and preprocessed the dataset.
* Handled data types and missing values.
* Extracted useful date-based features.
* Created new business metrics including:

  * Cost Per Click (CPC)
  * Click-Through Rate (CTR)
  * Campaign Efficiency
  * Revenue
  * ROI Categories


## Exploratory Data Analysis (EDA)

Comprehensive exploratory analysis was performed to understand campaign performance across multiple dimensions:

* Campaign Type
* Marketing Channel
* Company
* Customer Segment
* Gender
* Age Group
* Location
* Monthly and Weekday Trends
* Revenue Distribution
* Engagement Score Analysis
* ROI Distribution


## Statistical Analysis

The following statistical methods were applied to validate business insights:

* Independent t-Test
* ANOVA
* Chi-Square Test
* Kruskal-Wallis Test
* Pearson Correlation
* Confidence Interval Analysis

These tests helped determine whether differences in campaign performance across customer groups, campaign types, and marketing channels were statistically significant.


## Machine Learning & Advanced Analytics

* Built a Linear Regression model to predict ROI.
* Applied Principal Component Analysis (PCA) for dimensionality reduction.
* Performed customer/campaign segmentation using K-Means Clustering.
* Detected unusual campaign behavior using Isolation Forest.
* Evaluated relationships between engagement metrics and campaign outcomes.


## SQL Business Analysis

Advanced SQL queries were developed to answer real-world business questions and automate reporting.

### Business Analysis Performed

* Company-wise ROI analysis
* Campaign performance comparison
* Channel-wise Click-Through Rate (CTR) analysis
* Revenue analysis
* Customer segmentation
* Monthly performance analysis
* Ranking companies and campaigns
* Running totals
* Percentage contribution analysis
* Company performance against average ROI
* Engagement score analysis
* Marketing cost analysis
* Conversion Rate analysis


## Advanced SQL Concepts Demonstrated

* Aggregate Functions
* GROUP BY & HAVING
* CASE Statements
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions (ROW_NUMBER, DENSE_RANK, LAG, Running Totals)
* Views
* Stored Procedures
* Business KPI Calculations


## Database Objects Created

* Analytical SQL Queries
* Reusable Views
* Parameterized Stored Procedures
* Monthly Reporting Views
* Engagement Analytics Views


## Key Findings

- Campaign Type Performance: Different campaign types showed variations in average ROI and Conversion Rate, indicating that some marketing strategies are more effective than others.

*Average ROI by Campaign Type
<img width="547" height="512" alt="image" src="https://github.com/user-attachments/assets/4b441396-de1e-4532-9b53-a96c7dff728d" />


*Conversion Rate Campaign Type

<img width="565" height="512" alt="image" src="https://github.com/user-attachments/assets/93ee1766-7591-4ac8-9a3b-d0a1efb68fe3" />


- Cost vs ROI: Several campaigns achieved above-average ROI despite having below-average acquisition costs, suggesting that higher marketing expenditure does not always guarantee better returns.
<img width="554" height="433" alt="image" src="https://github.com/user-attachments/assets/32a261e1-1fa2-42d4-8626-bb99e0b43832" />


- Customer Engagement: Engagement levels varied across different age groups, highlighting the importance of understanding the target audience for improving campaign effectiveness.
<img width="547" height="459" alt="image" src="https://github.com/user-attachments/assets/3f6b0f13-96f5-43f6-b466-ed6aac20f81a" />


- Marketing Channels: The Click-to-Impression Ratio (CTR) differed across marketing channels, showing that certain channels generated better customer interaction and click performance.

- Statistical Analysis: Hypothesis tests such as ANOVA, t-test, Chi-square, and Kruskal-Wallis were performed to determine whether differences between groups were statistically significant rather than due to random variation.

- Relationship Between Variables: Correlation and regression analysis indicated a positive relationship between Engagement Score and Conversion Rate, suggesting that higher customer engagement generally leads to better conversion performance.
<img width="602" height="453" alt="image" src="https://github.com/user-attachments/assets/c5684b3e-3eff-4e71-8692-2a021a294cff" />


- Seasonal Trends: Campaign performance metrics varied across different months and weekdays, indicating that timing can influence marketing outcomes.
<img width="571" height="453" alt="image" src="https://github.com/user-attachments/assets/70476f02-6108-4d6e-953e-b05ad22945aa" />
<img width="585" height="453" alt="image" src="https://github.com/user-attachments/assets/a502f685-c613-4f4d-9bb5-3bafdcf9946e" />
<img width="990" height="390" alt="image" src="https://github.com/user-attachments/assets/3d2d7489-40a5-4628-90e3-1836e015288b" />




- Campaign Segmentation: K-Means clustering grouped campaigns with similar characteristics, helping identify patterns that can support targeted marketing strategies.


- Anomaly Detection: Isolation Forest successfully identified campaigns with unusual Cost Per Click (CPC) values, which can help detect inefficient campaigns or potential data anomalies for further investigation.
<img width="695" height="545" alt="image" src="https://github.com/user-attachments/assets/6e1f8bf7-e4f2-4e74-ab58-2a87d424e1fe" />


## Skills Demonstrated

### Python

* Data Cleaning & Preprocessing
* Exploratory Data Analysis (EDA)
* Feature Engineering
* Statistical Analysis
* Machine Learning
* Clustering
* Anomaly Detection
* Data Visualization

### SQL

* Data Retrieval & Manipulation
* Advanced Query Writing
* Business KPI Analysis
* Window Functions
* Common Table Expressions (CTEs)
* Views
* Stored Procedures
* Query Optimization
* Report Automation


## Business Impact

This project demonstrates how Python and SQL can be integrated to perform comprehensive marketing analytics. Python enables advanced statistical analysis, predictive modeling, and machine learning, while SQL provides efficient business reporting and KPI monitoring. Together, these technologies support data-driven decision-making by helping organizations optimize marketing strategies, improve customer engagement, identify high-performing campaigns, and maximize return on investment.


## Conclusion

This project showcases a complete marketing analytics workflow, combining SQL-based business intelligence with Python-driven data science techniques. It covers the entire analytics lifecycle—from data preparation and exploration to statistical validation, predictive modeling, clustering, anomaly detection, and automated reporting. The project highlights strong proficiency in SQL, Python, machine learning, and business analytics, making it a comprehensive portfolio project aligned with real-world data analyst and business intelligence responsibilities.
