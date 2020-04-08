
insert into  [research_qa].dbo.[px_age_result]

select dt_patient.patient_id, dt_service.service_id, 
dt_svc_procedure.proc_code, 
dt_patient.birth_date, dt_svc_procedure.proc_start_date, 
DATEDIFF(DAY,dt_patient.birth_date,dt_svc_procedure.proc_start_date)/365, 
cpt_age.Description, CPT_Age.[Knowledge_ID], dt_service.location_name

from ((rdc_dt.dbo.dt_patient inner join rdc_dt.dbo.dt_service on dt_patient.patient_id=dt_service.patient_id)
inner join rdc_dt.dbo.dt_svc_procedure on dt_service.service_id=dt_svc_procedure.service_id)
INNER JOIN [research_qa].[dbo].[CPT_Age] ON (dt_svc_procedure.proc_code=CPT_Age.[CPT Code] and proc_code_type='CPT')

where 

 DATEDIFF(DAY,dt_patient.birth_date,dt_svc_procedure.proc_start_date)/365<
  CPT_Age.[Valid Begin Age]
 or DATEDIFF(DAY,dt_patient.birth_date,dt_svc_procedure.proc_start_date)/365>
  CPT_Age.[Valid End Age]