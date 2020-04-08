SET NOCOUNT ON;
--drop Table #a;

SELECT 
      count(distinct dt_service.patient_id)
	
      ,[proc_code]

     
  FROM [rdc_dt].[dbo].[dt_svc_procedure]
  inner join rdc_dt.dbo.dt_service on dt_svc_procedure.service_id=dt_service.service_id
  where proc_code
   in ('58570','58571','58572','58573','55866')
   group by proc_code
 