--Raymond Tomo --
--02/15/22 --
--Lab 4 --


-- References for Tables--
select*
from orders

select *
from agents

select *
from customers

select *
from people


-- Question 1---
--Comments--
--Using the syntax given in class, I was able to write this simple subquery out and learned the importance of the in command--
select *
from people
where pid in (select pid 
			  from agents);
			  
--Question 2---
--Comments--
--This is almost identical to problem 1, so my explanation remains the same--

Select *
from people
where pid in (select pid 
			  from customers);
			  
--Question 3--
--Comments--
--As with the previous problem, this subquery was simple to execute with the information given in class--

select *
from people
where pid  in (select pid 
				  from customers)
					and (pid  in (select pid 
									 from agents));
								
								
-- Question 4---
--Comments--
--In order to get the correct answer, I learned how to nest my statments together more carefully and needed to clean it up to make it run properly.--

select *
from people
where pid not in (select pid 
				  from customers)
					and (pid not in (select pid 
									 from agents));
		
--Question 5--
--Comments--
--This was a simple query I solved using the boolean logic I have used in other coding assignments, since this covers standard boolean logic--

select  custid
from Orders
where ((prodid='p01') 
	   or (prodid='p03'));

--Question 6--
--Comments--
--This was the last problem I tackled after encountering many errors trying to get it working. Once I corrected my syntax, it was much easier to make it more efficient--

select DISTINCT custid
from Orders
where custid in
(select custid
 from orders 
 where prodid='p05') 
 		and custid in
 			(select custid
  			from orders 
  			where prodid='p07')
order by custid desc;


--Question 7--
--Comments--
--While I was initally confused on how to get rid of my duplicate answers, select distinct was able to help me narrow down the queries further--

select distinct lastname, firstname
from people
where pid in
	(select agentid
 		from orders 
 			where ((prodid='p05')) or (prodid='p07'))
order by lastname desc;
--Question 8--
--Comments--
--Using my code for question 7, I restructured some of the syntax in order to make it work with this new prompt--

select homecity, dob
from people
where pid in
	(select agentid
	from orders 
 	where (custid='8'))
order by homecity asc;


--Question 9--
--Comments--
--In this problem, I struggled to nest the statments together initially. I remebered that working backwards in order to get to the correct SQL query would make things easier,and corrected my mistake.--

select distinct prodid
from orders
where agentid in
	(select agentid
 		from orders 
 		where custid in
		 		(select pid
			 		from people
			 		where (homecity='Montreal')))
order by prodid desc;


--Question 10--
--Comments--
--In this problem, I needed to combine the code I used with question 9 with the same logic behind problem 6 in order to get the correct answer.--

select lastname, homecity
from people
where pid in
	(select custid
 	from orders 
 	where custid in
		 	(select pid
			 from people
			 	where (homecity='Chilliwack') or(homecity='New Orleans')))
order by firstname ASC;

