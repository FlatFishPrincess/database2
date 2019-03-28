use university
go

/*
Find the names of all instructors who have taught at least one Comp. Sci.
course in Spring 2009. Make sure there are no duplicate names in the result.
*/

-- dept_name in course is more accurate 
-- as some instructors have courses that are not their department 
select	distinct name
from	instructor 
inner join	teaches on instructor.ID = teaches.ID
inner join course on course.course_id = teaches.course_id
where semester = 'Fall' and course.dept_name = 'Comp. Sci.' and year = 2009


/*
Across all departments, find the department with the lowest average salary
of instructors. You may assume that every department has at least one
instructor.
*/

select dept_name, avg(salary)
from instructor
group by dept_name 
having avg(salary) <= all (select avg(salary)
							from instructor 
							group by dept_name)


-- a. find the names of all emplyees who work for "first bank Corporation"

select person_name
from works
where company_name = 'First Bank Corporation'



-- b. find the nmaesm street addressm and cities of residence of all employees 
-- who work for first banck corporation and earn more than 10,000
select distinct person_name, street, citiy
from works 
inner join employee on works.person_name = works.person_name
where company_name =  'First Bank Corporation' and salary > 10000

-- instructor answer
select *
from employee
where person_name in (select person_name
						from works
						where company_name = 'First Bank Corporation' and salary > 1000)

-- Q3 
-- a. Find the names of all employees in the database who live in the same cities 
-- as the companies for which they work
select person_name
from employee E
	join works W on E.person_name = E.person_name
	join company C on E.city = E.city
where W.company_name = C.company_name

-- b. Find the company that has the smallest payroll, namely the total salary
select company_name
from works
group by company_name
having sum(salary) <= all (select sum(salary)
							from works
							group by company_name)

-- c. give all managers of First Bank Corporation a 15 percent raise
update wokrs 
set salary = salary * 1.15
where person_name in (select distinct manager_name
					  from manages)
and company_name = 'First Bank Corporation'

-- Q4.
-- a. Find the names of members who have borrowed any book published by McGraw-Hill

select name
from members M
join borrowed R on M.memb_no = R.memb_no
join book B on B.isbn on R.isbn
where B.publisher = 'McGraw-Hill'
 
-- b. For each publisher, find the names of members who have borrowed 
-- more than three books of that publisher

select publisher, name
from (select publisher, name, COUNT(isbn)
		from member M
		join borrowed R on M.memb_no = R.memb_no
		join book B on B.isbn on R.isbn
		group by publisher, name) as group_table (publisher, name, count_book)
where count_book >3 

-- we can make alias from the customed table

select publisher, name
from (select publisher, name, COUNT(isbn) as count_book
		from member M
		join borrowed R on M.memb_no = R.memb_no
		join book B on B.isbn on R.isbn
		group by publisher, name) as group_table
where count_book >3 


--- this won't work as I make alias names avg_salary and use it in having statement
select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name
having avg_salary > 4200


-- this works
select dept_name, avg(salary) 
from instructor
group by dept_name
having avg(salary) > 4200

-- we can use alias from subquery 
select dept_name, avg_salary
from (select dept_name, avg(salary) as avg_salary
		from instructor
		group by dept_name) as dept_avg
where avg_salary > 42000;

