use rdc_dt
select distinct patient_id 
	  ,rxnorm_code      
   	  ,med_name
	  ,med_order_date
	  ,location_name
 FROM [rdc_dt].[dbo].[dt_svc_medication] 
  inner join dt_svc_medication_rxnorm on dt_svc_medication_rxnorm.medication_id=dt_svc_medication.med_code
  inner join dt_service on dt_svc_medication.service_id=dt_service.service_id
  where rxnorm_code='8640' and dt_service.[patient_id] not in 
(SELECT
      dt_service.[patient_id]      
      FROM [rdc_dt].[dbo].[dt_svc_lab_result]
  inner join dt_service on [dt_svc_lab_result].service_id=dt_service.service_id
  where test_code ='17856-6')