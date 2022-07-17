DROP DATABASE IF EXISTS OPTIC;
CREATE DATABASE OPTIC;
USE OPTIC;

CREATE TABLE addresses
(
address_id int not null auto_increment unique,
street varchar(50) not null,
number int,
floor int,
gate varchar(3),
city varchar(50),
pc int not null,
country varchar(50),
primary key (address_id)
) ENGINE=InnoDB;

insert into addresses values(1,'Quesada', 3150, 0, '3', 'Barcelona', 08040, 'España');
insert into addresses values(2,'Valencia', 34, 3, '4', 'Granollers', 08400, 'España');
insert into addresses values(3,'Granada', 50, 1, '1', 'Barcelona', 08040, 'España');
insert into addresses values(4,'Cargol', 20, 5, '9', 'Granollers', 08400, 'España');
insert into addresses values(5,'Numancia', 80, 2, '2', 'Barcelona', 08040, 'España');
insert into addresses values(6,'Remolar', 17, 0, '3', 'Mollet', 080300, 'España');
insert into addresses values(7,'Bosc', 20, 2, '6', 'Mollet', 08300, 'España');
insert into addresses values(8,'Glories', 60, 8, '7', 'Montmelo', 08450, 'España');
insert into addresses values(9,'Valencia', 50, 1, '1', 'Les Franqueses', 08450, 'España');
insert into addresses values(10,'Lluc', 1, 1, '8', 'Mataro', 08500, 'España');


CREATE TABLE suppliers
(
supplier_id int not null auto_increment unique,
address_id int not null,
supplier_name varchar(50) not null,				
phone varchar (50) not null,
fax varchar(50),
nif varchar(50) not null,
index (address_id),
primary key (supplier_id),
constraint fk_address_id foreign key (address_id) references addresses (address_id)
on delete cascade on update cascade
) ENGINE=InnoDB;

insert into suppliers values(1, 1, 'todo_gafas', '888999000', '888999000', '45999837T');
insert into suppliers values(2,2,'gafas_sol', '666999333', '333999777', '66666666T');
insert into suppliers values(3,4,'verano_store', '777777777', '333222777', '34343434H');
insert into suppliers values(4,3,'solete', '66666666', '333333333','923492090L');
insert into suppliers values(5,6,'todo_gafas', '999999999', '3433434343', '28909033U');
insert into suppliers values(6,5, 'mar_playa', '66688888','4444444444', '48592485j');


CREATE TABLE recomendations
(
recomendation_id int not null auto_increment unique,
name varchar(50) not null,
primary key (recomendation_id)
)ENGINE=InnoDB;

insert into recomendations values (1, 'Laura Pérez');
insert into recomendations values (2, 'Claudio Naranjo');


CREATE TABLE clients
(
client_id int not null auto_increment unique,
client_name varchar(50)  not null,
address_id int not null,
phone varchar (50) not null,
email varchar (255) default null,
date_registration date not null,
recomendation_id int default null,
index(recomendation_id),
index(address_id),
primary key(client_id),
constraint fk_addresses_id foreign key (address_id) references addresses (address_id),
constraint fk_recomendation_id foreign key (recomendation_id) references recomendations (recomendation_id)
on delete cascade on update cascade
)ENGINE=InnoDB;

insert into clients values (1, 'Pedro Lopéz', 6, '555555555', null, '2022,01,13', null);
insert into clients values (2,'Xavi Muñoz', 7, '333333333', 'xavi@hotmail.com','2021,08,4','1'  );
insert into clients values (3, 'Laura Pérez', 8, '111111111', 'laura@gmail.com', '2022,07,05', '2');
insert into clients values (4, 'Ana Nuñez', 9 , '222222222', null, '2020,03,10', null);


