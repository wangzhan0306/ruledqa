use rdc_dt;
SELECT count(distinct dt_service.patient_id)


from dt_svc_diagnosis
inner join dt_service on dt_svc_diagnosis.service_id=dt_service.service_id
inner join research_qa.dbo.[Dx&Lab] on dt_svc_diagnosis.dx_code=[Dx&Lab].ICD


where --(dx_code like 'E08%'
--or  dx_code like 'E09%'
--or  dx_code like 'E10%'
--or  dx_code like 'E11%'
--or  dx_code like 'E13%')
--and 
diagnosis_date>'1995-01-01'
and patient_id not in 
( select patient_id
from dt_service
inner join dt_svc_lab_result on dt_svc_lab_result.service_id=dt_service.service_id
where test_code='1547-9')
--and (patient_id not in 
--( 
--select patient_id
--from dt_service
--inner join dt_svc_lab_result on dt_svc_lab_result.service_id=dt_service.service_id
--where test_code='17856-6')
--or patient_id in 
--( select patient_id
--from dt_service
--inner join dt_svc_procedure on dt_svc_procedure.service_id=dt_service.service_id
--where proc_code='83036'))




 