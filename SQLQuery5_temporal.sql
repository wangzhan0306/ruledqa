DECLARE @Counter int;
DECLARE @tableLength int;
DECLARE @tablename1 nvarchar(255);
DECLARE @tablename2 nvarchar(255);
DECLARE @datename1 nvarchar(255);
DECLARE @datename2 nvarchar(255);
DECLARE @jointable1 nvarchar(255);
DECLARE @jointable2 nvarchar(255);
DECLARE @joinkey nvarchar(255);
DECLARE @key1 nvarchar(255);
DECLARE @key2 nvarchar(255);
DECLARE @sql nvarchar(1000);

SET @Counter = 44;
SET @tableLength = 55; --(select count(*) from fully qualified knowledgeTable);

--'top x' limits your results while testing but should be removed for real runs!!!!!!!!!!!!
WHILE (@Counter <= @tableLength)
BEGIN

select @tablename1=Temporal_Sequence.table_name_1, @tablename2=Temporal_Sequence.table_name_2, @datename1=Temporal_Sequence.date_name_1,
 @datename2=Temporal_Sequence.date_name_2, @joinkey=Temporal_Sequence.join_key, @jointable1=Temporal_Sequence.join_table_1, 
 @jointable2=Temporal_Sequence.join_table_2,@key1=Temporal_Sequence.key_1, @key2=Temporal_Sequence.key_2--, @Counter1=@Counter
from research_qa.dbo.Temporal_Sequence where Knowledge_ID=@Counter


--dynamic sql query
If @tablename1=@tablename2 
begin

set @sql= 'insert into  [research_qa].[UAMS\WangZhan].[temporal _squence_result] ( time_1, time_2, patient_id, location_name)
select ' + @tablename1+'.'+@datename1+' as time_1, '+@tablename2+'.'+@datename2+
' as time_2, dt_patient.patient_id as patient_id, dt_service.location_name as location_name
from rdc_dt.dbo.'+@tablename1+
' where datediff(day,'+@tablename1+'.'+@datename1+','+@tablename2+'.'+@datename2+')/365>=1';
print @sql
EXEC ( @sql)

update [research_qa].[UAMS\WangZhan].[temporal _squence_result] set time_1_name=@datename1, time_2_name=@datename2, knowledge_id=@Counter
where research_qa.[UAMS\WangZhan].[temporal _squence_result].time_1_name is null

end

else if @jointable1='1' and @tablename1!=@tablename2 
begin
--set @sql= 'insert into  [research_qa].[UAMS\WangZhan].[temporal _squence_result] (time_1, time_2, patient_id, run_time)
--select ' + @tablename1+'.'+@datename1+' as time_1, '+@tablename2+'.'+@datename2+
set @sql= 'insert into  [research_qa].[UAMS\WangZhan].[temporal _squence_result] ( time_1, time_2, patient_id, location_name)
select ' + @tablename1+'.'+@datename1+' as time_1, '+@tablename2+'.'+@datename2+
' as time_2, dt_patient.patient_id as patient_id, dt_service.location_name as location_name
from rdc_dt.dbo.'
+@tablename1+' inner join rdc_dt.dbo.'+@tablename2+ ' on '+ @tablename1+'.'+@key1+' = '+@tablename2+'.'+@key1+

' where datediff(day,'+@tablename1+'.'+@datename1+','+@tablename2+'.'+@datename2+')/365>=1';
print @sql
EXEC ( @sql)

update [research_qa].[UAMS\WangZhan].[temporal _squence_result] set time_1_name=@datename1, time_2_name=@datename2, knowledge_id=@Counter
where research_qa.[UAMS\WangZhan].[temporal _squence_result].time_1_name is null
end

else if @jointable2='1' and @jointable1!='1' and @tablename1!=@tablename2 
begin
set @sql= 'insert into  [research_qa].[UAMS\WangZhan].[temporal _squence_result] ( time_1, time_2, patient_id, location_name)
select ' + @tablename1+'.'+@datename1+' as time_1, '+@tablename2+'.'+@datename2+
' as time_2, dt_patient.patient_id as patient_id, dt_service.location_name as location_name
from (rdc_dt.dbo.'
+@tablename1+' inner join rdc_dt.dbo.'+@jointable1+ ' on '+ @tablename1+'.'+@key1+' = '+ @jointable1+'.'+@key1+
') inner join rdc_dt.dbo.'+@tablename2+ ' on '+ @jointable1+'.'+@key2+' = '+ @tablename2+'.'+@key2+

' where datediff(day,'+@tablename1+'.'+@datename1+','+@tablename2+'.'+@datename2+')/365>=1';
print @sql
EXEC ( @sql)

update [research_qa].[UAMS\WangZhan].[temporal _squence_result] set time_1_name=@datename1, time_2_name=@datename2, knowledge_id=@Counter
where research_qa.[UAMS\WangZhan].[temporal _squence_result].time_1_name is null
end
	
else if @jointable2!='1' and @tablename1!=@tablename2 
begin
set @sql= 'insert into  [research_qa].[UAMS\WangZhan].[temporal _squence_result] ( time_1, time_2, patient_id, location_name)
select ' + @tablename1+'.'+@datename1+' as time_1, '+@tablename2+'.'+@datename2+
' as time_2, dt_patient.patient_id as patient_id, dt_service.location_name as location_name
from ((rdc_dt.dbo.'
+@tablename1+' inner join rdc_dt.dbo.'+@jointable1+ ' on '+ @tablename1+'.'+@key1+' = '+ @jointable1+'.'+@key1+
') inner join rdc_dt.dbo.'+@jointable2+ ' on '+ @jointable1+'.'+@joinkey+' = '+ @jointable2+'.'+@joinkey+
') inner join rdc_dt.dbo.'+@tablename2+ ' on '+ @jointable2+'.'+@key2+' = '+ @tablename2+'.'+@key2+

' where datediff(day,'+@tablename1+'.'+@datename1+','+@tablename2+'.'+@datename2+')/365>=1';
print @sql
EXEC ( @sql)

update [research_qa].[UAMS\WangZhan].[temporal _squence_result] set time_1_name=@datename1, time_2_name=@datename2, knowledge_id=@Counter
where research_qa.[UAMS\WangZhan].[temporal _squence_result].time_1_name is null

end


	
--end (this part selects the row from the knowledge table to test against)
	SET @Counter = @Counter + 1; --increment the counter
END
go