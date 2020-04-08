use rdc_dt;

select distinct dt_svc_lab_result.service_id, dt_svc_lab_result.test_code,dt_svc_lab_result.test_desc,dt_svc_lab_result.result_value,
dt_svc_lab_result.result_unit,dt_svc_medication_rxnorm.rxnorm_code,dt_svc_medication_new.med_name,location_name
from (dt_svc_lab_result inner join dt_svc_medication_new on dt_svc_lab_result.service_id= dt_svc_medication_new.service_id) 
inner join dt_svc_medication_rxnorm on dt_svc_medication_new.med_code=dt_svc_medication_rxnorm.medication_id
inner join rdc_dt.dbo.dt_service on dt_svc_medication_new.service_id=dt_service.service_id
where dt_svc_medication_rxnorm.rxnorm_code='202433' 
    and 
	(dt_svc_lab_result.test_code='1743-4'and ((isnumeric(dt_svc_lab_result.result_value)=1 
    and dt_svc_lab_result.result_value not like '%.%' and dt_svc_lab_result.result_value not like '%,%'
	and cast(dt_svc_lab_result.result_value as bigint)<350) or isnumeric(dt_svc_lab_result.result_value)=0 
	)or
	dt_svc_lab_result.test_code='1920-8'and ((isnumeric(dt_svc_lab_result.result_value)=1 
    and dt_svc_lab_result.result_value not like '%.%' and dt_svc_lab_result.result_value not like '%,%'
	and cast(dt_svc_lab_result.result_value as bigint)<2000) or isnumeric(dt_svc_lab_result.result_value)=0 
	)or
	dt_svc_lab_result.test_code='2324-2'and ((isnumeric(dt_svc_lab_result.result_value)=1 
    and dt_svc_lab_result.result_value not like '%.%' and dt_svc_lab_result.result_value not like '%,%'
	and cast(dt_svc_lab_result.result_value as bigint)<2000) or isnumeric(dt_svc_lab_result.result_value)=0 
	 ))

