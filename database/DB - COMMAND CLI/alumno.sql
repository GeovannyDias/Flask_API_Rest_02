--Creacion de la base de datos
/*Comment*/
create database Semana17
go
use Semana17
go
--tabla alumno
CREATE TABLE Alumno
(
	idAlumno INT IDENTITY(1,1) NOT NULL, /*IDENTITY(1,1) → incremento de uno en uno*/
	docAlumno varchar(15) NOT NULL,
	nomAlumno varchar(20) not null,
	fechaNacAlumno date,
	CONSTRAINT PK_Alumno primary key clustered(idAlumno) /*clustered → indice mostrar campos que seran clave primaria (id1,id2,id3)*/
)
/*GO → separa conjuntos de instrucciones → NO Comentar junto a la palabra "GO"*/
go 

-- tabla curso
create table Curso
(
	idCurso varchar(10) not null, /*id alfanumerico*/
	nombreCurso varchar(50) not null,
	descripcionCurso text,
	constraint PK_Curso primary key clustered(idCurso)
)
go
-- Tabla Asignatura
create table Asignatura
(
	codAsignatura varchar(10) not null,
	nomAsignatura varchar(50) not null,
	estado bit constraint DF_Asignatura_estado default(1),
	constraint PK_Asignatura primary key clustered(codAsignatura)
)
go

-- Tabla Matricula
create table Matricula
(
	numMatricula bigint identity(1,1) not null,
	idAlumno int not null,
	idCurso varchar(10) not null,
	codAsignatura varchar(10) not null,
	fechaMatricula datetime not null,
	estado bit constraint DF_Matricula_estado default(0),
	constraint PK_Matricula primary key clustered(numMatricula),
	constraint FK_Matricula_Alumno foreign key(idAlumno) references Alumno(idAlumno),
	constraint FK_Matricula_Curso foreign key(idCurso) references Curso(idCurso),
	constraint FK_Matricula_Asignatura foreign key(codAsignatura) references Asignatura(codAsignatura),
)
go

-- Tabla Especialidad
create table Especialidad
(
	idEspecialidad tinyint identity(1,1) not null,
	nomEspecialidad varchar(60) not null,
	descripcion text,
	constraint PK_Especialidad primary key clustered(idEspecialidad)
)
go

-- Tabla Profesor
create table Profesor
(
	idProfesor int identity(1,1) not null,
	nombre varchar(60) not null,
	docProfesor varchar(15) not null,
	telefono varchar(10) not null,
	idEspecialidad tinyint not null,
	constraint PK_Profesor primary key clustered(idProfesor),
	constraint FK_Profesor_Especialidad foreign key(idEspecialidad) references Especialidad(idEspecialidad),
)
go

/*AGREGAR PRIMARY KEY EN TABLA PROFESOR*/
/*
alter table Profesor
add constraint PK_Profesor primary key clustered(idProfesor)
go
*/

-- Cambio de la table asignatura
alter table Asignatura
add idProfesor int not null,
constraint FK_Asignatura_Profesor foreign key(idProfesor) references Profesor(idProfesor)
go


insert into Especialidad
(nomEspecialidad, descripcion) 
values
('Informática', 'Especilidad de análisis informáticos'),
('Redes', 'Especilidad de análisis informáticos'),
('Matemática', 'Especilidad de análisis informáticos')
go

select * from Especialidad;

/*constraint U_Alumno_docAlumno unique noncloustered(docAlumno)*/
/*
alter table Alumno
add constraint U_Alumno_docAlumno unique noncloustered(docAlumno)
*/

/* INSERTAR PROFESOR */
INSERT INTO Profesor(nombre, docProfesor, telefono, idEspecialidad)
values
('Geovanny', '1234567890', '0985489454', 1),
('Sofia', '1234567890', '0985489454', 2),
('Andres', '1234567890', '0985489454', 3);
go

SELECT * FROM Profesor;

/* INSERTAR ASIGNATURA */
INSERT INTO Asignatura(codAsignatura, nomAsignatura, estado, idProfesor)
values
('POO-001','Programacion Orientada a Objetos', 1, 1),
('CLE-002', 'Cableado Estructurado', 1, 2),
('CAL-003', 'Calculo Diferencial', 1, 3);
go

SELECT * FROM Asignatura;

/* INSERTAR CURSO */
INSERT INTO Curso(idCurso, nombreCurso, descripcionCurso)
values
('T-001', 'TEC-001', 'Curso técnico uno'),
('T-002', 'TEC-002', 'Curso técnico dos'),
('T-003', 'TEC-003', 'Curso técnico tres');
go

SELECT * FROM Curso;

/* INSERTAR ALUMNO */
INSERT INTO Alumno(docAlumno, nomAlumno, fechaNacAlumno)
values
('1234567891', 'Jessenia', '1990-12-02'),
('1234567892', 'Fernando', '1991-02-25'),
('1234567893', 'Leonardo', '1992-07-10');
go

SELECT * FROM Alumno;

/* INSERTAR MATRÍCULA */
INSERT INTO Matricula(idAlumno, idCurso, codAsignatura, fechaMatricula, estado)
values
(3, 'T-001', 'POO-001', '2021-04-02 17:00:25', 1),
(4, 'T-002', 'CLE-002', '2021-04-10 18:30:54', 0),
(5, 'T-003', 'CAL-003', '2021-04-22 13:15:02', 1);
go

SELECT * FROM Matricula;

