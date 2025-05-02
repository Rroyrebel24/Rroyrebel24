# Midterm Lab Task 2 - Data Cleaning and Transformation using Power Query 📌

## Task Description

Hey there! I'm **Roel**, and I worked on this project where **Company X** wanted to extract useful insights from the **Uncleaned_DS_jobs.csv** dataset from Kaggle. The dataset required quite a bit of cleaning and transformation to answer a few critical questions such as:

- Which job roles pay the highest and least?
- What size companies pay the best?
- Where do job roles or job titles pay the best and least in a specific state?

I used **Power Query** in Excel to clean the data, categorize job roles, handle missing/negative values, and restructure the dataset for better analysis.

## 📂 Dataset Overview

- **Dataset Name:** Uncleaned_DS_jobs.csv
- **Source:** Kaggle
- **Loaded in:** Power Query (Excel)

### 📸 Before Cleaning (Raw Dataset)
[👉 Raw Dataset](Screenshot1.png)

---

## 🔧 Data Cleaning & Transformation Steps

### 1️⃣ Salary Estimate Cleaning
- Removed unwanted characters (everything after `(` in the **Salary Estimate** column).
- Created **Min Sal** and **Max Sal** columns using "Column from Examples."

### 2️⃣ Categorizing Job Roles
- Created a new column called **Role Type** by grouping job titles into:
  - Data Scientist
  - Data Analyst
  - Data Engineer
  - Machine Learning Engineer
  - Other

### 3️⃣ Splitting Location Information
- Split the **Location** column using `,` as a delimiter.
- Handled cases where the state was missing or needed correction.
- Created a **State Abbreviation** column and replaced incorrect values.

### 4️⃣ Handling Missing & Negative Values
- Filtered and removed `-1` values in **Competitors**, **Industry**, and **Revenue** columns.
- Replaced `0` values in the **Revenue** column.

### 5️⃣ Cleaning Company Names
- Removed company ratings from the **Company Name** column.

### 6️⃣ Splitting & Transforming Company Size
- Split the **Size** column into **MinCompanySize** and **MaxCompanySize**.

---

## 📊 Reshaping & Grouping Data

### 1️⃣ Salary by Role Type
- Grouped by **Role Type** and calculated the average **Min** and **Max** salary for each type.

### 2️⃣ Salary by Company Size
- Grouped by **Company Size** and calculated the average **Min** and **Max** salary for each size category.

### 3️⃣ Salary by State
- Merged the dataset with a state mapping file to get full state names.
- Grouped by **State** and calculated the average **Min** and **Max** salary.

---

## 📌 Final Output

[👉 Cleaned Dataset](Screenshot2.png)

## 📌 Power Query

[👉 Code](PowerQueryCode.txt)


---

FINALS:

- ### [Finals Task 2: Transforming ER into Relational Tables](Finals%20Task%202.%20Transforming%20ER%20into%20Relational%20Tables)
- ### [finals task 3: table manipulation](https://github.com/Rroyrebel24/Rroyrebel24/tree/main/finals%20task%203)
- ### [finals task 4:using select statement](https://github.com/Rroyrebel24/Rroyrebel24/tree/main/finals%20task4)
  

