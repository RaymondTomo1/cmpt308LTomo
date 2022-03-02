--Raymond Tomo 03/02/22 Lab 6--

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


select AVG(priceUSD)
from products
group by homecity.prodid
order by qtyonhand DESC;

--Question 1--(Completed)
--To solve this problem, I employed a rank function and a group by function to organize the data--
select city,
rank() over (
	order by count(*) DESC ) rank_no
from products
group by city;

--Question 2--(Completed)
--I employed a subquery and the AVG function to get the average of all values to get this ability--
select name
from products
where priceUSD < 
	(select AVG(priceUSD)
	 from products)
order by name ASC;


--Question 3--(Complete)--
--This problem gave me some trouble, as I needed to look up datetime SQL commands for this in the PostGre Reference doc. However, the to_char function is able to perform this function well --
select lastname, prodid, totalUSD
from people
inner join customers on customers.pid = people.pid
inner join orders on orders.custID = customers.pid
where to_char(dateordered,'MM') = '03';
	
--Question 4--(Complete)--
--For this problem I needed to use the coalesce function to sort out one of the remaining nulls from the orders--
select lastname, coalesce(totalusd, 0)
from people
right join customers on customers.pid = people.pid
left join orders on customers.pid = orders.custid
order by lastname DESC;

--Question 5--(Incomplete)--
--For this problem I needed to employ a number of nested join statements to get the answer I needed.However, I had diffculty trying to extract the name of the agent in this section--
--and was unable to complete  it.--

select p.firstname as customername, products.name as productname --agents.name here--
from people p
inner join customers on p.pid = customers.pid
		inner join orders on orders.custid = customers.pid
			inner join agents on agents.pid = orders.agentid
				inner join products on orders.prodid = products.prodid
where (p.homecity='Chiliwack') or 
	where p.pid in
		(select pid
			from people
			where )
order by name ASC;



--Question 6--(Complete)
--For this problem I made the equation by multiplying the number of products in orders by the price of the individual unit found in (unitquantity * unitprice). I then factored in the discount by subtracting the percentage from 1 ( 1-(discount/100) to get an answer--
--The errors come with the lack of properly applying discounts on some of the orders, which I checked by comparing the original price calculation to my own calculations. --
select orders.totalUSD
from orders
inner join customers on orders.custid= customers.pid
	inner join products on orders.prodid=products.prodid
where orders.totalUSD <> (orders.quantityordered*products.priceusd) * (1-(customers.discountpct/100));


--Question 7--(Complete)
--For this problem I needed to employ more joins on top of one another until it filtered out the desired result .--
select lastname, firstname
from people
inner join customers on customers.pid = people.pid
inner join agents on agents.pid = customers.pid;

--Question 8-- (Complete)
--For this problem I needed to employ views and individually select the columns that would be appropriate for the table--


CREATE VIEW PeopleCustomers as
Select distinct c.pid, p.firstname, p.lastname, p.prefix, p.suffix, p.homecity, p.dob, c.paymentterms, c.discountpct
From people p, customers c
Where p.pid = c.pid;


CREATE VIEW PeopleAgents
AS SELECT DISTINCT a.pid, p.firstname, p.lastname, p.prefix, p.suffix, p.homecity, p.dob, a.paymentterms,a.commissionpct
FROM people p, agents a
Where p.pid = a.pid;

select *
from PeopleCustomers;

select *
from PeopleAgents;

--Question 9--(Complete)
--For this problem I needed to employ a number of nested joins as well as additional filtering at the bottom.--
select PeopleCustomers.lastname, PeopleCustomers.firstname
from PeopleCustomers
inner join PeopleAgents on PeopleAgents.pid = PeopleCustomers.pid; 

--Question 10(Complete)----
--It's treating the two views as two tables being joined together through an inner join, and thus comes up with the same answer as the problem. It's a similar process but with more steps added on.--

--Question 11(Complete)----
--The difference between a left outer join and a right outer join is simple. With a left outer join, the unmatched rows of the left table are included in the final table, while for a right outer join the unmatched values from the right are added into the resulting table. Here is an example.--
select people.pid,firstname
from people
left join customers on customers.pid=people.pid;
-- As you can see, the left join includes EVERYONE from the people table on the left, including both the mismatched values.--
select people.pid,firstname
from people
right join customers on customers.pid=people.pid;
--However this right join will only include the values matched from the information on the people table--