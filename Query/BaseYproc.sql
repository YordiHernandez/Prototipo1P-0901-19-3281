create database ParcialCompras;
use ParcialCompras;

create table usuarios(
id_usu int not null primary key auto_increment,
usuario varchar(30),
contra varchar(30)
);
/*drop table usuarios;*/
insert into usuarios(usuario,contra) values ("usuario1","123");

create table bodega(
id_bodega int not null primary key auto_increment,
Nombre varchar(30),
Estatus boolean
);
select * from bodega;
insert into bodega (Nombre, Estatus) values ("Zona 11",1);
insert into bodega (Nombre, Estatus) values ("Miraflores",2);
insert into bodega (Nombre, Estatus) values ("Calle 6",true);

create table productos (
id_producto int not null primary key auto_increment,
Descripsion varchar(30),
cantidad int
);
select * from productos;
insert into productos (Descripsion, cantidad) values ("Escobetas 22 plg", 10);
insert into productos (Descripsion, cantidad) values ("Abono 10kg", 5);
insert into productos (Descripsion, cantidad) values ("Sombreros Paja", 3);

create table orden_compra (
id_oc int not null primary key auto_increment,
id_bodega int not null,
id_producto int not null,
cantidad int,
costo int,
estatus boolean
);
select * from orden_compra;
/*drop table orden_compra;*/
ALTER TABLE orden_compra ADD foreign key(id_bodega) REFERENCES bodega(id_bodega);
ALTER TABLE orden_compra ADD foreign key(id_producto) REFERENCES productos(id_producto);

create table proveedores ( 
Nit int not null primary key,
Nombre varchar(30),
direccion varchar(50)
);
insert into proveedores (Nit,Nombre, direccion) values (107839296,"Ferretero","6ta avenida D zona 11");
insert into proveedores (Nit,Nombre, direccion) values (107760,"Nivia","edificio urbana");
insert into proveedores (Nit,Nombre, direccion) values (1234578,"Jorge Roca","Colonia fuentes 2 sancris");
drop table proveedores;

create table compra (
id_compra int not null primary key auto_increment,
id_oc int not null,
Nit_proveedor int not null,
fecha_compra varchar(30),
total_factura int,
dias_credito int
);
/*drop table compra;*/
ALTER TABLE compra ADD foreign key(id_oc) REFERENCES orden_compra(id_oc);
ALTER TABLE compra ADD foreign key(Nit_proveedor) REFERENCES proveedores(Nit);

drop procedure calculocomp;
DELIMITER //
CREATE PROCEDURE calculocomp (in coc int, in nitp int, in fecha varchar(30), in diasc int)
BEGIN
DECLARE cost int;
DECLARE cant int;
DECLARE TotalFact int;

SELECT cantidad INTO cant FROM orden_compra WHERE orden_compra.id_oc = coc;
SELECT costo INTO cost FROM orden_compra WHERE orden_compra.id_oc = coc;

SET TotalFact = cant * cost;

insert into compra (id_oc, Nit_proveedor, fecha_compra,total_factura, dias_credito) values (coc, nitp, fecha, TotalFact, diasc);
END;//
/*call calculocomp(1,107839296,"1-1-2022",30);*/
select * from compra;





create table cuenta_proveedores (
id_cuenta int not null primary key auto_increment,
Nit_proveedor int not null,
credito_acumulado int
);
/*drop table cuenta_proveedores;*/
ALTER TABLE cuenta_proveedores ADD foreign key(Nit_proveedor) REFERENCES proveedores(Nit);









