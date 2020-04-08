

select 

dt_svc_observation.observation_code,
count(distinct dt_service.patient_id)

from
rdc_dt.dbo.dt_svc_observation inner join [research_qa].[dbo].[obs] ON dt_svc_observation.observation_code=[obs].[observation_code] and value_unit=Units
inner join rdc_dt.dbo.dt_service on dt_svc_observation.service_id=dt_service.service_id 
group by dt_svc_observation.observation_code


