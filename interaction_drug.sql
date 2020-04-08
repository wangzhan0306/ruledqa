SET NOCOUNT ON;

use rdc_dt;
DECLARE @Counter int;
DECLARE @tableLength int;


--set a variable for the rule test by selecting from a knowledge table
-- DELETE SET @var_from_list = (select top 10 bill_line_num from dt_bill_line);
SET @Counter = 1;
SET @tableLength = 11
WHILE (@Counter <= @tableLength)
BEGIN;
--drop table #A,#B
select patient_id, dt_svc_medication_rxnorm.rxnorm_code as rx_1,dt_svc_medication.med_name as drug_1,location_name, 
med_start_date as med_start_date_1, med_end_date as med_end_date_1
into #A
from dt_service inner join dt_svc_medication on dt_service.service_id=dt_svc_medication.service_id
inner join dt_svc_medication_rxnorm on dt_svc_medication.med_code=dt_svc_medication_rxnorm.medication_id
inner join research_qa.dbo.interaction_drug on rxnorm_code=interaction_drug.rx_1
where knowledge_id=@Counter

select patient_id, dt_svc_medication_rxnorm.rxnorm_code as rx_2,dt_svc_medication.med_name as drug_2,location_name, 
med_start_date as med_start_date_2, med_end_date as med_end_date_2
into #B
from dt_service inner join dt_svc_medication on dt_service.service_id=dt_svc_medication.service_id
inner join dt_svc_medication_rxnorm on dt_svc_medication.med_code=dt_svc_medication_rxnorm.medication_id
inner join research_qa.dbo.interaction_drug on rxnorm_code=interaction_drug.rx_2
where knowledge_id=@Counter

select #A.patient_id, rx_1,drug_1,#A.location_name, #A.med_start_date_1, #A.med_end_date_1, rx_2, drug_2,#B.location_name, #B.med_start_date_2, #B.med_end_date_2

from #A inner join #B on #A.patient_id=#B.patient_id 
where (med_start_date_1<med_end_date_2 and med_start_date_1>med_start_date_2)
or (med_end_date_1<med_end_date_2 and med_end_date_1>med_start_date_2)
or (med_start_date_2<med_end_date_1 and med_start_date_2>med_start_date_1)
or (med_end_date_2<med_end_date_1 and med_end_date_2>med_start_date_1)
drop table #A,#B

	SET @Counter = @Counter + 1; --increment the counter
END;
 