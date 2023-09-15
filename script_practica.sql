-- Creamos el Schema donde trabajaremos
create schema keepcoding;

-- Creamos las tablas y las relaciones
create table keepcoding.grupo_empresarial(
	id_empresa serial primary key,
	nombre varchar(50) not null
);

create table keepcoding.marca(
	id_marca serial primary key,
	nombre varchar(50) not null,
	slogan varchar(100) not null,
	grupo_empresarial int not null,
	constraint fk_grupo_empresarial foreign key (grupo_empresarial) references keepcoding.grupo_empresarial (id_empresa)
);

create table keepcoding.modelo(
	id_modelo serial primary key,
	nombre varchar(50) not null,
	marca int not null,
	constraint fk_marca foreign key (marca) references keepcoding.marca (id_marca)
);

create table keepcoding.color(
	id_color serial primary key,
	color varchar(30) unique not null
);

create table keepcoding.aseguradora(
	id_aseguradora serial primary key,
	aseguradora varchar(20) unique not null
);

create table keepcoding.moneda(
	id_moneda serial primary key,
	moneda varchar(6) unique not null
);

create table keepcoding.coche(
	id_coche serial primary key,
	matricula varchar(15) not null,
	kilometros int default 0,
	fecha_de_compra date not null,
	numero_de_poliza varchar(50) not null,
	importe decimal(8,2) not null,
	modelo int not null,
	color int not null,
	aseguradora int not null,
	moneda int not null,
	constraint fk_modelo foreign key (modelo) references keepcoding.modelo (id_modelo),
	constraint fk_color foreign key (color) references keepcoding.color (id_color),
	constraint fk_aseguradora foreign key (aseguradora) references keepcoding.aseguradora (id_aseguradora),
	constraint fk_moneda foreign key (moneda) references keepcoding.moneda (id_moneda)
);

create table keepcoding.revision(
	id_revision serial primary key,
	kilometros int not null,
	importe decimal(8,2) not null,
	fecha date not null,
	coche int not null,
	moneda int not null,
	constraint fk_coche foreign key (coche) references keepcoding.coche (id_coche),
	constraint fk_moneda foreign key (moneda) references keepcoding.moneda (id_moneda)
);

-- Insertamos valores de prueba
insert into keepcoding.grupo_empresarial (nombre) values 
('Volkswagen Group'), 
('TATA'), ('Toyota'), 
('DAIMLER'), 
('BMW Group');

insert into keepcoding.marca (nombre, slogan, grupo_empresarial) values
('Volkswagen', 'Das auto', 1), 
('Seat', 'Tecnologia para disfrutar', 1), 
('Jaguar', 'Grace, Space, Pace', 2), 
('Lexus', 'The pursuit of perfection', 3), 
('Mercedes', 'Lo mejor o nada', 4), 
('BMW', 'Freude am Fahren', 5), 
('Mini', 'Small Wins', 5);

insert into keepcoding.modelo (nombre, marca) values 
('Golf', 1),
('Polo', 1),
('Leon', 2),
('RWD AT R-Dynamic SE', 3),
('Luxury', 4),
('Mercedes-AMG GT', 5),
('Serie 3', 6),
('Cooper', 7);

insert into keepcoding.color (color) values
('Rojo'),
('Blanco'),
('Gris'),
('Negro');

insert into keepcoding.aseguradora (aseguradora) values
('Mapfre'),
('AXA'),
('Pelayo'),
('Mutua Madrileña');

insert into keepcoding.moneda (moneda) values
('EUR'),
('USD'),
('CHF'),
('MXN');

insert into keepcoding.coche (matricula, kilometros, fecha_de_compra, numero_de_poliza, importe, modelo, color, aseguradora, moneda) values
('1234 AAA', 100000, now(), 'AF-132546', 15499.99, 2, 4, 2, 1),
('4569 AAA', 151000, now(), 'AF-165476', 10499.99, 1, 1, 1, 2),
('8745 AAA', 184560, now(), 'AF-198756', 9499.99, 1, 2, 1, 3),
('9512 AAA', 13650, now(), 'AF-123366', 20499.99, 3, 3, 3, 3),
('9514 AAA', 184260, now(), 'AF-13126', 3000.99, 4, 4, 4, 4),
('4159 AAA', 186240, now(), 'AF-198566', 7500.00, 5, 1, 4, 1),
('5419 AAA', 123650, now(), 'AF-187456', 19499.99, 6, 1, 4, 1),
('8426 AAA', 110010, now(), 'AF-154786', 12499.99, 7, 2, 1, 1),
('7532 AAA', 195480, now(), 'AF-195126', 16499.99, 7, 3, 2, 2),
('1489 AAA', 162150, now(), 'AF-195146', 14000.00, 8, 3, 3, 3),
('6574 AAA', 142350, now(), 'AF-165426', 17200.00, 8, 4, 2, 4);

insert into keepcoding.revision (kilometros, importe, fecha, coche, moneda) values
(1000, 200, now(), 1, 1),
(5000, 750, now(), 3, 3),
(3000, 400, now(), 5, 3),
(10000, 120, now(), 10, 2),
(4000, 250, now(), 8, 4),
(15000, 3000, now(), 7, 1);

-- Query

select 
	m.nombre as "Nombre modelo",
	ma.nombre as "Nombre marca",
	ge.nombre as "Nombre grupo empresarial",
	c.fecha_de_compra as "Fecha de compra",
	c.matricula as "Matricula",
	col.color as "Color",
	c.kilometros as "Kilometros",
	a.aseguradora as "Aseguradora",
	c.numero_de_poliza as "Numero de poliza"
from keepcoding.coche c
join keepcoding.modelo m on c.modelo = m.id_modelo
join keepcoding.marca ma on m.marca = ma.id_marca 
join keepcoding.grupo_empresarial ge on ma.grupo_empresarial = ge.id_empresa
join keepcoding.color col on c.color = col.id_color
join keepcoding.aseguradora a on c.aseguradora = a.id_aseguradora;

