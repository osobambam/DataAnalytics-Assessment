/*
	Query estimation each customer's liftime value
*/
with base_cte as (
  select 
    a.id userId, 
    concat(first_name, ' ', last_name) name, 
    timestampdiff(
      month, 
      a.created_on, 
      current_timestamp()
    ) tenure_months, -- calculating differnce in months from account creation till date
    count(savings_id) total_transactions, -- counting number of transaction for each customer
    avg(confirmed_amount * 0.001) avg_profit_per_transaction -- calculation of avergae profit per transaction
  from 
    users_customuser a 
    inner join savings_savingsaccount b 
		on a.id = b.owner_id 
  group by 
    a.id
) 
select 
  userId, 
  name, 
  tenure_months, 
  total_transactions, 
  (
    total_transactions / tenure_months
  ) * 12 * avg_profit_per_transaction estimated_clv -- estimated_clv calculation
from 
  base_cte
;