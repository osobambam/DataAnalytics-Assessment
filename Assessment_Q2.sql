/*
	Query categorising users based on 
    number of transactions
*/
with base_cte as(
  select 
    owner_id, 
    month(transaction_date) month, -- extracting month from transaction date
    count(id) numOfTran -- count of transactions
  from 
    savings_savingsaccount 
  group by 
    owner_id, 
    month(transaction_date) -- aggregating based on owner and month
  order by 
    owner_id, 
    month(transaction_date) -- ordering based on owner and month
), 
-- CTE to create categorisation from average number of transaction per month
base_cte2 as(
  select 
    owner_id, 
    avg(numOfTran) avgTran, 
    -- creating categories
    case when avg(numOfTran) < 3 then 'Low Frequency' 
         when avg(numOfTran) < 10 then 'Medium Frequency' 
         else 'High Frequency' 
         end frequency_category
  from 
    base_cte 
  group by 
    owner_id
) 
select 
  frequency_category, 
  count(frequency_category) customer_count, 
  avg(avgTran) avg_transactions_per_month
from 
  base_cte2 
group by 
  frequency_category
;
