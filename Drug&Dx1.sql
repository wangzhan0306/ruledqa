use rdc_dt;

select distinct dt_svc_diagnosis.service_id, dt_svc_diagnosis.dx_code,dt_svc_diagnosis.dx_code_descr,
dt_svc_medication_rxnorm.rxnorm_code,dt_svc_medication_new.med_name,
dt_service.location_name
from (dt_svc_diagnosis inner join dt_svc_medication_new on dt_svc_diagnosis.service_id= dt_svc_medication_new.service_id) 
inner join dt_svc_medication_rxnorm on dt_svc_medication_new.med_code=dt_svc_medication_rxnorm.medication_id
inner join dt_service on dt_svc_diagnosis.service_id=dt_service.service_id
where (dt_svc_medication_rxnorm.rxnorm_code='1911' or dt_svc_medication_rxnorm.rxnorm_code='142442' or dt_svc_medication_rxnorm.rxnorm_code='5640')
	and (dt_svc_diagnosis.dx_code like 'K26%' or dt_svc_diagnosis.dx_code LIKE 'K27%')