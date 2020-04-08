/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @Counter int;
DECLARE @tableLength int;

--set a variable for the rule test by selecting from a knowledge table
-- DELETE SET @var_from_list = (select top 10 bill_line_num from dt_bill_line);
SET @Counter = 1;
SET @tableLength = 5 --(select count(*) from fully qualified knowledgeTable);

--'top x' limits your results while testing but should be removed for real runs!!!!!!!!!!!!
WHILE (@Counter <= @tableLength)
BEGIN;
--insert into  [research_qa].[UAMS\WangZhan].[drug_dx_result]
use rdc_dt;

select distinct dt_service.service_id, dx_code,dx_code_descr,location_name
from dt_svc_diagnosis inner join dt_service on dt_svc_diagnosis.service_id=dt_service.service_id
where dt_svc_diagnosis.service_id in (
       select DISTINCT(service_id) 
       from dt_svc_medication
       where dt_svc_medication.med_code not in (
	   select [Drug&Dx2].ndc from [research_qa].[dbo].[Drug&Dx2] where [Drug&Dx2].icd=(select icd from [research_qa].[dbo].[Drug&icd2] where [Drug&icd2].icd_id=@Counter)
	))
	and dx_code=(select icd from [research_qa].[dbo].[Drug&icd2] where [Drug&icd2].icd_id=@Counter )
	SET @Counter = @Counter + 1; --increment the counter
END;


