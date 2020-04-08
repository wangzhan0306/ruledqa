Drop table #A, #B,#C,#D

create table #A(
patient_id numeric(22,0)
,test_code varchar(200)
,test_time datetime
,location_name varchar(200)
);

create table #B(
patient_id numeric(22,0)
--,test_code varchar(200)
,test_time datetime
);

create table #C
(patient_id numeric(22,0)
);

create table #D
(patient_id numeric(22,0)
,test_code1 varchar(200)
,location_name varchar(200)
,test_code2 varchar(200)
);

insert #A

select  

dt_service.patient_id
,dt_svc_lab_result.test_code
,dt_svc_lab_result.test_time
,dt_service.location_name

FROM [rdc_dt].[dbo].[dt_svc_lab_result] inner join rdc_dt.dbo.dt_service on  dt_svc_lab_result.service_id=dt_service.service_id
where dt_svc_lab_result.test_code='1547-9'
Select * from #A

insert #B
select  
--dt_svc_lab_result.service_id
dt_service.patient_id
--,dt_svc_lab_result.test_code
,dt_svc_lab_result.test_time

FROM [rdc_dt].[dbo].[dt_svc_lab_result] inner join rdc_dt.dbo.dt_service on  dt_svc_lab_result.service_id=dt_service.service_id
where dt_svc_lab_result.test_code='3016-3'

Select * from #B

insert #C
select 
#A.patient_id
 from #A inner join #B 
 on #A.patient_id=#B.patient_id
 where DATEDIFF(month,#A.test_time,#B.test_time)<=12 
 and DATEDIFF(month,#A.test_time,#B.test_time)>=0

Select * from #C

insert #D
select 
patient_id
,test_code
,location_name
,'3016-3' as test_code2
from #A
where patient_id not in 
( select
patient_id 
from #C) 

Select * from #D

Drop table #A, #B,#C,#D

 
