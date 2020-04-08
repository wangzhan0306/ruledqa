/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @Counter int;
DECLARE @tableLength int;
SET NOCOUNT ON;

--set a variable for the rule test by selecting from a knowledge table
-- DELETE SET @var_from_list = (select top 10 bill_line_num from dt_bill_line);
SET @Counter = 1;
SET @tableLength = 360 --(select count(*) from fully qualified knowledgeTable);

--'top x' limits your results while testing but should be removed for real runs!!!!!!!!!!!!
WHILE (@Counter <= @tableLength)
BEGIN;
--insert into  [research_qa].[UAMS\WangZhan].[drug_px_result]
SELECT distinct dt_svc_medication.service_id 
    ,med_code, dt_svc_medication.med_display_name, dt_svc_procedure.proc_code,location_name,@Counter
    --,dt_svc_diagnosis.dx_code

from rdc_dt.dbo.dt_svc_medication inner join rdc_dt.dbo.dt_svc_procedure on dt_svc_medication.service_id=dt_svc_procedure.service_id
inner join rdc_dt.dbo.dt_service on dt_svc_medication.service_id=dt_service.service_id
where dt_svc_procedure.proc_code_type='CPT' and dt_svc_procedure.proc_code!=(select [Drug&Px].cpt from [research_qa].[dbo].[Drug&Px] where [Drug&Px].knowledge_id=@Counter)
 and dt_svc_medication.med_code=(select [Drug&Px].ndc from [research_qa].[dbo].[Drug&Px] where [Drug&Px].knowledge_id=@Counter)

	SET @Counter = @Counter + 1; --increment the counter
END;
 