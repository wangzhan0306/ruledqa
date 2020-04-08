
SET NOCOUNT ON

select dt_svc_procedure.proc_code, count(distinct dt_service.patient_id) as patient_num
from rdc_dt.dbo.dt_service 
inner join dt_svc_procedure on dt_service.service_id=dt_svc_procedure.service_id
INNER JOIN [research_qa].[dbo].cpt_age ON dt_svc_procedure.proc_code=cpt_age.[CPT Code] --and dt_svc_diagnosis.dx_code_type=cpt_gender.dx_code_type
Group by dt_svc_procedure.proc_code

