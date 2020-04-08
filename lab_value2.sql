
SET NOCOUNT ON;

select distinct de.service_id
, de.test_desc
, de.test_code
, de.result_value
, de.result_unit
, de.lower_limit
, de.upper_limit
, de.location_name
, de.knowledge_id


from 
(select dt_svc_lab_result.service_id as service_id, 
dt_svc_lab_result.test_desc as test_desc, 
dt_svc_lab_result.test_code as test_code,
case when (isnumeric(dt_svc_lab_result.result_value)=1 )
and dt_svc_lab_result.result_value is not null 
and dt_svc_lab_result.result_value not like '%,%'
and dt_svc_lab_result.result_value not like '00%'
and dt_svc_lab_result.result_value != '.'
and dt_svc_lab_result.result_value like '%.%'
then cast(dt_svc_lab_result.result_value as float)
end as result_value,
result_unit,  
unit, 
low as lower_limit,
high as upper_limit,
location_name as location_name,
knowledge_id as knowledge_id

from
rdc_dt.dbo.dt_svc_lab_result
 inner join [research_qa].[dbo].[validate checking] 
 ON test_code=code
 inner join rdc_dt.dbo.dt_service
 on dt_svc_lab_result.service_id=dt_service.service_id

) as de

where 
(result_value < lower_limit
or
result_value > upper_limit)
and 
result_unit=unit
