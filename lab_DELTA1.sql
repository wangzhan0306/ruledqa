DECLARE @Counter int;
DECLARE @tableLength int;
SET NOCOUNT ON
SET @Counter = 1;
SET @tableLength = 5 

WHILE (@Counter <= @tableLength)
BEGIN;
 
DECLARE MyCURSOR CURSOR

for select distinct dt_svc_lab_result.service_id, 
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
rdc_dt.dbo.dt_svc_lab_result inner join [research_qa].[dbo].[delta checking] 
ON dt_svc_lab_result.test_code=[delta checking].[code] 

where [delta checking].knowledge_id = @Counter
 
OPEN MyCursor

DECLARE @service_id numeric(22,0), @test_code varchar ,@test_time date, @result_value float
    FETCH NEXT FROM  MyCURSOR INTO @service_id, @test_code, @test_time, @result_value
	WHILE @@FETCH_STATUS =0
    BEGIN
	
select de.service_id, de.test_desc, de.test_code,de.test_time,
de.result_value,
de.result_unit, 
de.knowledge_id,
SYSDATETIME() as run_time

from 
(select dt_svc_lab_result.service_id as service_id, 
dt_svc_lab_result.test_desc as test_desc, 
dt_svc_lab_result.test_code as test_code,
dt_svc_lab_result.test_time as test_time,
[delta checking].change as change,
[delta checking].days as days,
case when (isnumeric(dt_svc_lab_result.result_value)=1 )
and dt_svc_lab_result.result_value is not null 
and dt_svc_lab_result.result_value not like '%,%'
and dt_svc_lab_result.result_value != '.'
and dt_svc_lab_result.result_value not like '%_%'
then cast(dt_svc_lab_result.result_value as float)
end as result_value, 
dt_svc_lab_result.result_unit as result_unit, 
[delta checking].knowledge_id as knowledge_id

from
rdc_dt.dbo.dt_svc_lab_result inner join [research_qa].[dbo].[delta checking] ON dt_svc_lab_result.test_code=[delta checking].[code] 
where dt_svc_lab_result.test_code= 
(SELECT [delta checking].[code]
 FROM [research_qa].[dbo].[delta checking]
 WHERE [delta checking].knowledge_id = @Counter)
) as de

where 
de.service_id=@service_id
and de.test_code= @test_code
--and dt_svc_lab_result.result_unit=@result_unit
and DATEDIFF(DAY,de.test_time,@test_time) < de.days
and abs(@result_value-de.result_value)>de.change
and de.knowledge_id = @Counter


FETCH NEXT FROM MyCURSOR INTO @service_id, @test_code, @test_time, @result_value
    END    


CLOSE MyCursor

DEALLOCATE MyCursor

SET @Counter = @Counter + 1; --increment the counter
END

	
	