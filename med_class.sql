/****** Script for SelectTopNRows command from SSMS  ******/
with de as
(SELECT distinct
  patient_id
  --,svc_medication_id
  ,dt_service.service_id
--, rxnorm_code
, med_code
, class_id
, class_name
, med_location_name
 
  FROM [rdc_dt].[dbo].[dt_svc_medication_rxnorm]
  inner join research_qa.dbo.drug_class
  on drug_class.rxnorm =dt_svc_medication_rxnorm.rxnorm_code
  inner join [rdc_dt].[dbo].dt_svc_medication
  on dt_svc_medication.med_code=dt_svc_medication_rxnorm.medication_id
  inner join [rdc_dt].[dbo].dt_service
  on dt_svc_medication.service_id=dt_service.service_id)

  select  A.*, B.med_code as med_code2
  from de A
  inner join (select  med_code, class_id, service_id
  from de
  group by  med_code, class_id, service_id
  having count(*)>1) B
  on --A.patient_id=B.patient_id and 
  (A.class_id=B.class_id and  A.service_id=B.service_id)
  where A.med_code!=B.med_code
