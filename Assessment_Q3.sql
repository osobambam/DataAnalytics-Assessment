/*
	query showing number of inactive days/ time since last
	transaction of active plans/accounts in the last 1 year
*/
with prep_cte as(
  select 
    a.id planId, 
    a.owner_id, 
    max(transaction_date) last_transaction_date, -- get the last transaction date
    is_regular_savings, 
    is_a_fund 
  from 
    plans_plan a 
    inner join savings_savingsaccount b 
		on a.id = b.plan_id 
  where 
    is_regular_savings = 1 
    or is_a_fund = 1 
    and is_deleted = 0 -- interpretation of whether plan is active
    and transaction_date between date_sub(
      current_timestamp(), 
      interval 365 day
    ) 
    and current_timestamp() -- filter ensuring date range is 1 year
  group by 
    owner_id, 
    a.id
) 
select 
  planId, 
  owner_id, 
  -- creating account categories
  case when is_regular_savings = 1 then 'Savings' 
	   when is_a_fund = 1 then 'Investment'
       end type,
  last_transaction_date, 
  datediff(
    current_timestamp(), 
    last_transaction_date
  ) inactivity_days
from 
  prep_cte
;
