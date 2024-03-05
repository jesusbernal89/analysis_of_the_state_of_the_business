WITH recover_probability_table AS (SELECT *, 
    contactability_score*0.75 AS recover_probability -- Multiplication of contactability and payment probability
 FROM `storiproject.storidata.storidatatable`),

-- Making variable boolean with a value threshold of 0.28 (median of the values)
recover_accounts AS(

SELECT *, CASE WHEN recover_probability >= 0.28 THEN 1 ELSE 0 END AS recover_account 
FROM recover_probability_table

)

-- Selecting just recovered accounts and sum the total debt
SELECT SUM(total_debt) from recover_accounts
WHERE recover_account = 1;