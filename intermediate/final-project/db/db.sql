drop database oms_db;
create database oms_db;
use oms_db;

-- DDL
create table categories (
  id int auto_increment not null, 
  name varchar(50) not null unique, 
  primary key(id)
);

create table items (
  id int auto_increment not null, 
  name varchar(50) default null unique, 
  price int default 0, primary key (id)
);

create table item_categories (
  item_id int not null, 
  category_id int not null, 
  foreign key (item_id) references items(id), 
  foreign key (category_id) references categories(id)
);

create table customers (
  id int not null auto_increment, 
  name varchar(50), 
  phone varchar(15) unique, 
  primary key (id)
);

create table orders (
  id int auto_increment not null, 
  customer_id int not null, 
  order_date_time datetime default now(),
  status char(1) not null default('2'), 
  primary key (id), 
  foreign key (customer_id) references customers(id)
);
 
create table order_details (
  item_id int not null, 
  order_id int not null, 
  quantity int default 1, 
  foreign key (item_id) references items(id), 
  foreign key (order_id) references orders(id)
);

-- DML - Insert 
insert into customers (name, phone) values 
('Budiawan', '+62123456789'),
('Mary Jones', '+62876543219'),
('Deborah', '+62897532149'),
('Generation Girl', '+62123456769'),
('Go Academy', '+628789098789');

insert into items (name, price) values 
('Nasi Goreng Gila', 20000),
('Ice Water', 2000),
('Spaghetti', 40000),
('Green Tea Latte', 18000),
('Vanilla Ice Cream', 13000),
('Cordon Bleu', 36000),
('French Fries', 20000),
('Mango Juice', 15000),
('Orange Juice', 15000),
('Es Podeng', 15000);

insert into categories (name) values ('Main Dish'), ('Beverage'), ('Dessert');

insert into item_categories (item_id, category_id) values 
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 3),
(6, 1),
(7, 1);

insert into orders (customer_id, order_date_time, status) values 
(1, now(), '1'),
(2, now(), '1'),
(1, now() - interval 1 day, '1'),
(2, now() - interval 1 day, '1'),
(2, now() - interval 2 day, '2');

insert into order_details (order_id, item_id, quantity) values 
(1, 1, 2),
(1, 2 ,2),
(2, 3, 5),
(2, 3, 2),
(2, 2, 3),
(3, 5, 1),
(4, 10, 3),
(5, 6, 1),
(5, 7, 2);

drop database oms_db_test;
create database oms_db_test;
use oms_db_test;

-- DDL
create table categories (
  id int auto_increment not null, 
  name varchar(50) not null unique, 
  primary key(id)
);

create table items (
  id int auto_increment not null, 
  name varchar(50) default null unique, 
  price int default 0, primary key (id)
);

create table item_categories (
  item_id int not null, 
  category_id int not null, 
  foreign key (item_id) references items(id), 
  foreign key (category_id) references categories(id)
);

create table customers (
  id int not null auto_increment, 
  name varchar(50), 
  phone varchar(15) unique, 
  primary key (id)
);

create table orders (
  id int auto_increment not null, 
  customer_id int not null, 
  order_date_time datetime default now(),
  status char(1) not null default('2'), 
  primary key (id), 
  foreign key (customer_id) references customers(id)
);
 
create table order_details (
  item_id int not null, 
  order_id int not null, 
  quantity int default 1, 
  foreign key (item_id) references items(id), 
  foreign key (order_id) references orders(id)
);