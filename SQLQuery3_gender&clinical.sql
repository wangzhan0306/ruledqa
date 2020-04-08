-- use research_qa, rdc_dt;
-- use declare for variables
--DECLARE @Counter int;
--DECLARE @tableLength int;

--set a variable for the rule test by selecting from a knowledge table
-- DELETE SET @var_from_list = (select top 10 bill_line_num from dt_bill_line);
--SET @Counter = 1;
--SET @tableLength = 130 --(select count(*) from fully qualified knowledgeTable);

--'top x' limits your results while testing but should be removed for real runs!!!!!!!!!!!!
--WHILE (@Counter <= @tableLength)
--BEGIN;
--insert into  [research_qa].[UAMS\WangZhan].[age_diagnosis_result]
select distinct  dt_patient.patient_id, dt_service.service_id, dt_patient.sex, dt_service.location_name

from rdc_dt.dbo.dt_patient inner join rdc_dt.dbo.dt_service on dt_patient.patient_id=dt_service.patient_id

where 
 dt_patient.sex='Male' and dt_service.location_name like '%Obstetrics%'
--match icd10 code


	--SET @Counter = @Counter + 1; --increment the counter
--END;