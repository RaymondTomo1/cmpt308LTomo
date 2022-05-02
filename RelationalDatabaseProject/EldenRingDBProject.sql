----------------------------------------------------------
--Elden Ring Database Project--
--By Raymond Tomo--
--04/28/2022----
----------------------------------------------------------
DROP TABLE IF EXISTS Entities;
DROP TABLE IF EXISTS Enemies;
DROP TABLE IF EXISTS Bosses;
DROP TABLE IF EXISTS NPCs;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Weapons;
DROP TABLE IF EXISTS Armor;
DROP TABLE IF EXISTS Spells;
DROP TABLE IF EXISTS Areas;

----Table Statements---------------------------------------
--This is where I will create my table SQL---

Create table if not exists  Entities(
   entityid int UNIQUE NOT NULL,
   name varchar(100) NOT NULL,
   health int NOT NULL,
   runesdropped int check (runesdropped <= 500000),
   Primary key (entityid)
);

Create table if not exists Areas(
	areaid int UNIQUE NOT NULL,
	name varchar(100) NOT NULL,
	recommendedlevel int NOT NULL,
	mainboss varchar(100) NOT NULL,
	Primary key (areaid)
);


Create table if not exists Enemies(
   entityid int NOT NULL,
   areaid int NOT NULL,
   type varchar(20) NOT NULL,
   qty int NOT NULL,
	Primary key (entityid),
	Foreign Key (areaid)
		References Areas(areaid)
);
Create table if not exists Bosses(
   entityid int NOT NULL,
   areaid int NOT NULL,
   required boolean NOT NULL,
	defeated boolean NOT NULL,
	Primary key (entityid),
	Foreign Key (areaid)
		References Areas(areaid)
);
Create table if not exists NPCs(
   entityid int NOT NULL,
   areaid int NOT NULL,
   questrelated boolean NOT NULL,
	alivestatus boolean NOT NULL,
	Primary key (entityid),
	Foreign Key (areaid)
		References Areas(areaid)
);
Create table if not exists Weapons(
   weaponid int UNIQUE NOT NULL,
   wname varchar(50) NOT NULL,
	attribute varchar(10) NOT NULL,
	areaid int NOT NULL,
	Primary key (weaponid),
	Foreign Key (areaid)
		References Areas(areaid)
);
Create table if not exists Armor(
   armorid int UNIQUE NOT NULL,
   aname varchar(50) NOT NULL,
	weightclass varchar(10) NOT NULL,
	areaid int NOT NULL,
	Primary key (armorid),
	Foreign Key (areaid)
		References Areas(areaid)
);
Create table if not exists Spells(
   spellid int UNIQUE NOT NULL,
   sname varchar(50) NOT NULL,
	spellattribute varchar(10) NOT NULL,
	areaid int NOT NULL,
	Primary key (spellid),
	Foreign Key (areaid)
		References Areas(areaid)
);
Create table if not exists Players(
   playerid int UNIQUE NOT NULL,
   name varchar(50) NOT NULL,
	startingclass varchar(50) NOT NULL,
   level int NOT NULL,
	runes int NOT NULL,
	weaponid int NOT NULL,
	armorid int NOT NULL,
	spellid int NOT NULL,
	Primary key (playerid),
	Foreign Key (weaponid)
		References Weapons(weaponid),
	Foreign Key (armorid)
		References Armor(armorid),
	Foreign Key (spellid)
		References Spells(spellid)
);
---Insert Values--
Insert into Entities
	Values(1,'godrickthegrafted', 100000, 50000),
	(2,'renallaqueenofthefullmoon', 100000, 10000),
			(3,'starscourgerahdan', 200000, 25000),
			(4,'rykardtheserpent', 200000, 25000),
			(5,'godfreyphantom', 250000, 30000),
			(6,'margitfellomen', 2500, 2500),
			(7,'morgottomenking', 10000, 50000),
			(8,'moghfellomen', 10000, 40000),
			(9,'moghlordofblood', 250000, 390000),
			(10,'maleniabladeofmiquella',250000, 490000),
			(11,'malekithblackblade', 300000, 10000),
			(12,'godskinduo', 300000, 10000),
			(13,'godfreyfirsteldenlord', 300000, 490000),
			(14,'ragadonofthegoldenorder', 400000, 490000),
			(15,'eldenbeast', 400000, 500000),
			(16,'leonineknight', 1000, 10000),
			(17,'firegiant', 50000, 100000),
			(18,'nightscavalry', 50000, 10000),
			(19,'mimictear', 50000, 23000),
			(20,'vayre',500, 0),
			(21,'fia',500, 0),
			(22,'rannithewitch',1000, 0),
			(23,'nomadicmerchant',500, 0),
			(24,'dhunterofthedead',1000, 0),
			(25,'patches',10000, 0),
			(26,'loathsomedungeater',10000, 0),
			(27,'goat',10000, 0),
			(28,'rottenhound',10000, 50),
			(29,'giant',10000, 1000),
			(30,'knight',1000, 2500),
			(31,'demihuman',100, 220),
			(32,'dragon',100000, 25000),
			(33,'oracleenvoy',10000, 240),
			(34,'celebrant',1000, 2500),
			(35,'omen',1050, 1000);
