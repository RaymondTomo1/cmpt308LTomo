
---Question 1-----
--1. List	the	order	number	and	total	dollars	of	all	orders.--
Select orderNum, totalusd 
From Orders;

--2. List	the	last	name	and	home	city	of	people	whose	prefix	is	"Ms.".--

Select lastname, homecity
From people
Where Prefix = 'Ms.';

--3. List	id,	name,	and	quantity	on	hand	of	products	with	quantity	more	than	1007.--

Select prodid, name, qtyonhand
From Products
Where Qtyonhand > '1007';

-- 4. List	the	first	name	and	home	city	of	people	born	in	the	1920s.--

Select firstname, homecity
From People
Where dob between '1920-01-01' 
	and '1929-12-31';
--5. List	the	prefix	and	last	name	of	people	who	are	not	"Mr.".--
--Used a NOT statement in the where row to complete the query--

Select prefix, lastname
From people
Where prefix != 'Mr.';

--6. List	all	fields	for	products	in	neither	Dallas	nor	Duluth	that	cost	US$3	or	less.--

-- Completed by using a series of ANDs in the where column--

Select *
From products
Where city != 'Dallas' 
	and city != 'Duluth' 
	and priceusd <= '3';

--7. List	all	fields	for	orders	in	January--
--Using the extract command, I was able to write the commands out to specifically target the month for the where portion of the query--
Select *
From orders
Where extract (month from dateOrdered) =1;

--8. List	all	fields	for	orders	in	February	of	US$23,000	or	more.--
--I used the extract command as listed above in conjunction with an and to narrow the constraints properly--
Select *
From orders
Where extract (month from dateOrdered) =2 
	and totalusd >= '23000';
	
--9. List	all	orders	from	the	customer	whose	id	is	007.--
-- I simply looked for the custid of 7 for everything within the orders table.--

Select *
From orders
Where custid = '7';


--10. List	all	orders	from	the	customer	whose	id	is	005.--
--See comment above. I repeated the same process--
Select *
From orders
Where custid = '5';