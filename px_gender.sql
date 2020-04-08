
SET NOCOUNT ON


insert into  [research_qa].dbo.px_gender_result
select dt_patient.patient_id,dt_service.service_id, dt_svc_procedure.proc_code, 
dt_patient.sex, CPT_Gender.[Description],CPT_Gender.Knowledge_ID,dt_service.location_name

from ((rdc_dt.dbo.dt_patient inner join rdc_dt.dbo.dt_service on dt_patient.patient_id=dt_service.patient_id)
inner join rdc_dt.dbo.dt_svc_procedure on dt_service.service_id=dt_svc_procedure.service_id)
inner join [research_qa].[dbo].[CPT_Gender] ON (dt_svc_procedure.proc_code=CPT_Gender.[CPT Code] and proc_code_type='cpt')

where 

dt_patient.sex=
cpt_gender.[Invalid Gender]

		
	