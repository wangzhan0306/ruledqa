DECLARE @Counter int;
DECLARE @tableLength int;

--set a variable for the rule test by selecting from a knowledge table
-- DELETE SET @var_from_list = (select top 10 bill_line_num from dt_bill_line);
SET @Counter = 1;
SET @tableLength = 640 --(select count(*) from fully qualified knowledgeTable);
SET NOCOUNT ON
--'top x' limits your results while testing but should be removed for real runs!!!!!!!!!!!!
WHILE (@Counter <= @tableLength)
BEGIN;

--insert into  [research_qa].[UAMS\WangZhan].[gender_procedure_result]
select dt_patient.patient_id,dt_svc_procedure.proc_start_date, dt_service.service_id, dt_svc_procedure.proc_code_type,dt_svc_procedure.proc_code, 
--DATEDIFF(DAY,dt_patient.birth_date,dt_svc_diagnosis.diagnosis_date)/365 AS Age,  dt_patient.birth_date, 
dt_patient.sex, CPT_Gender.[Description],CPT_Gender.Knowledge_ID,dt_service.location_name--, SYSDATETIME()

from ((rdc_dt.dbo.dt_patient inner join rdc_dt.dbo.dt_service on dt_patient.patient_id=dt_service.patient_id)
inner join rdc_dt.dbo.dt_svc_procedure on dt_service.service_id=dt_svc_procedure.service_id)
inner join [research_qa].[dbo].[CPT_Gender] ON (dt_svc_procedure.proc_code=CPT_Gender.[CPT Code])

where 
(dt_svc_procedure.proc_code=
 (SELECT [CPT Code]
 FROM [research_qa].[dbo].CPT_Gender
 WHERE Knowledge_ID = @Counter)
 --match CPT code


and dt_patient.sex=
 (SELECT [Invalid Gender]
 FROM [research_qa].[dbo].CPT_Gender
 WHERE Knowledge_ID = @Counter))
--match invalid gender		
		
		--end (this part selects the row from the knowledge table to test against)
	SET @Counter = @Counter + 1; --increment the counter
END;