Insert into Areas
	Values(1,'limgrave',1,'godrickthegrafted'),
			(2,'weepingpeninsula',20,'leonineknight'),
			(3,'caelid',50,'starscourgeradahn'),
			(4,'lirunia',50,'renallaqueenofthefullmoon'),
			(5,'altusplain',50,'none'),
			(6,'leyndellroyalcapital',60,'morgottomenking'),
			(7,'mountaintopofgiants',80,'firegiant'),
			(8,'crumblingfaramazula',90,'malekithblackblade'),
			(9,'leyndellashencapital', 100, 'eldenbeast'),
			(10,'consecratedsnowfield', 100, 'none'),
			(11,'miquellashaligtree', 100, 'maleniabladeofmiquella'),
			(12,'moghwynpalace', 100, 'moghlordofblood'),
			(13,'noskellaancientcity',60,'mimictear');
Insert into Enemies 
	Values (27,1,'animal',100),
			(28,3,'dog',20),
			(29,1,'humanoid', 30),
			(30,5,'humaniod',50),
			(31,2,'humanoid',20),
			(32,3,'dragon', 10),
			(33,4,'humanoid',20),
			(34,12,'humanoid',20),
			(35,6,'omen',20);
Insert into Bosses
	Values(1,1,TRUE,TRUE),
			(2,4,true,true),
			(3,3,true,false),
			(4,5,true,false),
			(5,5,true,false),
			(6,1,true,true),
			(7,5,true,false),
			(8,5,false,false),
			(9,12,false,false),
			(10,11,false,false),
			(11,8,true,false),
			(12,8,true,false),
			(13,9,true,false),
			(14,9,true,false),
			(15,9,false,false),
			(16,2 ,false,true),
			(17, 7,true,false),
			(18, 1,false, true),
			(19, 13,false,false);
Insert into NPCs
	Values(20,1,true,false),
			(21,8,true,true),
			(22,4,true,true),
			(23,1,false,true),
			(24,1,true,true),
			(25,1,true,false),
			(26,6,true,true);
Insert into Weapons
	Values(1,'darkmoongreatsword','int',13),
			(2,'mohgwynssacredspear','arc',12),
			(3,'swordofnightandflame','dex',4),
			(4,'boltofgransax','str',6),
			(5,'riversofblood','dex',7);
Insert into Armor
	Values(1,'allknowingset','medium',9),
			(2,'blackknifeset','light',10),
			(3,'lusatsset','light',4),
			(4,'godskinapostleset','medium',3),
			(5,'radahnset','heavy',3);
Insert into Spells
	Values(1,'cometazure','int',5),
			(2,'burnoflame','faith',7),
			(3,'rannisdarkmoon','int',4),
			(4,'eldenstars','int',9),
			(5,'greyollsroar','faith',3);
			
Insert into Players
	Values(1,'ironpineapple','knight',120,2000,3,5,5),
			(2,'alanthewizard','astrologer',60,0,1,3,5),
			(3,'timtheenchanter','prophet',200,500000,2,4,2);



---Table Test Statements------------------------

select *
from Entities;


select *
from Enemies;

select *
from Bosses;

select *
from NPCs;


select *
from Players;

select *
from Areas;

select *
from Weapons;

select *
from Armor;

select *
from Spells;

--------Reports-----------------------------------------

--Show Most Runes Dropped--
Select Entities.name, Entities.entityid, Entities.runesdropped
From Entities
Group by Entities.entityid
Order by runesdropped DESC;

--Show Main Story Bosses Completion---
Select DISTINCT Entities.name, Entities.entityid
From Entities
Inner Join Bosses
	On Bosses.entityid = Entities.entityid
		Where (Bosses.required = true)
			And Bosses.defeated=true;
							

----Views------------------------------
Drop view EnemyMasterList;
Create or replace view EnemyMasterList as
Select DISTINCT Entities.name, Entities.entityid
From Entities, Bosses, Enemies
Where (Entities.entityid = Bosses.entityid) or (Entities.entityid = Enemies.entityid);

Select *
From EnemyMasterList;


----Stored Procedures--------------------------

---get_bosses_in_area---

Create or replace function get_bosses_in_area(int,REFCURSOR) returns refcursor as
$$
Declare
	selectedareaid  int =$1;
	resultset refcursor = $2;
Begin
	Open resultset for
		Select *
		from bosses
			Where selectedareaid = bosses.areaid;
	Return resultset;
End;
$$
Language plpgsql;

-------get_bosses_cleared-----------
Create or replace function get_bosses_cleared(boolean, REFCURSOR)
returns refcursor as
$$
Declare
	defeatedstatus boolean=$1;
	resultset refcursor  = $2;
Begin
	Open resultset for
		Select *
		from bosses
			Where defeatedstatus = bosses.defeated;
	Return resultset;
End;
$$
Language plpgsql;

Create or replace function past_level_cap()
	Returns trigger as
	$$
	Begin
		Delete from Players
		Where level > 713;
	End;
	$$
	Language plpgsql;

--------------Stored Procedure Test------------
select get_bosses_in_area(1, 'results');
fetch all from results;

select get_bosses_cleared(true, 'results');
fetch all from results;

Insert into Players
	Values(4,'CheatsMcgee','knight',800,2000,3,5,5);
-----Triggers---------------------------

Create trigger past_level_cap
after insert on players
For each row
Execute procedure past_level_cap();

---Roles----
Create role playerrole;
Grant select on players to playerrole;

Create role patchreleaseteam;
Grant update on Entities,Areas,Bosses,NPCs,Enemies,Players,Weapons,Armor,Spells to patchreleaseteam;

Create role itembalancedevrole;
Grant all on Weapons,Armor,Spells to itembalancedevrole;

Create role maindevrole;
Grant all on Entities,Areas,Bosses,NPCs,Enemies,Players,Weapons,Armor,Spells to maindevrole;
