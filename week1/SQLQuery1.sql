use university
go 

select * 
from instructor; 

-- show the dept name of instructors 
select distinct dept_name
from instructor

--show the name and monthly salary of each instructor 
select name, salary/12 as monthly_salary 
from instructor

-- show the instructor from computer science department
-- whose salary > 7000 
select name, salary
from instructor
where dept_name = 'Comp. Sci.' and salary > 70000

-- use join work on multiple tables 
-- show the instructors and the course_ID they teach 
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID

select name, course_id
from instructor
inner join teaches on instructor.ID = teaches.ID

-- show the instrucots and course id from biloly department 
select name, course_id
from instructor
inner join teaches on instructor.ID = teaches.ID
where instructor.dept_name = 'biology'


-- show the instrucots based on the salary in the ascending order 
select name, salary
from instructor
	inner join teaches on instructor.ID = teaches.ID
order by salary asc

-- show the instructor with salary between 90000 and 100000
select name, salary
from instructor
where salary between 90000 and 100000
-- where salary >= 90000 and salary <= 100000

-- string operation, find the instructors whose name contains 'and' 
select name 
from instructor
where name like '%and%'

-- find the highest and the average salary of all instructors 
select max(salary) as max_salary, avg(salary) as average_salary 
from instructor

-- count the number of rows in the instructor releation 
select count(*) as number_of_rows
from instructor

-- count the number of instuctors teacheing in Spring 2009 
select count(*) as number_of_teachers_Spring_2010
from instructor, teaches
where instructor.ID = teaches.ID and semester = 'Spring' and year = 2010

select count(distinct ID)
from teaches
where semester = 'Spring' and year = 2010