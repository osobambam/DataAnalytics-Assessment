/*
	SQL Query to find users with at least 1
    funded savings and investment plan
*/
with base_cte as(
  select 
    a.id owner_id, 
    first_name, 
    last_name, 
    b.id planID, 
    sum(confirmed_amount) planBal, -- sum of deposits/inflows
    is_regular_savings, 
    is_a_fund
  from 
    users_customuser a 
    inner join plans_plan b 
		on a.id = b.owner_id 
    left join savings_savingsaccount c 
		on b.id = c.plan_id 
  where 
    confirmed_amount is not null 
    and confirmed_amount != 0 -- filter ensuring either saving or investment account is funded
  group by 
    a.id, 
    first_name, 
    last_name, 
    b.id
) 
select 
  owner_id, 
  concat(first_name, ' ', last_name) name, 
  sum(is_regular_savings) savings_count, -- total number of saving accounts
  sum(is_a_fund) inv_count,  -- total number of investment accounts
  sum(planBal) total_deposits
from 
  base_cte 
group by 
  owner_id 
having 
  sum(is_regular_savings) > 0 
  and sum(is_a_fund) > 0 -- filter ensuring the user has at least 1 saving and investment account
order by
	total_deposits desc
;