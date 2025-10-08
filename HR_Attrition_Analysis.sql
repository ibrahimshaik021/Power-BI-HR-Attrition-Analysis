-- HR ATTRITION ANALYSIS - COMPLETE PROJECT SCRIPT
-- Project by: Shaik Ibrahim
-- Tools: MySQL, Power BI



-- PART 1: SETUP SCRIPT

-- 1. Create the Database
-- This command creates the database where the project data will be stored.
CREATE DATABASE IF NOT EXISTS ibm_data;
USE ibm_data;

-- 2. Create the Table
-- This script creates the table with a schema that matches the source CSV file.
-- Best practices applied: a Primary Key is set on EmployeeNumber, and column names
-- are matched exactly to the source file for a smoother import process.

CREATE TABLE IF NOT EXISTS employee_data (
    Age INT,
    Attrition VARCHAR(3),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(1),
    OverTime VARCHAR(3),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

-- 3. Load the Data
-- The data was loaded into the created table from the 'IBM HR Analytics Employee Attrition & Performance.csv' 
-- file using MySQL Workbench's "Table Data Import Wizard". 
-- A total of 1470 rows were successfully imported.


-- ====================================================================
-- PART 2: ANALYSIS SCRIPT
-- ====================================================================

-- 1. Initial High-Level Analysis: Attrition Rate by Career Stage
-- This was the first major finding, identifying junior employees as the primary problem group.

SELECT 
    CASE 
        WHEN total_working_years < 2 THEN 'Early_Level'
        WHEN total_working_years < 4 THEN 'Mid_Level'
        WHEN total_working_years < 6 THEN 'Senior_Level'
        ELSE 'Expert_Level'
    END AS career_stage,
    COUNT(*) AS employee_count,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 1.0 / COUNT(*)) * 100 AS attrition_rate
FROM 
    employee_data
GROUP BY 
    career_stage
ORDER BY
    career_stage;

-- 2. Deep-Dive Analysis on Early-Level Employees (Total Working Years < 2)
-- The following queries focus only on the high-attrition "Early_Level" group.

-- 2a. Analysis by Overtime
-- This query proved that overtime is a major driver of attrition for junior employees.
SELECT 
    overtime,
    COUNT(*) AS employee_count,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 1.0 / COUNT(*)) * 100 AS attrition_rate
FROM 
    employee_data
WHERE 
    total_working_years < 2
GROUP BY 
    overtime;

-- 2b. Analysis by Job Satisfaction
-- This query proved that low job satisfaction is another key driver for junior employees.
SELECT 
    job_satisfaction,
    COUNT(*) AS employee_count,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 1.0 / COUNT(*)) * 100 AS attrition_rate
FROM 
    employee_data
WHERE 
    total_working_years < 2
GROUP BY 
    job_satisfaction
ORDER BY
    job_satisfaction;

-- 2c. Analysis by Department
-- This query identified the departments most affected by junior employee attrition.
SELECT 
    department,
    COUNT(*) AS employee_count,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 1.0 / COUNT(*)) * 100 AS attrition_rate
FROM 
    employee_data
WHERE 
    total_working_years < 2
GROUP BY 
    department;

-- 3. Hypothesis Testing: Percent Salary Hike
-- These queries tested the hypothesis that salary hikes were a factor and led to a "negative result".

-- 3a. Comparing Average Salary Hike for Leavers vs. Stayers (Early-Level only)
SELECT
    attrition,
    AVG(salaryhike_percantage) AS average_hike
FROM
    employee_data
WHERE
    total_working_years < 2
GROUP BY
    attrition;

-- 3b. Attrition Rate by Salary Hike Buckets (Early-Level only)
SELECT 
    CASE 
        WHEN salaryhike_percantage < 10 THEN 'Low'
        WHEN salaryhike_percantage < 20 THEN 'Medium'
        WHEN salaryhike_percantage < 30 THEN 'High'
        ELSE 'Very High'
    END AS hike_level,
    COUNT(*) AS employee_count,
    (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 1.0 / COUNT(*)) * 100 AS attrition_rate
FROM 
    employee_data
WHERE 
    total_working_years < 2
GROUP BY 
    hike_level;
