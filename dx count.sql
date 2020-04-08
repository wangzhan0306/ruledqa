use rdc_dt;

select COUNT( distinct patient_id), dx_code
from dt_svc_diagnosis 
inner join dt_service on dt_svc_diagnosis.service_id=dt_service.service_id
where dt_svc_diagnosis.dx_code like 'K26%' or dt_svc_diagnosis.dx_code LIKE 'K27%' or dt_svc_diagnosis.dx_code in
 ('I24.8','I24.9','I25.1','I25.2','I25.3','I25.4','I25.5','I25.6','I25.7','I25.8','I25.9')
 group by dx_code