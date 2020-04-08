
drop table #A,#B

SET NOCOUNT ON

create table #A
(service_id numeric(22,0),
test_code varchar(200),
test_time date,
result_value float);

create table #B
(service_id numeric(22,0),
test_code varchar(200),
test_time date,
result_value float);

insert #A
select  dt_svc_lab_result.service_id, 
dt_svc_lab_result.test_code,
dt_svc_lab_result.test_time,
case when (isnumeric(dt_svc_lab_result.result_value)=1 )
and dt_svc_lab_result.result_value is not null 
and dt_svc_lab_result.result_value not like '%,%'
and dt_svc_lab_result.result_value != '.'
and dt_svc_lab_result.result_value not like '%_%'
then cast(dt_svc_lab_result.result_value as float)
end as result_value

from
rdc_dt.dbo.dt_svc_lab_result 
where test_code='1752-5'

DECLARE MyCURSOR CURSOR

for select * from #A
 
OPEN MyCursor

DECLARE @service_id numeric(22,0), @test_code varchar(200),@test_time date, @result_value float
    FETCH NEXT FROM  MyCURSOR INTO @service_id, @test_code, @test_time, @result_value
	WHILE @@FETCH_STATUS =0
    BEGIN

insert into #B	
select * from #A
where 
#A.service_id=@service_id
--and dt_svc_lab_result.result_unit=@result_unit
and abs(DATEDIFF(DAY,#A.test_time,@test_time)) < 2
and abs(@result_value-#A.result_value)>0.6

FETCH NEXT FROM MyCURSOR INTO @service_id, @test_code, @test_time, @result_value
    END    

CLOSE MyCursor

DEALLOCATE MyCursor

select * from #B


	
	