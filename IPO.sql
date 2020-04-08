select 
dt_svc_procedure.service_id as service_id
,dt_service.location_name
,dt_svc_procedure.proc_code
,[IPO RULES].knowledge_id
from rdc_dt.dbo.dt_svc_procedure 
 inner join [research_qa].[dbo].[IPO RULES] 
 on dt_svc_procedure.proc_code=[IPO RULES].ipo_code
 inner join  rdc_dt.dbo.dt_service 
 on dt_svc_procedure.service_id=dt_service.service_id
where dt_svc_procedure.service_id not in 
(select service_id 
from  rdc_dt.dbo.dt_svc_inpatient)