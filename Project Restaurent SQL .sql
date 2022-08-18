-- create table customers
create table customers (
	customerId int not null,
  	name text not null,
  	phone int,  
primary key (customerId)
);


-- insert data into customers
insert into customers values
  (1, 'Somchai', '+661111111'),
  (2, 'Prayut' , '+662222222'),
  (3, 'Boondee', null), 
  (4, 'Judy', '+664444444'), 
  (5, 'Akekanut', '+665555555'), 
  (6, 'Panitan', '+666666666'), 
  (7, 'Annop', null), 
  (8, 'Aussada', '+668888888'), 
  (9, 'Tunwa', '+669999999'), 
  (10, 'Somwang', '+660001111'); 

-- create table orders
create table orders (
  orderId int not null,
  employeeId int not null,
  customerId int not null,
  menuId int not null,
  noItem int not null,
primary key (orderId),
foreign key (employeeId) references employees(employeeId),
foreign key (customerId) references customers(customerId),
foreign key (menuId) references menus(menuId)
);

-- insert data into orders
insert into orders values
  (1, 2, 5, 5, 1),
  (2, 2, 5, 8, 1),
  (3, 6, 9, 2, 2),
  (4, 5, 2, 6, 1),
  (5, 1, 4, 5, 1),
  (6, 1, 4, 7, 1),
  (7, 3, 7, 1, 1),
  (8, 3, 7, 6, 2),
  (9, 3, 7, 10, 1),
  (10, 2, 1, 9, 4),
  (11, 8, 3, 3, 1),
  (12, 8, 6, 4, 2),
  (13, 8, 8, 4, 2),
  (14, 9, 10, 10, 2); 

-- create table menus
create table menus (
  menuId int not null,
  menuName text not null,
  unitPrice real not null,
primary key (menuId)
);

-- insert data into menus
insert into menus values
	(1, 'Buta-No-Shogayaki', 105.50),
	(2, 'Champon', 199.50),
	(3, 'Edamame', 99.00),
	(4, 'Gyoza', 100.50),
	(5, 'Gyudon', 250.00),
	(6, 'Karaage', 70.50),
	(7, 'Katsudon', 190.00),
	(8, 'Sushi', 280.50),
	(9, 'Oden', 145.00),
	(10, 'Robatayaki', 399.00); 

-- create table reviews
create table reviews (
  reviewId int not null,
  customerId text not null,
  reviewDetail text,
primary key (reviewId),
foreign key (customerId) references customers(customerId)
);

-- insert data into reviews
insert into reviews values
	(1, 1, 'Good'),
	(2, 2, null),
	(3, 3, 'very good'),
	(4, 4, 'friendly staff'),
	(5, 5, 'delicious'),
	(6, 6, 'Great Gyoza'),
	(7, 7, 'The most amazing food ever!'),
	(8, 8, "Sushi was delicious"),
	(9, 9, "Amazing food"),
	(10, 10, null); 

-- create table employees
create table employees (
  employeeId int not null,
  employeeName text not null,
  employeePhone text,
primary key (employeeId)
);

-- insert data into employees
insert into employees values
  (1, 'Airi', '+667678888'),
  (2, 'Chiyoko' , '+667779900'),
  (3, 'Hana', '+667786666'), 
  (4, 'Kazuko', '+662231234'), 
  (5, 'Manami', '+666554321'), 
  (6, 'Mitsuki', '+661234444'), 
  (7, 'Sachiko', '+665673333'), 
  (8, 'Yoku', '+667792222'), 
  (9, 'Takaya', '+669001111'), 
  (10, 'Daiki', '+669099999'); 
  
-- select and Join table
  
select * from customers;
select * from orders;
select * from menus;
select * from reviews;
select * from employees;

select * from customers 
where customerId >= 1 and customerId <= 5;

select * from customers
where phone is null;

select
    A.customerId,
    A.Name customerName,
    B.orderId,
    B.noItem no_Item
from customers A 
join orders B on A.customerId = B.customerId
order by A.customerId;

select
    A.customerId,
    A.Name customerName,
    B.reviewDetail reviews
from customers A 
join reviews B on A.customerId = B.customerId 
where B.reviewDetail is not null;

select
    A.employeeId,
    A.employeeName,
    B.orderId,
    b.noItem
from employees A 
join orders B on A.employeeId = B.employeeId
order by B.orderId;


select 
  A.orderId,  
  B.name,
  C.menuName,
  A.noItem,
  D.employeeName
from orders A
join customers B on A.customerId = B.CustomerId
join menus C on A.menuId = C.menuId
join employees D on A.employeeId = D.employeeId;

select
    customers.name, 
    sum(orders.noItem) as n_Item
from customers  
join orders on customers.customerId = orders.orderId 
group by 1 
order by 2 desc limit 5;

select
    employees.employeeId,
    employees.employeeName, 
    count(*) n_orders
from employees
join orders on employees.employeeId = orders.employeeId
group by employees.employeeId; 

select menus.menuName, 
  count(*) as n_orders 
from menus, orders
where menus.menuId = orders.menuId
group by menus.menuName
order by count(*) desc;


-- Subquery
SELECT 
  employeeid, 
  firstname,
  strftime("%Y-%m", hiredate)AS Hire_YM
FROM (SELECT * FROM employees
      WHERE STRFTIME("%Y", hiredate) = '2002') 
ORDER BY hiredate;

SELECT 
  play_track.playlistid, 
  play.name,
  count(*) AS n_tracks
FROM playlist_track play_track
JOIN (SELECT * FROM playlists
      WHERE playlistid >= 5) play
ON play_track.playlistid = play.playlistid
GROUP BY 1
ORDER BY 3 DESC;

SELECT
    ar.artistid,
    ar.name,
    COUNT(*) n_albums
FROM artists ar
JOIN (SELECT * FROM albums 
     WHERE albumid BETWEEN 1 AND 50) al
ON ar.artistid = al.artistid
GROUP BY 1
ORDER BY 3 DESC LIMIT 10;

