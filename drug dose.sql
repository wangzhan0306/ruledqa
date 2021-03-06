/****** Script for SelectTopNRows command from SSMS  ******/

create table #A(
med_code nvarchar(200)-- not null

,avg float-- not null
,stdev float 
,unit nvarchar(200)
);

insert #A

SELECT --TOP (1000) 
      [med_code] as med_code
 
     -- ,[med_code_type]
      ,avg(case when (isnumeric(med_dose)=1) 
     -- and med_dose is not null 
     -- and med_dose not like '%,%'
    -- and med_dose != '.'
    -- and med_dose not like '%_%'
    then cast(med_dose as float)
	end) as avg,
	stdev(case when (isnumeric(med_dose)=1) 
       then cast(med_dose as  float)
	end) as stdev
	     ,[med_dose_unit] as unit
     
  FROM [rdc_dt].[dbo].[dt_svc_medication]
  where med_dose is not null 
  group by med_code, med_dose_unit

  select dt_svc_medication.service_id
  , dt_svc_medication.med_code
  , med_name
  , med_dose
  , med_dose_unit
  , #A.avg as avg
  , #A.stdev as stdev
  , location_name
  from (dt_svc_medication
   inner join  dt_service
   on dt_service.service_id = dt_svc_medication.service_id)
  inner join #A 
  on dt_svc_medication.med_code=#A.med_code 
  and dt_svc_medication.med_dose_unit=#A.unit
  where  
  stdev!=0
  and
  isnumeric(med_dose)=1
  and
  (cast(med_dose as float)>#A.avg+3*#A.stdev
  or 
  cast(med_dose as float)<#A.avg-3*#A.stdev)
  order by med_code
	
  --select * from #A
  drop table #A