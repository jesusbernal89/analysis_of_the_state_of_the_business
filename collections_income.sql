WITH recover_probability_table AS (SELECT *, 
    total_debt + interest AS debt_plus_interest,
    contactability_score*0.75 AS recover_probability -- Multiplication of contactability and payment probability
 FROM `storiproject.storidata.storidatatable`),

-- Making variable boolean with a value threshold of 0.28 (median of the values)
recover_accounts_p AS(

SELECT *, CASE WHEN recover_probability >= 0.28 THEN 1 ELSE 0 END AS recover_account 
FROM recover_probability_table

),

-- Selecting just recovered accounts
recovered_accounts AS (
    SELECT debt_plus_interest from recover_accounts_p
    WHERE recover_account = 1

),

-- Calculating campaign cost by multiplying $30 * all customers. 
campaign_cost AS (
    SELECT 
        COUNT(*) * (-30) AS total_campaign_cost
    FROM `storiproject.storidata.storidatatable`
), 

-- Sum of campaign cost and total recovered debt

final_table AS (
SELECT 
    SUM(recovered_accounts.debt_plus_interest) AS total_recovered_debt
FROM 
    recovered_accounts
UNION ALL 
SELECT 
    *
FROM 
    campaign_cost)

select sum(final_table.total_recovered_debt) from final_table;