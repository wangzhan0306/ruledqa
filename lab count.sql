use rdc_dt;

select COUNT( distinct patient_id), test_code
from dt_svc_lab_result
inner join dt_service on dt_svc_lab_result.service_id=dt_service.service_id
where dt_svc_lab_result.test_code in
('15152-2'
,'1752-5'
,'17861-6'
,'17864-0'
,'19123-9'
,'2075-0'
,'2160-0'
,'2777-1'
,'2823-3'
,'2951-2'
,'3084-1'
,'3094-0'
,'4544-3'
,'5902-2'
,'6690-2'
,'718-7'
,'777-3'
,'787-2'
,'789-8'
)
 group by test_code