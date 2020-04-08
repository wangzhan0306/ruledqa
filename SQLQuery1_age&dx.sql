-- use research_qa, rdc_dt;
-- use declare for variables
DECLARE @Counter int;
DECLARE @tableLength int;

--set a variable for the rule test by selecting from a knowledge table
-- DELETE SET @var_from_list = (select top 10 bill_line_num from dt_bill_line);
SET @Counter = 1;
SET @tableLength = 130 --(select count(*) from fully qualified knowledgeTable);
SET NOCOUNT ON
--'top x' limits your results while testing but should be removed for real runs!!!!!!!!!!!!
WHILE (@Counter <= @tableLength)
BEGIN;
insert into  [research_qa].[UAMS\WangZhan].[age_diagnosis_result]
select dt_patient.patient_id, dt_patient.birth_date, dt_svc_diagnosis.diagnosis_date, 
dt_service.service_id, dt_svc_diagnosis.dx_code_type,dt_svc_diagnosis.dx_code, 
DATEDIFF(DAY,dt_patient.birth_date,dt_svc_diagnosis.diagnosis_date)/365 AS Age, dt_svc_diagnosis.dx_code_descr, ICD_Age.Knowledge_ID, dt_service.location_name--,SYSDATETIME() 

from ((rdc_dt.dbo.dt_patient inner join rdc_dt.dbo.dt_service on dt_patient.patient_id=dt_service.patient_id)
inner join rdc_dt.dbo.dt_svc_diagnosis on dt_service.service_id=dt_svc_diagnosis.service_id)
INNER JOIN [research_qa].[dbo].[ICD_Age] ON dt_svc_diagnosis.dx_code=ICD_Age.[ICD9 Code] OR dt_svc_diagnosis.dx_code=ICD_Age.[ICD10 Code] 

where 
 ((dt_svc_diagnosis.dx_code=
 (SELECT [ICD9 Code]
 FROM [research_qa].[dbo].ICD_Age
 WHERE knowledge_id = @Counter)
--match icd9 code
or dt_svc_diagnosis.dx_code=
 (SELECT [ICD10 Code]
 FROM [research_qa].[dbo].ICD_Age
 WHERE knowledge_id = @Counter))
--match icd10 code


and (DATEDIFF(DAY,dt_patient.birth_date,dt_svc_diagnosis.diagnosis_date)/365<
 (SELECT [Valid Beginning Age]
 FROM [research_qa].[dbo].ICD_Age
 WHERE knowledge_id = @Counter)
 --match lower limit
or DATEDIFF(DAY,dt_patient.birth_date,dt_svc_diagnosis.diagnosis_date)/365>
 (SELECT [Valid End Age]
 FROM [research_qa].[dbo].ICD_Age
 WHERE knowledge_id = @Counter)))
 --match upper limit


 --end (this part selects the row from the knowledge table to test against)
	SET @Counter = @Counter + 1; --increment the counter
END;