Drop table #A, #B,#D

select  
dt_service.patient_id
,dt_svc_lab_result.test_code
--,dt_svc_lab_result.test_time
,dt_service.location_name
into #A

FROM [rdc_dt].[dbo].[dt_svc_lab_result] inner join rdc_dt.dbo.dt_service on  dt_svc_lab_result.service_id=dt_service.service_id
where dt_svc_lab_result.test_code='1547-9'



select  
--dt_svc_lab_result.service_id
dt_service.patient_id
--,dt_svc_lab_result.test_code
--,dt_svc_lab_result.test_time
into #B

FROM [rdc_dt].[dbo].[dt_svc_procedure] inner join rdc_dt.dbo.dt_service on  dt_svc_procedure.service_id=dt_service.service_id
where dt_svc_procedure.proc_code in
 ('92002' , '92004', '92012', '92014', '92015', '99172', '99173','92018','92019','92225','92226','92230','92240','92250','92284','92003'
,'99201','99202','99203','99204','99205','99211','99212','99213','99214','992015') 

--select 
--#A.patient_id
--into #C
-- from #A inner join #B 
-- on #A.patient_id=#B.patient_id
 --where DATEDIFF(month,#A.test_time,#B.test_time)<=12 
 --and DATEDIFF(month,#A.test_time,#B.test_time)>=0

select 
patient_id
,test_code
,location_name
--,'3016-3' as test_code2
into #D
from #A
where patient_id not in 
( select
patient_id 
from #B) 

Select * from #D

Drop table #A, #B,#D

 
