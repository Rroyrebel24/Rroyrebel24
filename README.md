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

---

## 📝 Power Query M Code

```m
let
    Source = Csv.Document(File.Contents("C:\Users\COMLAB\Downloads\Uncleaned_DS_jobs.csv"),[Delimiter=",", Columns=15, Encoding=1252, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"index", Int64.Type}, {"Job Title", type text}, {"Salary Estimate", type text}, {"Job Description", type text}, {"Rating", type number}, {"Company Name", type text}, {"Location", type text}, {"Headquarters", type text}, {"Size", type text}, {"Founded", Int64.Type}, {"Type of ownership", type text}, {"Industry", type text}, {"Sector", type text}, {"Revenue", type text}, {"Competitors", type text}}),
    #"Extracted Text Before Delimiter" = Table.TransformColumns(#"Changed Type", {{"Salary Estimate", each Text.BeforeDelimiter(_, "("), type text}}),
    #"Inserted Literal" = Table.AddColumn(#"Extracted Text Before Delimiter", "Min Sal", each "101", type text),
    #"Inserted Literal1" = Table.AddColumn(#"Inserted Literal", "Max Sal", each "101", type text),
    #"Added Custom" = Table.AddColumn(#"Inserted Literal1", "Role Type", each if Text.Contains([Job Title], "Data Scientist") then "Data Scientist" else if Text.Contains([Job Title], "Data Analyst") then "Data Analyst" else if Text.Contains([Job Title], "Data Engineer") then "Data Engineer" else if Text.Contains([Job Title], "Machine Learning") then "Machine Learning Engineer" else "other"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Custom",{{"Role Type", type text}}),
    #"Added Custom1" = Table.AddColumn(#"Changed Type1", "Location Correction", each if [Location]= "New Jersey" then ", NJ" else if [Location] = "Remote" then ", other" else if [Location]= "United States" then ", other" else if [Location]= "Texas" then ", TX" else if [Location]= "Patuxent" then ", MA" else if [Location]= "California" then ", CA" else if [Location]= "Utah" then ", UT" else [Location]),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Added Custom1", "Location Correction", Splitter.SplitTextByDelimiter(",", QuoteStyle.Csv), {"Location Correction.1", "Location Correction.2"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Location Correction.1", type text}, {"Location Correction.2", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type2","Anne Rundell","MA",Replacer.ReplaceText,{"Location Correction.2"}),
    #"Renamed Columns" = Table.RenameColumns(#"Replaced Value",{{"Location Correction.2", "State Abbreviations"}}),
    #"Split Column by Delimiter1" = Table.SplitColumn(#"Renamed Columns", "Size", Splitter.SplitTextByDelimiter(" ", QuoteStyle.Csv), {"Size.1", "Size.2", "Size.3", "Size.4"}),
    #"Changed Type3" = Table.TransformColumnTypes(#"Split Column by Delimiter1",{{"Size.1", type text}, {"Size.2", type text}, {"Size.3", Int64.Type}, {"Size.4", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type3",{"Size.2", "Size.4"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns",{{"Size.1", "MinCompanySize"}, {"Size.3", "MaxCompanySize"}}),
    #"Replaced Value1" = Table.ReplaceValue(#"Renamed Columns1","-1","N/A",Replacer.ReplaceText,{"Competitors"}),
    #"Changed Type4" = Table.TransformColumnTypes(#"Replaced Value1",{{"Revenue", type text}}),
    #"Replaced Value2" = Table.ReplaceValue(#"Changed Type4","-1","0",Replacer.ReplaceText,{"Revenue"}),
    #"Filtered Rows" = Table.SelectRows(#"Replaced Value2", each ([Industry] <> "-1"))
in
    #"Filtered Rows"
