
SET NOCOUNT ON

insert into  [research_qa].dbo.dx_age_result
select dt_patient.patient_id, dt_service.service_id, dt_svc_diagnosis.dx_code_type,dt_svc_diagnosis.dx_code, 
dt_patient.birth_date, dt_svc_diagnosis.diagnosis_date, 
DATEDIFF(DAY,dt_patient.birth_date,dt_svc_diagnosis.diagnosis_date)/365 AS Age,
 dt_svc_diagnosis.dx_code_descr, icd_age.Knowledge_ID, dt_service.location_name

from ((rdc_dt.dbo.dt_patient inner join rdc_dt.dbo.dt_service on dt_patient.patient_id=dt_service.patient_id)
inner join rdc_dt.dbo.dt_svc_diagnosis on dt_service.service_id=dt_svc_diagnosis.service_id)
INNER JOIN [research_qa].[dbo].[ICD_Age] ON dt_svc_diagnosis.dx_code=ICD_Age.dx_code and dt_svc_diagnosis.dx_code_type=ICD_Age.dx_code_type
where 
DATEDIFF(DAY,dt_patient.birth_date,dt_svc_diagnosis.diagnosis_date)/365<
 icd_age.valid_beginning_age
 
or DATEDIFF(DAY,dt_patient.birth_date,dt_svc_diagnosis.diagnosis_date)/365>
icd_age.valid_end_age