WITH recover_probability_table AS (SELECT *, 
    contactability_score*0.75 AS recover_probability -- Multiplicación de probabilidad de contacto y la probabilidad de pago
 FROM `storiproject.storidata.storidatatable`),

recover_accounts AS(

SELECT *, CASE WHEN recover_probability >= 0.28 THEN 1 ELSE 0 END AS recover_account 
FROM recover_probability_table

)

SELECT SUM(interest) from recover_accounts
WHERE recover_account = 1;
