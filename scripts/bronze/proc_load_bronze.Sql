/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

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




