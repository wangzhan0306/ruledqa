
SET NOCOUNT ON;


with de as 
(select 
dt_service.service_id as service_id
, dt_svc_lab_result.test_desc as test_desc
, dt_svc_lab_result.test_code as test_code
, dt_svc_lab_result.test_time as test_time

,case when (isnumeric(dt_svc_lab_result.result_value)=1 )
and dt_svc_lab_result.result_value is not null 
and dt_svc_lab_result.result_value not like '%,%'
and dt_svc_lab_result.result_value not like '00%'
and dt_svc_lab_result.result_value != '.'
and dt_svc_lab_result.result_value like '%.%'
then cast(dt_svc_lab_result.result_value as float)
end as result_value
,[delta checking].Units as units
,[delta checking].change as change
,[delta checking].days as days
,location_name
,[delta checking].knowledge_id as knowledge_id
from
rdc_dt.dbo.dt_svc_lab_result inner join [research_qa].[dbo].[delta checking] 
ON (dt_svc_lab_result.test_code=[delta checking].[code] and dt_svc_lab_result.result_unit=[delta checking].Units)
inner join rdc_dt.dbo.dt_service
on dt_svc_lab_result.service_id=dt_service.service_id
)

select de.service_id as service_id
, de.result_value as result_value_1
, B.result_value as result_value_2
, de.units
, de.test_time as test_time_1
, B.test_time as test_time_2
, de.test_code
, de.location_name
, de.knowledge_id

from de
     inner join  de B
	     on de.service_id=B.service_id
		 and de.test_code=B.test_code 
		where (de.result_value-B.result_value) > de.change 
and abs(DATEDIFF(DAY,de.test_time,B.test_time)) < de.days

