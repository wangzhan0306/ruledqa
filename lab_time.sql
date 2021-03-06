/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [dt_svc_lab_result].[service_id]
      ,[test_name]
      ,[test_code]
      ,[test_time]
      ,[result_value]
      ,[result_unit]
	  ,dt_service.location_name 
  FROM [rdc_dt].[dbo].[dt_svc_lab_result] inner join rdc_dt.dbo.dt_service on dt_svc_lab_result.service_id=dt_service.service_id
  where (test_code='2990-0' or test_code='2991-8' or test_code='2986-8')
  and DATEPART(HOUR, test_time) >= 10

