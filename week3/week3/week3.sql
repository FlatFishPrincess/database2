use university
go

-- find the enrollement of each section that was offered in spring 2009
select S.course_id, S.sec_id, Count(ID) as num
from section S 
	join takes T on S.year = T.year
	and S.semester = T.semester
	and S.course_id = T.course_id
	and S.sec_id = T.sec_id
where S.semester = 'Spring' and S.year = 2009
group by S.course_id, S.sec_id

--why not using takes table only? 

-- list all departments along with the number of instructions
select dept_name, count(*) as #Instuctor
from instructor
group by dept_name

-- use begin tran
/*
begin	tran
update instructor
	set salary = salary * 1.03
	where salary > 90000;

rollback
*/

select salary
from instructor
order by salary asc;

--find the names of all students who have taken at leas one Comp. Sci. course
select	distinct S.name
from	student as S join takes as T 
			on S.ID = T.ID
		join course C
			on T.course_id = C.course_id
where S.dept_name = 'Comp. Sci.'

-- create a new course "CS-001", titled "Weekly Seminar", with 0 credits
begin	tran
insert into course (course_id, title, dept_name, credits)
values ('CS-001', 'Weekly Seminar', 'Comp. Sci.',2)
rollback

select *
from course

-- increase the salary of each instructor in CS by 10%
update	instructor
set		salary = salary * 1.10
where	dept_name = 'Comp. Sci.';

-- insert every student with total credits > 100 as instructor 
-- in the same department, with a salary $30,000

begin tran
insert into instructor
select	ID, name, dept_name, 30000
from student
where tot_cred > 100;
rollback; 

-- the above is an example of how to insert a relation to another
select *
from instructor;

use university
go

select dept_name, average_salary
from ( select dept_name, avg(salary) as average_salary
		from instructor
		group by dept_name) as averge_dept_salary
where average_salary = (select min(salary)
						 from instructor 
						 group by dept_name)
