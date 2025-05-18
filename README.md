Question1:
My approach to this question was to write a CTE with its content being customer details, sum of confirmed_amount and account type and grouped it based on customer details and plan_id. 
I also filtered it ensuring that each account type is funded. Then I queried that CTE to give the customer details, the count of savings and investment plan and the sum 
of total deposits and grouped it by the owner_id. I also filtered it ensure that it returns customers that both have at least 1 savings and 1 investment account.

Question2:
My approach to this question was to write a CTE that returned the owner_id, month of the transaction date and the count of transactions. I grouped it by owner_id and the month of the transaction
date so that it would give me the number of transactions for each user each month. Then I wrote another CTE quering the first CTE to return the owner_id, the average number of transactions
for each user per month and categorisation of the frequency of usage usine CASE statements and grouped it by the owner_id. Then finally, I queried the second CTE to return the categorisation, number of customers
in each categorisation

Question3:
My approach to this question was to write a CTE that returned the owner_id, plan_id, account type and the last transaction date using MAX and grouped it by the owner_id and plan_id. I filtered it such that
the transaction date was between the current date and 365 days before using DATE_SUB. Also i used is_deleted column to determin whether the plan is active or not. I then queried the CTE to return the plan_id,
owner_id and account type using CASE statements, last transaction date and number of inactive days using DATEDIFF with the current date and last transaction date.

Question4:
My approach to this question was to write a cte that returned the owner_id, name, the tenure of each customer using TIMESTAMPDIFF , number of total transactions for each user and the average profit per
transaction and grouped it by owner_id. I then queried that CTE to return customer details, the tenure in months and the estimated customer lifetime value using the formula given.
