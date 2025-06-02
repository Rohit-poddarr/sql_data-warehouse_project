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




--exec bronze.load_bronze
create or alter procedure bronze.load_bronze
as
begin
	declare @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	begin try
		print '=============================';
		print 'Loading Bronze Layer';
		print '=============================';

		print '-----------------------------';
		print 'Loading CRM Tables';
		print '-----------------------------';
		set @batch_start_time = GETDATE();
		
		set @start_time = GETDATE();
		print '>> Truncating Table:bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		print '<< Inserting Data Into:bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'D:\aaanode______JAVA FULLSTACK\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: '+ cast(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '-----------------------------------------'

		
		set @start_time = GETDATE();
		print '>> Truncating Table:bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		print '<< Inserting Data Into:bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'D:\aaanode______JAVA FULLSTACK\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: '+ cast(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '-----------------------------------------'


		set @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'D:\aaanode______JAVA FULLSTACK\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: '+ cast(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '-----------------------------------------'

	
		print '-----------------------------';
		print 'Loading ERP Tables';
		print '-----------------------------';


		set @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_CUST_AZ12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		bulk insert bronze.erp_CUST_AZ12
		from 'D:\aaanode______JAVA FULLSTACK\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: '+ cast(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '-----------------------------------------'

		set @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_LOC_A101;
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		bulk insert bronze.erp_LOC_A101
		from 'D:\aaanode______JAVA FULLSTACK\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: '+ cast(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '-----------------------------------------'

		set @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_PX_CAT_G1V2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_PX_CAT_G1V2
		from 'D:\aaanode______JAVA FULLSTACK\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print '>> Load Duration: '+ cast(DATEDIFF(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '-----------------------------------------'

		set @batch_end_time = GETDATE();
		print '------------------------------------------------'
		print 'Loading bronze layer is completed'
		print '>>Total batch Load Duration: '+ cast(DATEDIFF(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds';
		print '-----------------------------------------'

		end try
		begin catch
			print '==============================================='
			print 'Error occured during loading bronze layer'
			print 'Error Message' + ERROR_MESSAGE();

			print '==============================================='
		end catch
end
