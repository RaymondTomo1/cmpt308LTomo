

--- Lab 10--Raymond Tomo---


--below is the provided creation script for the tables--

----------------------------------------------------------------------------------------
-- Courses and Prerequisites
-- by Alan G. Labouseur
-- Tested on Postgres 9.3.2
----------------------------------------------------------------------------------------



--
-- The table of courses.
--
create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;


--
-- An example stored procedure ("function")
--
create or replace function get_courses_by_credits(int, REFCURSOR) returns refcursor as 
$$
declare
   num_credits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  credits >= num_credits;
   return resultset;
end;
$$ 
language plpgsql;

select get_courses_by_credits(0, 'results');
Fetch all from results;

---------------------------------------------------------------------------------------

----Creation script ends here----------------------------------------------------------

----------------------------------------------------------------------------------------
-- 	PreReqsFor and IsPreReqFor
-- by Raymond Tomo
-- Tested on PgAdmin4
----------------------------------------------------------------------------------------
--Basis I used for the functions
--
-- An example stored procedure ("function")
--
create or replace function get_courses_by_credits(int, REFCURSOR) returns refcursor as 
$$
declare
   num_credits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  credits >= num_credits;
   return resultset;
end;
$$ 
language plpgsql;

select get_courses_by_credits(0, 'results');
Fetch all from results;

-----Function 1- PreReqsFor----
--cNumber used as courseNum threw an error---
-------------------------------
create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   cNumber int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select preReqNum
      from  Courses c, Prerequisites p
      where  c.num = p.courseNum
	  and c.num = cNumber;
   return resultset;
end;
$$ 
language plpgsql;

----Test for Function (499 should return 221 and 308. 120 should return nothing.)--
select PreReqsFor(499, 'results');
Fetch all from results;

select PreReqsFor(120, 'results');
Fetch all from results;


-----Function 2- IsPreReqFor----
--pNumber used as prereqnum threw an error---
--------------------------------
create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   pNumber int := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select c.num
      from  Courses c, Prerequisites p
      where  c.num = p.courseNum
	  and p.prereqnum = pNumber;
   return resultset;
end;
$$ 
language plpgsql;
----Test for Function (Should both return 499 to mirror the first problem, 120 should have 308,220 values)--
select IsPreReqFor(221, 'results');
Fetch all from results;

select IsPreReqFor(308, 'results');
Fetch all from results;

select IsPreReqFor(120, 'results');
Fetch all from results;