

select dt_svc_observation.service_id as service_id, 
dt_svc_observation.observation_type as observation_type, 
dt_svc_observation.observation_code as test_code,
dt_svc_observation.observation_value as observation_value, 
dt_svc_observation.observation_code as observation_code, 
dt_svc_observation.value_unit as value_unit, 
[Valid Low] as valid_low,
[Valid High] as valid_high,
location_name,
[obs].knowledge_id as knowledge_id

from
rdc_dt.dbo.dt_svc_observation inner join [research_qa].[dbo].[obs] ON dt_svc_observation.observation_code=[obs].[observation_code] and value_unit=Units
inner join rdc_dt.dbo.dt_service on dt_svc_observation.service_id=dt_service.service_id 


where 


(case when (isnumeric(dt_svc_observation.observation_value)=1 )
--and dt_svc_lab_result.result_value is not null 
and dt_svc_observation.observation_value not like '%,%'
and dt_svc_observation.observation_value != '.'
--and dt_svc_lab_result.result_value not like '%_%')
then cast(dt_svc_observation.observation_value as float)
end) < obs.[Valid Low]

or (case when (isnumeric(dt_svc_observation.observation_value)=1 )
--and dt_svc_lab_result.result_value is not null 
and dt_svc_observation.observation_value not like '%,%'
and dt_svc_observation.observation_value != '.'
--and dt_svc_lab_result.result_value not like '%_%')
then cast(dt_svc_observation.observation_value as float)
end) > obs.[Valid High]

