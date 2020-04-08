/****** Script for SelectTopNRows command from SSMS  ******/
SELECT count(distinct patient_id)
      
      ,[test_code]
     
  FROM [rdc_dt].[dbo].[dt_svc_lab_result] inner join rdc_dt.dbo.dt_service on dt_svc_lab_result.service_id=dt_service.service_id
  where --(test_code='2990-0' or test_code='2991-8' or test_code='2986-8')
  test_code='1547-9'

group by test_code