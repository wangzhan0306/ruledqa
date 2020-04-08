DECLARE @Counter int;
DECLARE @tableLength int;
SET @Counter = 16;
SET @tableLength =19
SET NOCOUNT ON
WHILE (@Counter <= @tableLength)
BEGIN;

with de as 
(select 
dt_svc_lab_result.service_id as service_id
, dt_svc_lab_result.test_desc as test_desc
, dt_svc_lab_result.test_code as test_code
, dt_svc_lab_result.test_time as test_time
--, dt_svc_lab_result.result_status as result_status
,case when (isnumeric(dt_svc_lab_result.result_value)=1 )
and dt_svc_lab_result.result_value is not null 
and 
--((
dt_svc_lab_result.result_value not like '%,%'
and dt_svc_lab_result.result_value not like '00%'
and dt_svc_lab_result.result_value != '.'
and dt_svc_lab_result.result_value like '%.%'
--) 
--or (dt_svc_lab_result.result_value not like '%.%'
--and dt_svc_lab_result.result_value not like '0%'
--and dt_svc_lab_result.result_value not like '%,%'))
--and dt_svc_lab_result.result_value not like '%_%'
then cast(dt_svc_lab_result.result_value as float)
end as result_value
,[delta checking].change as change
,[delta checking].days as days
,[delta checking].knowledge_id as knowledge_id
from
rdc_dt.dbo.dt_svc_lab_result inner join [research_qa].[dbo].[delta checking] 
ON dt_svc_lab_result.test_code=[delta checking].[code]
WHERE [delta checking].knowledge_id = @Counter)

select de.service_id as service_id
, de.result_value as result_value_1
, B.result_value as result_value_2
, de.test_time as test_time_1
, B.test_time as test_time_2
, de.test_code
--, de.result_status
from de
     inner join  de B
	     on de.service_id=B.service_id and de.test_code=B.test_code
where de.result_value-B.result_value > de.change 
and abs(DATEDIFF(DAY,de.test_time,B.test_time)) < de.days

SET @Counter = @Counter + 1; --increment the counter
END