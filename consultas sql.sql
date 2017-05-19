Crear tablas:

create table `tarea` (
`tarea_id` int(11) not null auto_increment,
`nombre` varchar (50) not null,
`inicio` datetime not null,
`estimacion` varchar (10) default null,
`consumo` int(11) default null,
`fin` varchar (10) not null,
`estado` varchar (15) not null,
PRIMARY KEY (`tarea_id`)
)ENGINE= INNODB DEFAULT charset=latin1;

CREATE TABLE `usuario` (
 `usuario_id` int(10) NOT null AUTO_INCREMENT,
 `nombre` varchar(50) not null,
 `apellido` varchar(50) NOT null,
PRIMARY KEY (`usuario_id`)
)ENGINE= INNODB DEFAULT charset=latin1;

CREATE TABLE `comentario`(
  `comentario_id` int(11) NOT NULL AUTO_INCREMENT,
  `detalle` varchar(50) NOT NULL,
  `fecha_realizado` datetime NOT NULL,
  `tarea_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
 PRIMARY KEY (`comentario_id`),
  FOREIGN KEY (`tarea_id`) 
     REFERENCES `tarea` (`tarea_id`)
      on delete cascade,
FOREIGN KEY (`usuario_id`) 
     REFERENCES `usuario`(`usuario_id`) 
     on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `checklist` (
  `checklist_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `tarea_id` int(11) NOT NULL,
   PRIMARY KEY (`CHECKLIST_ID`),
     FOREIGN KEY (`tarea_id`) REFERENCES `tarea`(`tarea_id`)
    ON DELETE CASCADE 
)ENGINE=InnoDB DEFAULT CHARSET=latin1;
....................................................................................................
Insertar datos:

INSERT INTO `usuario`(`nombre`,`apellido`)
    VALUES('maria','moralez');
INSERT INTO `usuario`(`nombre`,`apellido`)
    VALUES('martin','sanchez');
INSERT INTO `usuario`(`nombre`,`apellido`)
    VALUES('jose','roldan');
INSERT INTO `usuario`(`nombre`,`apellido`)
    VALUES('rosario','gonsalez');
INSERT INTO `usuario`(`nombre`,`apellido`)
    VALUES('juan','toro');
 INSERT INTO `usuario`(`nombre`,`apellido`)
    VALUES('sol','farias');

INSERT INTO `tarea` (`nombre`, `inicio`,
 `estimacion`, `consumo`, `fin`, `estado`) VALUES 
('Preparar desayuno', '2017-05-15 06:15:00', '1', '1', '2017-05-15 01:00:00', 'pendiente');
UPDATE `tarea` SET `inicio` = '2017-05-15 06:10:00',
 `estimacion` = '0.20', `consumo` = '0.15', `fin` = '2017-05-15 06:25:00' 
WHERE `tarea`.`tarea_id` = 1;

INSERT INTO `tarea` (`nombre`, `inicio`,
 `estimacion`, `consumo`, `fin`, `estado`) 
VALUES ('Ir a trabajar', '2017-06-21 06:30:00', '0.15', '0.10', '2017-06-21 06:40:00', 'en curso');

INSERT INTO `tarea` (`nombre`,
 `inicio`, `estimacion`, `consumo`, `fin`, `estado`)
 VALUES ('Preparar almuerzo', 
'2017-08-11 14:05:00', '1', '1', '2017-08-11 15:00:00', 'finalizada');

INSERT INTO `checklist`(`nombre`, `estado`, `tarea_id`) VALUES ('Calentar agua','Listo',1);
INSERT INTO `checklist`(`nombre`, `estado`, `tarea_id`) VALUES ('Tomar taza y poner cafe','Listo',2);
INSERT INTO `checklist`(`nombre`, `estado`, `tarea_id`) VALUES ('Verter el agua en la taza y revolver','pendiente',3);
INSERT INTO `checklist`(`nombre`, `estado`, `tarea_id`) VALUES ('Agregar leche','en curso',1);
INSERT INTO `checklist`(`nombre`, `estado`, `tarea_id`) VALUES ('Tomar cafe con leche con masitas','Listo',4);

INSERT INTO `comentario`(`detalle`, `fecha_realizado`, `tarea_id`, `usuario_id`) VALUES ('Que rico cafe','2017-02-14 00:00:00',1,1);
INSERT INTO `comentario`(`detalle`, `fecha_realizado`, `tarea_id`, `usuario_id`) VALUES ('Mañana se madruga','2017-09-08 06:30:00',1,1);
INSERT INTO `comentario`(`detalle`, `fecha_realizado`, `tarea_id`, `usuario_id`) VALUES ('Hay que ir a trabajar','2017-03-17 06:30:00',2,2);
INSERT INTO `comentario`(`detalle`, `fecha_realizado`, `tarea_id`, `usuario_id`) VALUES ('Se cursa','2017-04-10 18:00:00',3,3);
..............................................................................................................
Borrar tablas:

DROP TABLE `checklist`,
`comentario`,
`tarea`,
`usuario`;

..................................................................................................
1.	Contar la cantidad de tareas pendientes totales:

SELECT COUNT(estado) AS cantidad FROM tarea WHERE estado= 'pendiente'
.............................................................................................
2.	Contar la cantidad de tareas completadas totalmente.

SELECT COUNT(estado) AS cantidad FROM tarea WHERE estado= 'completada'
..............................................................................................................
3.	Retornar todos los comentarios del usuario U

SELECT   comentario.*, usuario.* 
FROM     comentario INNER JOIN usuario USING(usuario_id);


SELECT * FROM comentario WHERE usuario_id= '1';
...................................................................................................
4.	Contar la cantidad de checklist de la tarea T.

SELECT   checklist.*, tarea.* 
FROM     checklist INNER JOIN tarea USING(tarea_id);


SELECT COUNT(tarea_id) AS cantidad FROM checklist WHERE tarea_id= '3';
...................................................................................................
5.	Retornar todos los comentarios ordenados del usuario U

SELECT * FROM comentario WHERE usuario_id= '1' ORDER BY comentario_id ASC
................................................................................................
6.	Retornar todos los comentarios en forma invertida del usuario U.

SELECT * FROM comentario WHERE usuario_id= '1' ORDER BY comentario_id DESC
........................................................................................................
7.	Retornar todos los comentarios que hayan sido ingresados por el usuario Z.

SELECT * FROM comentario WHERE usuario_id= '2';
...................................................................................................
8.	Retornar todas las tareas del usuario Z

SELECT *
FROM tarea LEFT JOIN usuario ON tarea.tarea_id = usuario.usuario_id

SELECT * FROM tarea WHERE tarea_id= '2';
...................................................................................................
9.	Retornar la fecha del primer comentario.

SELECT * FROM comentario ORDER BY fecha_realizado ASC;


SELECT MIN(fecha_realizado) FROM comentario;
......................................................................................
10.	Retornar la fecha del primer comentario realizado en la tarea T.

SELECT   tarea.*, comentario.* 
FROM     tarea INNER JOIN comentario USING(tarea_id)ORDER BY fecha_realizado ASC;


SELECT MIN(fecha_realizado) FROM comentario WHERE tarea_id='1';
.......................................................................................
11.	Retornar la lista de tareas en las cuales el usuario U realizo un comentario.

SELECT *
FROM tarea INNER JOIN (usuario LEFT JOIN comentario ON usuario.usuario_id = comentario.comentario_id) ON tarea.tarea_id = usuario.usuario_id


SELECT tarea.*, comentario.* FROM tarea INNER JOIN comentario USING(tarea_id) WHERE usuario_id='1' 