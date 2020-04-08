/****** Script for SelectTopNRows command from SSMS  ******/
SELECT dt_svc_procedure.service_id
, proc_code
, location_name
from dt_svc_procedure inner join dt_service 
on dt_svc_procedure.service_id=dt_service.service_id
where dt_svc_procedure.service_id not in(
select service_id from dt_svc_diagnosis)
