Drop table #A, #B,#C,#D

create table #A(
patient_id numeric(22,0)
,rxnorm_code nvarchar(255)
,med_start_date datetime
,med_end_date datetime
,location_name varchar(200)
);

create table #B(
patient_id numeric(22,0)
--,test_code varchar(200)
,proc_start_date datetime
);

create table #C
(patient_id numeric(22,0)
);

create table #D
(patient_id numeric(22,0)
,rxnorm_code nvarchar(255)
,location_name varchar(200)
--,test_code varchar(200)
);

insert #A
select  
--dt_svc_medication_new.service_id
dt_service.patient_id
,dt_svc_medication_rxnorm.rxnorm_code
,dt_svc_medication_new.med_start_date
,dt_svc_medication_new.med_start_date
,dt_service.location_name

FROM [rdc_dt].[dbo].[dt_svc_medication_rxnorm] inner join rdc_dt.dbo.dt_svc_medication_new on dt_svc_medication_rxnorm.medication_id=dt_svc_medication_new.med_code
inner join [rdc_dt].[dbo].dt_service on dt_svc_medication_new.service_id=dt_service.service_id
where dt_svc_medication_rxnorm.rxnorm_code='6851' 
--or dt_svc_medication_rxnorm.rxnorm_code='202462'

Select * from #A

insert #B
select  
--dt_svc_lab_result.service_id
dt_service.patient_id
--,dt_svc_lab_result.test_code
,dt_svc_procedure.proc_start_date

FROM [rdc_dt].[dbo].[dt_svc_procedure] inner join rdc_dt.dbo.dt_service on  dt_svc_procedure.service_id=dt_service.service_id
where dt_svc_procedure.proc_code in 
--('92002' , '92004', '92012', '92014', '92015', '99172', '99173','92018','92019','92225','92226','92230','92240','92250','92284','92003'
--  ,'99201','99202','99203','99204','99205','99211','99212','99213','99214','992015') 
('86704', '86706', '86708', '86803', '87340')

Select * from #B

insert #C
select 
#A.patient_id
 from #A inner join #B 
 on #A.patient_id=#B.patient_id
 --where DATEDIFF(month,#A.med_end_date,#B.proc_start_date)<=24 
 --and DATEDIFF(month,#A.med_start_date,#B.proc_start_date)>=0

Select * from #C

insert #D
select 
patient_id
,rxnorm_code
,location_name
--,'1752-5' as test_code
from #A
where patient_id not in 
( select
patient_id 
from #C) 

Select * from #D

Drop table #A, #B,#C,#D

 
