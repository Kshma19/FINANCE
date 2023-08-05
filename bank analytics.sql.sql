create database bank_loan;
use bank_loan;
show tables;
select * from finance_1;
select * from finance_2;
describe finance_2;
describe finance_1;
alter table finance_1 add monthly_installment int (25);
alter table finance_1 add yearly_installment int (25);
select id,loan_amnt,int_rate,term, monthly_installment, yearly_installment from finance_1;
#select term as "substr(term,1,2)" from finance_1;
#select substr(term,1,2)  from finance_1;
Update finance_1 Set monthly_installment=(loan_amnt + (loan_amnt *int_rate*term/1200))/term;
Update finance_1 Set yearly_installment=(loan_amnt + (loan_amnt *int_rate*term/1200))/(term/12);
select * from finance_1;

-------------------------------------------------------------------------------------------------------------
# KPI No 2. Grade and sub grade wise revol_bal

select * from finance_1 F1 inner join finance_2 F2 on f1.id = f2.id;

select f1.id, f1.grade,f1.sub_grade,f2.revol_bal from finance_1 f1 inner join finance_2 F2 on f1.id = f2.id;
#select f1.id, f1.grade,f1.sub_grade,f2.revol_bal from finance_1 f1 inner join finance_2 F2 on f1.id = f2.id group by grade; 
select grade,sub_grade,sum(revol_bal) as total
from finance_1 inner join finance_2 on finance_1.id=finance_2.id group by grade,sub_grade;
select sub_grade,sum(revol_bal) as  total
from finance_1 inner join finance_2 on finance_1.id=finance_2.id group by sub_grade;
select grade,sum(revol_bal) as  total
from finance_1 inner join finance_2 on finance_1.id=finance_2.id group by grade;
--------------------------------------------------------------------------------------------------------------

# KPI No 3. Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status,sum(total_pymnt) as total
from finance_1 inner join finance_2 on finance_1.id=finance_2.id group by verification_status;

---------------------------------------------------------------------------------------------------------------------------------------

# KPI No 4. State wise and last_credit_pull_d wise loan status.
select * from finance_1;
select * from finance_2;
select addr_state, last_credit_pull_d,loan_status as loan_status
from finance_1 inner join finance_2 on finance_1.id=finance_2.id;
select addr_state, last_credit_pull_d, loan_status, count(loan_status) from finance_1 inner join finance_2 on finance_1.id=finance_2.id
group by addr_state, last_credit_pull_d, loan_status;
---------------------------------------------------------------------------------------------------------------------------------------
# KPI No 5. Home ownership Vs last payment date stats
select * from finance_1;
select * from finance_2;
select home_ownership, last_pymnt_d, count(home_ownership) from finance_1 inner join finance_2 on finance_1.id=finance_2.id
group by home_ownership;

select home_ownership, last_pymnt_d, count(home_ownership) from finance_1 inner join finance_2 on finance_1.id=finance_2.id
group by home_ownership,last_pymnt_d;