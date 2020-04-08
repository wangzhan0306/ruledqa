
--SELECT * FROM #D
Drop table #C,#D

SET NOCOUNT ON

create table #C
(service_id numeric(22,0),
test_code varchar(200),
test_time date,
change float,
days int,
result_value float,
knowledge_id int);

create table #D
(service_id numeric(22,0),
--test_desc varchar,
test_code varchar(200),
test_time date,
change float,
days int,
result_value float,
--result_unit varchar,
knowledge_id int);

insert #C
select  dt_svc_lab_result.service_id, 
dt_svc_lab_result.test_code,
dt_svc_lab_result.test_time,
[delta checking].change as change,
[delta checking].days as days,
case when (isnumeric(dt_svc_lab_result.result_value)=1 )
and dt_svc_lab_result.result_value is not null 
and dt_svc_lab_result.result_value not like '%,%'
and dt_svc_lab_result.result_value != '.'
and dt_svc_lab_result.result_value not like '%_%'
then cast(dt_svc_lab_result.result_value as float)
end as result_value,
[delta checking].knowledge_id


from
rdc_dt.dbo.dt_svc_lab_result inner join [research_qa].[dbo].[delta checking] 
ON dt_svc_lab_result.test_code=[delta checking].[code] 
order by dt_svc_lab_result.test_time


DECLARE @Counter int;
DECLARE @tableLength int;
SET @Counter = 1;
SET @tableLength =1

WHILE (@Counter <= @tableLength)
BEGIN;
 
DECLARE MyCURSOR CURSOR

for select * from #C

where knowledge_id = @Counter;
 
OPEN MyCursor

DECLARE @service_id numeric(22,0), @test_code varchar ,@test_time date,@change float, @days int, @result_value float, @knowledge_id int
    FETCH NEXT FROM  MyCURSOR INTO @service_id, @test_code, @test_time, @change, @days, @result_value, @knowledge_id
	WHILE @@FETCH_STATUS =0
    BEGIN

insert into #D	
select * from #C

where 
#C.service_id=@service_id
and #C.test_code= @test_code
--and dt_svc_lab_result.result_unit=@result_unit
and abs(DATEDIFF(DAY,#C.test_time,@test_time)) < #C.days
and abs(@result_value-#C.result_value)>#C.change
and #C.knowledge_id = @Counter


FETCH NEXT FROM MyCURSOR INTO @service_id, @test_code, @test_time, @change, @days, @result_value, @knowledge_id
    END    


CLOSE MyCursor

DEALLOCATE MyCursor

SET @Counter = @Counter + 1; --increment the counter
END
select * from #D
drop table #C,#D

	
	