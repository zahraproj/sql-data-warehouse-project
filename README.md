# SQL Data Warehouse Project

A personal project I built while learning SQL Server and Data Engineering concepts.
It builds a simple data warehouse in SQL Server, starting from raw CSV files and going through loading, cleaning, transformation, and preparing the data for analysis.

## 🛠️ Tools & Technologies

- SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Draw.io
- Git & GitHub

## 🏗️ Project Architecture

The project follows a Bronze, Silver, and Gold layer structure, shown in a Draw.io diagram (source systems and tables in each layer).

- **Sources:** CRM and ERP CSV files (customers, products, and sales data).
- **Bronze:** Raw data loaded as-is from the source files.
- **Silver:** Cleaned, standardized, and transformed data.
- **Gold:** Final data prepared for analysis.

## 🗂️ Project Structure

```text
sql-data-warehouse-project/
│
├── datasets/        # Source CSV files (CRM and ERP)
├── docs/            # Architecture diagram, data catalog, naming conventions
├── scripts/
│   ├── bronze/      # Loading raw data
│   ├── silver/      # Data cleaning and transformation
│   └── gold/        # Analytical data models
├── tests/           # Data quality checks
├── README.md
└── LICENSE
```

## 🎯 What I Practiced

- Loading CSV files into SQL Server
- Cleaning and transforming data across Bronze, Silver, and Gold layers
- Using SQL functions such as `TRIM`, `CASE`, `NULLIF`, and `ROW_NUMBER`
- Removing duplicates and handling missing or incorrect values
- Writing data quality checks
- Managing the project with Git and GitHub

## 📌 Note

This is a learning project. I followed an online tutorial as a guide and practiced the concepts by implementing the project and working through the SQL scripts myself.

## 🛡️ License

This project is licensed under the MIT License.
