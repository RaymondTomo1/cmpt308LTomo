--Raymond Tomo 02/22/22 Lab 5--
-- References for Tables--
select*
from orders

select *
from agents

select *
from customers

select *
from people


select *
from products
group by homecity.prodid
order by qtyonhand DESC;

--Question 1--(COMPLETE)
--This problem was simple, as I employed a single join to combine both of the tables--
select distinct p1.*
from People p1
right outer join Customers on p1.pid = Customers.pid;

--Question 2--(COMPLETE)
--This problem was simple, as I employed a single join like I did in the problem above--

select distinct p1.*
from People p1
inner join Agents on p1.pid = Agents.pid;

--Question 3--(COMPLETE)--
--This problem was straightfoward, as I employed two joins to only filter out people who were both people and agents--

select p1.*, agents.*
from People p1
inner join Customers on p1.pid = Customers.pid
inner join Agents on p1.pid = Agents.pid;

--Question 4--(Complete)--
--For this problem I needed to employ subqueries and boolean logic to come to a correct answer.--
select distinct firstname
from people
where pid in
	(select pid
 	from customers 
	 where not exists 
	 	(select custid
		 from orders
		 where orders.custid = customers.pid));

--Question 5--(Complete)--
--For this problem I needed to employ a number of nested subqueries along with a join statement.--
select distinct firstname
from people
inner join customers on customers.pid = people.pid
	left join orders on customers.pid = orders.custID
where orders.custId is NULL;
		
--Question 6--(COMPLETE)
--For this problem I needed to employ a number of nested subqueries along with a join statement.--
select distinct pid, commissionpct
from agents
inner join orders on agents.pid = orders.agentID
where custid = '008'
order by commissionpct DESC;

--Question 7--(Completed)--
--For this problem I needed to employ more joins on top of one another .--
select distinct lastname, homecity, commissionpct
from agents
inner join people on agents.pid = people.pid
inner join orders on agents.pid = orders.agentID
where custid = '001'
order by commissionpct DESC;

--Question 8-- (Complete)
--For this problem I needed to employ a number of nested subqueries along with a join statement.--
select lastname, homecity
from people
inner join Products on People.homecity = Products.city
where Products.qtyonhand in (select min(qtyonhand) as smallestquantity
						  								from Products);

--Question 9--(Complete)
--For this problem I needed to employ a number of nested joins as well as additional filtering at the bottom.--
select name, Products.prodid
from Products 
inner join Orders on Products.prodid = Orders.prodid
	inner join Customers on Orders.custid = Customers.pid
	inner join Agents on Orders.agentid = Agents.pid
		inner join People on People.pid = Customers.pid
where (People.homecity = 'Arlington')
order by name ASC;


--Question 10--(COMPLETE)--
--For this problem I needed to employ a self join in order for it to work, which took some getting used to.--
select distinct a.lastname, a.firstname, a.homecity
from people a, people b
where a.homecity = b.homecity
	and a.firstname <> b.firstname;



