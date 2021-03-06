/****** Script for SelectTopNRows command from SSMS  ******/
use rdc_dt
select distinct patient_id 
	  ,rxnorm_code      
    -- ,med_name
	--  ,med_order_date
	--  ,location_name
 FROM  dt_svc_medication 
  inner join dt_svc_medication_rxnorm on dt_svc_medication_rxnorm.medication_id=dt_svc_medication.med_code
  inner join dt_service on dt_svc_medication.service_id=dt_service.service_id
  where rxnorm_code in
  ('3008', '3407', '6448', '8050','8183','35302','42316','11124','8134','11118','2002','1596450','10627','641','10438','1886','68149','6851') 

  and patient_id not in 
  (SELECT
      dt_service.[patient_id]      
      FROM [rdc_dt].[dbo].[dt_svc_diagnosis]
      inner join dt_service on dt_svc_diagnosis.service_id=dt_service.service_id
      where dx_code in ('Z51.81','V58.83') )