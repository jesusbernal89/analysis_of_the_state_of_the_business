-- Calculating median of the probability of recovery of the accounts

WITH median_value AS (SELECT 
    contactability_score*0.75 AS recover_probability -- Multiplication of contactability and payment probability
 FROM `storiproject.storidata.storidatatable`)

-- Calculating median with percentile_cont BigQuery function.

 Select distinct(percentile_cont(recover_probability, 0.5) OVER()) AS median_recover_probability
 from median_value;