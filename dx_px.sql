/****** Script for SelectTopNRows command from SSMS  ******/
SELECT dt_svc_procedure.service_id
--, proc_code
--, location_name
from dt_svc_procedure 
left join dt_service
on dt_service.service_id=dt_svc_procedure.service_id

where dt_service.service_id is null
