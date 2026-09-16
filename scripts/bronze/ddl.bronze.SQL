
/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
GO


CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;

BEGIN try
SET @batch_start_time= GETDATE();
PRINT '=======================================';
    PRINT'LOADING BRONZE LAYER'
    PRINT '=======================================';

   PRINT '=======================================';
    PRINT ' LOADING CRM TABLES'
     PRINT '=======================================';


     SET @start_time=GETDATE();

     PRINT '>> Truncating Taple bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;
print '>> Inserting Data into Taple bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
from 'C:\Users\zahra\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK 

);
 SET @end_time=GETDATE();
 PRINT '>> load duration; ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
  PRINT '=======================================';


  SET @start_time=GETDATE();

PRINT '>> Truncating Taple bronze.crm_sales_details';
TRUNCATE TABLE bronze.crm_sales_details;
print '>> Inserting Data into Taple bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
from 'C:\Users\zahra\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK 

);
SET @end_time=GETDATE();
 PRINT '>> load duration; ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
  PRINT '=======================================';


SET @start_time=GETDATE();
PRINT '>> Truncating Taple bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info;
print '>> Inserting Data into Taple bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
from 'C:\Users\zahra\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK 

);
SET @end_time=GETDATE();
 PRINT '>> load duration; ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
  PRINT '=======================================';

   PRINT '=======================================';
    PRINT ' LOADING ERP TABLES'
     PRINT '=======================================';

     SET @start_time=GETDATE();
PRINT '>> Truncating Taple bronze.erp_cust_az12';
TRUNCATE TABLE bronze.erp_cust_az12;
print '>> Inserting Data into Taple bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
from 'C:\Users\zahra\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK 

);
SET @end_time=GETDATE();
 PRINT '>> load duration; ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
  PRINT '=======================================';

SET @start_time=GETDATE();
PRINT '>> Truncating Taple bronze.erp_loc_a101';
TRUNCATE TABLE bronze.erp_loc_a101;
print '>> Inserting Data into taple bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
from 'C:\Users\zahra\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK 

);
SET @start_time=GETDATE();
PRINT '>> Truncating Taple bronze.erp_px_cat_g1v2';
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
print '>> Inserting Data into taple bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\Users\zahra\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK 

);
SET @end_time=GETDATE();
 PRINT '>> load duration; ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' Seconds';
  PRINT '=======================================';

  SET @batch_end_time= GETDATE();
    PRINT '=======================================';
    PRINT'LADING BRONZE LAYER COMPLETED;'
    PRINT'TOTAL LORAD DURATIONL:'+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time)AS NVARCHAR)+'second';
    PRINT '=======================================';
END TRY
BEGIN CATCH
PRINT '========================================='
PRINT'ERROR MESSAGE '+ ERROR_MESSAGE();
PRINT'ERROR MESSAGE '+ CAST(ERROR_NUMBER() AS NVARCHAR);
PRINT '========================================='
END CATCH 
END




