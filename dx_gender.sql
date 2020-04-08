--DECLARE @Counter int;
--DECLARE @tableLength int;

--set a variable for the rule test by selecting from a knowledge table

--SET @Counter = 1;
--SET @tableLength = 5208 --(select count(*) from fully qualified knowledgeTable);
SET NOCOUNT ON

--WHILE (@Counter <= @tableLength)
--BEGIN;

insert into  [research_qa].dbo.dx_gender_result
select dt_patient.patient_id, dt_service.service_id, dt_svc_diagnosis.dx_code_type,dt_svc_diagnosis.dx_code, 
dt_patient.sex, dt_svc_diagnosis.dx_code_descr,ICD_Gender.[knowledge_ID],dt_service.location_name

from ((rdc_dt.dbo.dt_patient inner join rdc_dt.dbo.dt_service on dt_patient.patient_id=dt_service.patient_id)
inner join rdc_dt.dbo.dt_svc_diagnosis on dt_service.service_id=dt_svc_diagnosis.service_id)
inner join [research_qa].[dbo].ICD_Gender ON (dt_svc_diagnosis.dx_code=ICD_Gender.dx_code and dt_svc_diagnosis.dx_code_type=ICD_Gender.dx_code_type)

where 
((dt_svc_diagnosis.dx_code=
 (SELECT ICD9Code
 FROM [research_qa].[dbo].ICD_Gender
 WHERE knowledge_ID = @Counter)
 --match icd9 code

or dt_svc_diagnosis.dx_code=
 (SELECT ICD10Code
 FROM [research_qa].[dbo].ICD_Gender
 WHERE knowledge_ID = @Counter))
 --match icd10 code

and dt_patient.sex=
 (SELECT [Invalid Gender]
 FROM [research_qa].[dbo].ICD_Gender
 WHERE knowledge_ID = @Counter))
--match invalid gender		
		
		--end (this part selects the row from the knowledge table to test against)
	--SET @Counter = @Counter + 1; --increment the counter
--END;
