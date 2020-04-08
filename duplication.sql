SET NOCOUNT ON;
--drop Table #a;
with de as 
(
SELECT 
      dt_service.patient_id
	  ,dt_service.service_id
      ,[proc_code]
      ,[proc_code_type]
	  ,location_name
      
     
  FROM [rdc_dt].[dbo].[dt_svc_procedure]
  inner join rdc_dt.dbo.dt_service on dt_svc_procedure.service_id=dt_service.service_id
  where proc_code
   in ('58570','58571','58572','58573','55866')
  )

select de.patient_id
       --,de.proc_code
       ,count(patient_id) as count
	   into #a
	   from de  
	   group by patient_id
	  -- , proc_code
	   having count (patient_id) > 1;

	   select* from #a

select dt_service.patient_id
, dt_svc_procedure.svc_procedure_id
, dt_service.service_id
, dt_svc_procedure.proc_code
, proc_start_date
, location_name

from [rdc_dt].[dbo].dt_svc_procedure 
inner join rdc_dt.dbo.dt_service
on dt_svc_procedure.service_id=dt_service.service_id
inner join #a 
on dt_service.patient_id=#a.patient_id
where proc_code
   in ('58570','58571','58572','58573','55866')
drop Table #a;



