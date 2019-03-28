use university
go

select * 
from instructor 
where name like '%and%'; 

-- concatenate 
select CONCAT(name, '+', dept_name)
from instructor

-- some more string functions 
-- in sql, index begins with 1 
-- syntax: SUBSTRING(string, start, length)
select LOWER(name), UPPER(name), SUBSTRING(name, 1, 3) as initial3
from instructor; 

-- set operations 
select distinct course_id
from section as S
where (S.year = 2009 and S.semester = 'Fall') 
or ( S.year = 2010 and S.semester = 'Spring'); 

-- find the courses that run in both Fall 2009 and Spring 2010 
select distinct course_id
from section as S
where (S.year = 2009 and S.semester = 'Fall') 
or ( S.year = 2010 and S.semester = 'Spring'); 

-- use union 
-- automatically use distinct 
(select	course_id
from	section 
where	semester = 'Fall' and year = 2009) 
union
(select	course_id
from	section 
where	semester = 'Spring' and year = 2010) 

--find the courses that run in Fall 2009 but not in Spring 
(select	course_id
from	section 
where	semester = 'Fall' and year = 2009) 
except 
(select	course_id
from	section 
where	semester = 'Spring' and year = 2010) 

-- find the salaries of all instructors that are lower than the highest salary 
(select	salary
from	instructor)
except 
(select	MAX(salary)
from	instructor)

-- Q. then how I get name along with salary? 
(select	salary
from	instructor)
except 
(select	MAX(salary)
from	instructor)



-- work with null 
select 5 + null
select 5 * null

-- use is null to compare with null 
-- Three-valued logic using the value unknown: 
/*
OR: (unknown or true ) = true 
	(unknown or false ) = unknown 
	(unknown or unknown ) = unknown 

AND: (unknown and true ) = unknown 
(unknown and false ) = false  
(unknown and unknown ) = unknown

NOT: (not unknown) = unknown

*/

-- find the total number of instructors who teach a course in Spring 2010
 select COUNT(distinct ID) as total_number
 from teaches
 where semester = 'Spring' and year = 2010

 -- find the average salary of instructors in each department 
 select AVG(salary) as average_salary, dept_name
 from instructor
 group by dept_name;

 -- exercises 
 -- find the titles of courses in the Comp. Sci. department that have 3 creadits 
 select title
 from course 
 where dept_name IN ('Comp. Sci.') and credits = 3;

 -- find the highest salary of any instuctor 
 select MAX(salary) as highest_salary 
 from instructor

 -- find all instructors earning the highest salary 
 select * 
 from instructor
 where salary in (  select MAX(salary)
					from instructor);

-- find the enrollment of each section that was offered in Spring 2009 
select *
from section 
where semester = 'Spring' and year = 2009
-- ?? answers? 


-- ***********************
--		subquery 
-- ***********************

-- find courses run in both Fall 2009 and Spring 2010 
select course_id
from section
where semester = 'Fall' and year = 2009 and course_id in 
	(select course_id
	 from section
	 where semester = 'Spring' and year = 2010); 

-- find courses that run in Fall 2009 but not in Spring 2010

select course_id
from section
where semester = 'Fall' and year = 2009 and course_id not in 
	(select course_id
	 from section
	 where semester = 'Spring' and year = 2010); 

-- find instructors with salary higher than that of 
-- at least one instructor in the Physics department 
select name
from instructor 
where salary > (select min(salary)
				from instructor
				where dept_name = 'Physics');
-- same as below
select name
from instructor 
where salary >some (select salary
					from instructor
					where dept_name = 'Physics');


-- some: greater than at least one value(minimum) 
/* 
-- syntax 
SELECT [column_name... | expression1 ]
FROM [table_name]
WHERE expression2 comparison_operator {ALL | ANY | SOME} ( subquery )
*/

-- find the names of instructors with salary higher than that of 
-- all instructors in the computer science department 
select name
from instructor 
where salary > (select max(salary)
				from instructor
				where dept_name = 'Comp. Sci.');

select name
from instructor 
where salary > all (select (salary)
					from instructor
					where dept_name = 'Comp. Sci.');

-- use exist 
-- find courses that run in both Fall 2009 and Spring 2010 
select course_id
from section as S
where semester = 'Fall' and year = 2009 and 
	exists (select *
			from section as T
			where semester = 'Spring' and year = 2010 
			and S.course_id = T.course_id);		

select course_id
from section as S
where semester = 'Fall' and year = 2009 and 
	not exists (select *
			from section as T
			where semester = 'Spring' and year = 2010 
			and S.course_id = T.course_id);		

-- find the average instructors' salary of those departments where 
-- the average salary is greater than 42000

-- creat average table per department
-- then add where clause to find whose average salary is greater than 42000 

select	dept_name, avg_salary
from	(select dept_name, avg(salary) as avg_salary
		 from instructor
		 group by dept_name) as dept_avg
where	avg_salary > 42000

-- Q. how to get exept for the minimum salary?? 
select	dept_name, avg_salary
from	(select dept_name, avg(salary) as avg_salary
		 from instructor
		 group by dept_name) as dept_avg
where	avg_salary > 42000


-- correlated 
-- list all departments along with the number of instructors in each 
select dept_name, (select count(*)
					from instructor
					where D.dept_name = instructor.dept_name)
					as num_instructors 
from department as D;


