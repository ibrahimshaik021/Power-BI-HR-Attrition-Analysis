# HR Analytics Dashboard: A Deep-Dive into Employee Attrition

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)

---

### Table of Contents
* [Problem Statement](#problem-statement)
* [Project Workflow](#project-workflow)
* [Final Dashboard](#final-dashboard)
* [Actionable Insights](#actionable-insights)
* [Technical Details](#technical-details)
* [Repository Contents](#repository-contents)

---

## Problem Statement

Employee attrition is a significant challenge for businesses, leading to increased recruitment costs, loss of institutional knowledge, and decreased morale. This project sought to analyze a comprehensive HR dataset to identify the primary factors driving employee turnover.

The key questions addressed were:
1.  Which employee demographic is most at risk of leaving?
2.  What are the most significant workplace factors (e.g., compensation, workload, satisfaction) that correlate with attrition?
3.  What actionable, data-driven recommendations can be made to the HR department to improve employee retention?

---

## Project Workflow
This project was executed in a two-phase process: a deep-dive analysis in SQL followed by the development of an interactive dashboard in Power BI.

**SQL Analysis ➔ Power BI Modeling & Visualization ➔ Final Dashboard**

---

## Final Dashboard
The final deliverable is a dynamic, single-page Power BI dashboard designed for an executive audience. It provides a high-level overview of the key KPIs and allows for interactive exploration of the underlying drivers of attrition.


## Actionable Insights

### Primary Insight: The "New Hire" Problem
The analysis conclusively shows that the attrition risk is most acute for **junior employees with less than two years of experience**. This group has an attrition rate of nearly **49%**, highlighting a potential issue in the company's onboarding, training, or early-career development processes.

### Key Drivers of Attrition (for Junior Employees)
* **Overtime is the strongest predictor of attrition.** Junior employees who work overtime are more than twice as likely to leave (76% attrition rate) as those who do not (36%).
* **Low Job Satisfaction is a critical factor.** The attrition rate for employees with the lowest satisfaction score (69%) is nearly double that of employees with high satisfaction (36%).
* **The problem is department-specific.** The issue is most severe in the **Sales (62.5%)** and **Human Resources (75%)** departments, suggesting that company-wide solutions may be less effective than targeted departmental interventions.

### Disproven Hypotheses (Negative Findings)
* **Compensation is not the primary issue.** The analysis showed no significant difference in attrition rates based on the size of an employee's annual salary hike, disproving the initial hypothesis that junior employees were leaving for better pay.
* **Work-Life Balance scores did not correlate with attrition.** This suggests that the issue is less about the number of hours worked (as perceived in a WLB score) and more about the stress and pressure associated with **overtime**.

---

## Technical Details

1.  **Data Analysis (SQL):** All analytical queries were performed in MySQL. The process involved identifying the key problem cohort (junior employees) and then running a series of sub-queries to test hypotheses related to various workplace factors.
2.  **Data Modeling (Power BI):** The data was loaded from MySQL into Power BI. Data types were corrected in Power Query. A `career_stage` calculated column was created using DAX to categorize employees based on their tenure.
3.  **DAX Measures:** Core KPIs were calculated using DAX. The `DIVIDE` function was used for safe division, and `CALCULATE` was used to create context-specific counts for the numerator of the attrition rate.

---

## Repository Contents
* **`HR_Attrition_Analysis.sql`:** The complete SQL script, including the database/table setup and all analytical queries.
* **`Final Dashboard Screenshot.png`:** A high-resolution image of the final Power BI dashboard.
* **`IBM_HR_Attrition Project.pbix`:** The full, interactive Power BI report file.
