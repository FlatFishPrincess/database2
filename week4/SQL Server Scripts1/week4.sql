use university
go

select * from instructor

-- create a view
create view faculty as 
	select ID, name, dept_name
	from instructor;

-- next is to show how to use a view
select	*
from	faculty
where dept_name = 'Biology';

-- more examples
create view physics_fall_2009 as
	select	course.course_id, sec_id, building, room_number
	from	course, section
	where	course.course_id = section.course_id
	  and	course.dept_name = 'Physics'
	  and	semester = 'Fall'
	  and	year = 2009

select	*
from	physics_fall_2009 

-- also can a view from an existing view
create view physics_fall_2009_watson as 
	select	course_id, room_number
	from	physics_fall_2009
	where	building = 'Watson'

-- composition of relational operations 


/*

Select	name
From	instructor
Where	dept_name = ‘Phsics’
composition of perations 
select *
from r,s
where A = C

join operation 
- theta join
select	*
from	r 
	join s on A = C


union operation
(select course_id
from section
where semester = 'Fall' and year = 2009 )
union 
(select course_id
from section
where semester = 'Spring' and year = 2010 )

set differecne operation
r - s
(select course_id
from section
where semester = 'Fall' and year = 2009 )
except 
(select course_id
from section
where semester = 'Spring' and year = 2010 )

Q. r U s = s U r ==> true
Q. r-s = s-r ==> false
Q. r gyogiphop(intersect) s = s gyo s ==> true


as Query 2 extracts physics table then find salary > 9000, more efficient then Query 1

before G is group by in aggregate operation
ex) dept_name G avg(salary) (instrucrtor) 
 => select	avg(salary)
	from	instructor
	groupy by dept_name


discussion 
c pie person_name 


*/
