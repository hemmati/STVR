CREATE VIEW all_products_steps_result AS 
SELECT all_products_steps_view.case_id,all_products_steps_view.step_id,all_products_steps_view.instruction,all_products_steps_view.version,execution_result.status,all_products_steps_view.product_name
FROM all_products_steps_view,execution_stepresult,execution_result
WHERE all_products_steps_view.step_id = execution_stepresult.step_id
and execution_stepresult.result_id = execution_result.id