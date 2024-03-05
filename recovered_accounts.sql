WITH recover_probability_table AS (SELECT *, 
    contactability_score*0.75 AS recover_probability -- Multiplication of contactability and payment probability
 FROM `storiproject.storidata.storidatatable`)

-- Obtaining number of recovered accounts
SELECT SUM(CASE WHEN recover_probability >= 0.28 THEN 1 ELSE 0 END) AS recover_account 
FROM recover_probability_table;