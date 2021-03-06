/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [svc_procedure_id]
      ,[service_id]
      ,[provider_id]
      ,[proc_master_id]
      ,[proc_sequence]
      ,[proc_code]
      ,[proc_code_type]
      ,[proc_start_date]
      ,[proc_end_date]
      ,[modifier_1]
      ,[modifier_2]
      ,[modifier_3]
      ,[modifier_4]
      ,[svc_proc_type_orig]
      ,[svc_proc_type]
      ,[place_of_service_code]
      ,[etl_job_id]
      ,[etl_source_id]
      ,[etl_date]
      ,[data_source_id]
      ,[etl_src_record_id]
      ,[deleted_ind]
  FROM [rdc_dt].[dbo].[dt_svc_procedure]
  where proc_start_date>getdate()
  --or 
  --proc_end_date>getdate()