CREATE TABLE glasses
(
glasses_id int not null auto_increment unique,
brand varchar(50) not null,
prescription_right double not null,
prescription_left double not null,
type_frame varchar (20) not null,
glass_color varchar(50) not null,
price double not null,
supplier_id int not null,
primary key (glasses_id),
index (supplier_id),
constraint fk_supplier_id foreign key (supplier_id) references suppliers (supplier_id)
on delete cascade on update cascade
)ENGINE=InnoDB;

/* tipo de frame: flotante, pasta o metálica*/

insert into glasses values(1,'Benetton', 0.5, 0.75, 'flotante', 'verde', 105.99, 6);
insert into glasses values(2,'Gucci', 0.9, 1.5, 'pasta', 'negra', 79.99, 5);
insert into glasses values(3, 'Siloutte', 0.25, 025, 'metálica', 'negra', 99.99, 4);
insert into glasses values(4, 'Affelou', 0.8, 0.9, 'flotante', 'negra', 59.99, 3);
insert into glasses values(5, 'Italia', 1.5, 2.0, 'pasta', 'azul', 89.99, 2);
insert into glasses values(6,'Universitaria', 0.75, 0.5, 'metálica','azul', 139.99, 1);


CREATE TABLE sellers 
(
seller_id int not null auto_increment unique primary key,
seller_name varchar(50)
)ENGINE=InnoDB;

insert into sellers values(1, 'Pedro');
insert into sellers values(2, 'Luna');
insert into sellers values(3, 'Juan');


CREATE TABLE invoices 
(
invoice_id int not null auto_increment unique,
client_id int not null,
seller_id int not null,
date_invoice date not null,
index(client_id),
index (seller_id),
primary key (invoice_id),
constraint fk_client_id foreign key(client_id) references clients (client_id)
on delete cascade on update cascade
 )ENGINE=InnoDB;
 
 insert into invoices values (1, 4, 1,'2022-07-01');
 insert into invoices values (2, 3, 2, '2021-06-03');
 insert into invoices values (3, 2, 3, '2022-03-25');
 insert into invoices values (4, 1, 1, '2021-11-09');
 insert into invoices values (5, 3, 2, '2021-12-28');
 insert into invoices values (6, 4, 2, '2022-05-09');
 insert into invoices values (7, 4, 1, '2021-12-31');


CREATE TABLE products_detail
(
product_detail_id int not null auto_increment unique,
invoice_id int not null,
glasses_id int not null,
amount double not null,
index(invoice_id),
index(glasses_id),
primary key (product_detail_id),
constraint fk_invoice_id foreign key (invoice_id) references invoices (invoice_id),
constraint fk_glasses_id foreign key (glasses_id) references glasses (glasses_id)
on delete cascade on update cascade
)ENGINE=InnoDB;

insert into products_detail values(1, 5, 3, 1);
insert into products_detail values(2, 5, 5, 1);
insert into products_detail values(3, 1, 1, 2);
insert into products_detail values(4, 2, 2, 1);
insert into products_detail values(5, 3, 4, 2);
insert into products_detail values(6, 4, 6, 1);


/*
Llista el total de factures d'un client/a en un període determinat*/
select C.client_id, I.date_invoice from invoices as I
inner Join clients as C on I.client_id = C.client_id
where
C.client_id = 4
and I.date_invoice > NOW() - INTERVAL 6 MONTH;


/*Llista els diferents models d'ulleres que ha venut un empleat/da durant un any.*/
select S.seller_id, G.type_frame, I.date_invoice from products_detail as PD
inner join invoices as I on PD.invoice_id = I.invoice_id
inner join glasses as G on PD.glasses_id = G.glasses_id
inner join sellers as S on I.seller_id = S.seller_id
where S.seller_id = 1
and I.date_invoice > NOW() - INTERVAL 12 MONTH
and G.type_frame = 'metálica';

/*Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica*/
select S.supplier_name, G.brand from invoices as I
inner join products_detail as PD on I.invoice_id = PD.invoice_id
inner join glasses as G on PD.glasses_id = G.glasses_id
inner join suppliers as S on G.supplier_id = S.supplier_id












