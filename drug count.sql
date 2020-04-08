use rdc_dt
select rxnorm_code, count(distinct service_id)

FROM [rdc_dt].[dbo].[dt_svc_medication] 
  inner join dt_svc_medication_rxnorm on dt_svc_medication_rxnorm.medication_id=dt_svc_medication.med_code
 -- inner join dt_service on dt_svc_medication.service_id=dt_service.service_id
  inner join [research_qa].[dbo].[drug_class] on dt_svc_medication_rxnorm.rxnorm_code=RxNorm
 
  group by rxnorm_code