CREATE TABLE Ubicacion(
	id SERIAL PRIMARY KEY,
	ciudad VARCHAR(255) NOT NULL,
	pais VARCHAR(255) NOT NULL
);

CREATE TABLE Universidad(
	id SERIAL PRIMARY KEY,
	idUbicacion INT NOT NULL,
	FOREIGN KEY (idUbicacion) REFERENCES Ubicacion(id) ON DELETE CASCADE,
	nombre VARCHAR(255) NOT NULL,
	ranking  INTEGER NOT NULL
);

CREATE TABLE ProgramaAcademico(
	id SERIAL PRIMARY KEY,
	idUniversidad INT NOT NULL,
	FOREIGN KEY (idUniversidad) REFERENCES Universidad(id) ON DELETE CASCADE,
	nombre VARCHAR(255) NOT NULL,
	costo DOUBLE PRECISION NOT NULL,
	descripcion VARCHAR(1000) NOT NULL
);

CREATE TABLE Carrera(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL, 
	descripcion VARCHAR(1000) NOT NULL,
	salarioPromedio DOUBLE PRECISION NOT NULL,
	salarioInicial DOUBLE PRECISION NOT NULL,
	tasaEmpleabilidad FLOAT NOT NULL,
	tasaDesempleo FLOAT NOT NULL,
	crecimientoMercado INTEGER NOT NULL
);

CREATE TABLE ProgramaAcademicoCarrera(
	idPrograma INT NOT NULL,
	idCarrera INT NOT NULL,
	PRIMARY KEY (idPrograma, idCarrera),
	FOREIGN KEY (idPrograma) REFERENCES ProgramaAcademico(id),
	FOREIGN KEY (idCarrera) REFERENCES Carrera(id)
);

CREATE TABLE AreaConocimiento(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL, 
	descripcion VARCHAR(1000) NOT NULL
);

CREATE TABLE AreaConocimientoCarrera(
	idAreaConocimiento INT NOT NULL,
	idCarrera INT NOT NULL,
	PRIMARY KEY (idAreaConocimiento, idCarrera),
	FOREIGN KEY (idAreaConocimiento) REFERENCES AreaConocimiento(id),
	FOREIGN KEY (idCarrera) REFERENCES Carrera(id)
);

CREATE TABLE AreaOcupacion(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL, 
	descripcion VARCHAR(1000) NOT NULL
);

CREATE TABLE AreaOcupacionCarrera(
	idAreaOcupacion INT NOT NULL,
	idCarrera INT NOT NULL,
	PRIMARY KEY (idAreaOcupacion, idCarrera),
	FOREIGN KEY (idAreaOcupacion) REFERENCES AreaOcupacion(id),
	FOREIGN KEY (idCarrera) REFERENCES Carrera(id)
);

CREATE TABLE PagoUsuario(
	id INTEGER PRIMARY KEY
);

CREATE TABLE cuentausuario(
	id SERIAL PRIMARY KEY,
	idCuentaPrincipal INT NULL,
	FOREIGN KEY (idCuentaPrincipal) REFERENCES PagoUsuario(id),
	tipoUsuario VARCHAR(255) NOT NULL,
	authid VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	numeroDocumento VARCHAR(255) NOT NULL,
	tipoDocumento VARCHAR(255) NOT NULL,
	correo VARCHAR(255) NOT NULL,
	telefono VARCHAR(255) NOT NULL,
	contrasenia VARCHAR(255) NOT NULL,
	premium BOOLEAN NOT NULL,
	fechaRegistro DATE NOT NULL
);

CREATE TABLE Prueba(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL
);

CREATE TABLE Pregunta(
	id SERIAL PRIMARY KEY,
	idPrueba INT NOT NULL,
	FOREIGN KEY (idPrueba) REFERENCES Prueba(id) ON DELETE CASCADE,
	contenido VARCHAR(2000) NOT NULL,
	puntaje INT NOT NULL
);

CREATE TABLE Respuesta(
	id SERIAL PRIMARY KEY,
	idPregunta INT NOT NULL,
	FOREIGN KEY (idPregunta) REFERENCES Pregunta(id) ON DELETE CASCADE,
	contenido VARCHAR(2000) NOT NULL
);

CREATE TABLE ResultadoPrueba(
	id SERIAL PRIMARY KEY,
	idEstudiante INT NOT NULL,
	FOREIGN KEY (idEstudiante) REFERENCES CuentaUsuario(id) ON DELETE CASCADE,
	idPrueba INT NOT NULL,
	FOREIGN KEY (idPrueba) REFERENCES Prueba(id) ON DELETE CASCADE,
	comentarioChatBot VARCHAR(5000) NULL,
	fecha DATE NULL,
	puntuacion DOUBLE PRECISION NULL
);

CREATE TABLE CarreraResultadoPrueba(
	idCarrera INT NOT NULL,
	idResultado INT NOT NULL,
	PRIMARY KEY (idResultado, idCarrera),
	FOREIGN KEY (idCarrera) REFERENCES Carrera(id),
	FOREIGN KEY (idResultado) REFERENCES ResultadoPrueba(id)
);

CREATE TABLE cuentauniversidad(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	nit VARCHAR(255) NOT NULL,
	correo VARCHAR(255) NOT NULL,
	premium BOOLEAN NULL,
	contrasenia VARCHAR(255) NOT NULL,
	authid VARCHAR(255) NOT NULL,
	fechaRegistro DATE NOT NULL
);

CREATE TABLE cuentaagente(
	id SERIAL PRIMARY KEY,
	idUniversidad INT NULL,
	FOREIGN KEY (idUniversidad) REFERENCES CuentaUniversidad(id) ON DELETE CASCADE,
	nombre VARCHAR(255) NOT NULL,
	tipoDocumento VARCHAR(255),
	numeroDocumento VARCHAR(255),
	correo VARCHAR(255) NOT NULL,
	contrasenia VARCHAR(255) NOT NULL,
	premium BOOLEAN NULL,
	authid VARCHAR(255) NOT NULL,
	fechaRegistro DATE NOT NULL
);

CREATE TABLE TipoPlanSuscripcion(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	precio DOUBLE PRECISION NOT NULL,
	cantCuentas INT NOT NULL,
	cantConsultas INT NOT NULL
);

CREATE TABLE PlanSuscripcion(
	id SERIAL PRIMARY KEY,
	idUniversidad INT NOT NULL,
	FOREIGN KEY (idUniversidad) REFERENCES CuentaUniversidad(id) ON DELETE CASCADE,
	idTipoPlanSuscripcion INT NOT NULL,
	FOREIGN KEY (idTipoPlanSuscripcion) REFERENCES TipoPlanSuscripcion(id) ON DELETE CASCADE,
	fechaInicio DATE NOT NULL,
	fechaFin DATE NOT NULL,
	fechaFacturacion DATE NOT NULL
);

CREATE TABLE TipoPlanUnico(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	precio DOUBLE PRECISION NOT NULL,
	cantCuentas INT NOT NULL
);

CREATE TABLE PlanUnico(
	id SERIAL PRIMARY KEY,
	idTipoPlanUnico INT NOT NULL,
	FOREIGN KEY (idTipoPlanUnico) REFERENCES TipoPlanUnico(id) ON DELETE CASCADE,
	idUsuario INT NOT NULL,
	FOREIGN KEY (idUsuario) REFERENCES PagoUsuario(id) ON DELETE CASCADE,
	fechaFacturacion DATE NOT NULL
);

CREATE TABLE TipoPago(
	id SERIAL PRIMARY KEY,
	numero INT NOT NULL,
	fechaExpiracion DATE NOT NULL,
	csv VARCHAR(3) NULL
);

CREATE TABLE Pago(
	id SERIAL PRIMARY KEY,
	idPlanSuscripcion INT,
	FOREIGN KEY (idPlanSuscripcion) REFERENCES PlanSuscripcion(id) ON DELETE CASCADE,
	idPlanUnico INT,
	FOREIGN KEY (idPlanUnico) REFERENCES PlanUnico(id) ON DELETE CASCADE,
	idTipoPago INT NOT NULL,
	FOREIGN KEY (idTipoPago) REFERENCES TipoPago(id) ON DELETE CASCADE,
	fechaPago DATE NOT NULL,
	monto DOUBLE PRECISION NOT NULL
);

CREATE TABLE ResultadoIcfes(
	id SERIAL PRIMARY KEY,
	puntajeGlobal INT NULL,
	puntajeIngles INT NULL,
	puntajeSocialesyCiudadanas INT NULL,
	puntajeCienciasNaturales INT NULL,
	puntajeLecturaCritica INT NULL
);

CREATE TABLE InformacionGustos(
	id SERIAL PRIMARY KEY,
	motivacionCentral VARCHAR(255) NULL
);

CREATE TABLE InteresProfesional(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NULL
);

CREATE TABLE InformacionGustosInteresProfesional(
	idInformacionGustos INT NOT NULL,
	FOREIGN KEY (idInformacionGustos) REFERENCES InformacionGustos(id),
	idInteresProfesional INT NOT NULL,
	FOREIGN KEY (idInteresProfesional) REFERENCES InteresProfesional(id)
);

CREATE TABLE InformacionDemografica(
	id SERIAL PRIMARY KEY,
	edad INT NULL,
	genero VARCHAR(255) NULL,
	ciudadResidencia VARCHAR(255) NULL,
	paisResidencia VARCHAR(255) NULL,
	ingresosMensuales DOUBLE PRECISION NULL,
	puedeDesplazarse BOOLEAN NULL,
	estrato VARCHAR(255) NULL
);

CREATE TABLE CalificacionesColegio(
	id SERIAL PRIMARY KEY,
	matematicas NUMERIC(5,2) NULL,
	espaniol NUMERIC(5,2) NULL,
	ingles NUMERIC(5,2) NULL,
	biologia NUMERIC(5,2) NULL,
	quimica NUMERIC(5,2) NULL,
	fisica NUMERIC(5,2) NULL
);

CREATE TABLE InformacionFinanciera(
	id SERIAL PRIMARY KEY,
	presupuesto DOUBLE PRECISION NULL,
	fuenteFinanciacion VARCHAR(255) NULL,
	disposicionPrestamo VARCHAR(255) NULL,
	modalidadEstudio VARCHAR(255) NULL
);

CREATE TABLE DatosPersonales(
	idEstudiante INT NOT NULL,
	PRIMARY KEY (idEstudiante),
	FOREIGN KEY (idEstudiante) REFERENCES CuentaUsuario(id) ON DELETE CASCADE,
	idResultadosIcfes INT NULL,
	FOREIGN KEY (idResultadosIcfes) REFERENCES ResultadoIcfes(id) ON DELETE CASCADE,
	idInformacionGustos INT NULL,
	FOREIGN KEY (idInformacionGustos) REFERENCES InformacionGustos(id) ON DELETE CASCADE,
	idInformacionDemografica INT NULL,
	FOREIGN KEY (idInformacionDemografica) REFERENCES InformacionDemografica(id) ON DELETE CASCADE,
	idCalificacionesColegio INT NULL,
	FOREIGN KEY (idCalificacionesColegio) REFERENCES CalificacionesColegio(id) ON DELETE CASCADE,
	idInformacionFinanciera INT NULL,
	FOREIGN KEY (idInformacionFinanciera) REFERENCES InformacionFinanciera(id) ON DELETE CASCADE
);

INSERT INTO CuentaUsuario (idCuentaPrincipal, authid, tipoUsuario, nombre, numeroDocumento, tipoDocumento, correo, telefono, contrasenia, premium, fechaRegistro)
VALUES 
(NULL, 'auth0|680dbfa3da3f54766b83bcd6', 'estudiante','jaime9', '123456789 ', 'CC', 'jaime9@gmail.com', '3001234567', 'Password123', FALSE, '2025-04-28'),
(NULL, 'auth0|680e669494530a56bc197af7', 'estudiante','samuel', '87654321', 'CC', 'samuel@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
(NULL, 'auth0|680e70289a27e1e3d399588e', 'estudiante','samuel1', '11223344', 'CC', 'samuel1@gmail.com', '3102233445', 'Password123', FALSE, '2025-04-28'),
(NULL, 'auth0|680e7481bff427a0814d0564', 'estudiante','samuel2', '87654321', 'CC', 'samuel2@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
(NULL, 'auth0|680e7a469e39bdbc833efb1e', 'estudiante','samuel3', '87654321', 'CC', 'samuel3@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
(NULL, 'auth0|680e96a2f1f0f46efd20ce7e', 'estudiante','Juan', '87654321', 'CC', 'davidb@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
(NULL, 'auth0|680ecbb690b260cd6ffcad8f', 'estudiante','samuel4', '87654321', 'CC', 'samuel4@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
(NULL, 'auth0|680eccd088fc9ad52a5d7382', 'estudiante','Juan', '87654321', 'CC', 'davidb1@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28');

INSERT INTO TipoPlanSuscripcion (nombre, precio, cantCuentas, cantConsultas)
VALUES 
  ('Básico', 100000, 1, 50),
  ('Premium', 150000, 3, 100),
  ('Premium+', 200000, 5, 200);

INSERT INTO TipoPlanUnico (nombre, precio, cantCuentas)
VALUES 
  ('Personal', 80000, 1),
  ('Familiar', 140000, 4),
  ('Institucional', 250000, 80);

-- ResultadoIcfes
INSERT INTO ResultadoIcfes (id, puntajeGlobal, puntajeIngles, puntajeSocialesyCiudadanas, puntajeCienciasNaturales, puntajeLecturaCritica)
VALUES 
(201, 320, 65, 60, 58, 68),
(202, 280, 50, 52, 49, 55),
(203, 400, 85, 82, 87, 90),
(204, 360, 70, 75, 73, 72),
(205, 300, 60, 59, 61, 63),
(206, 270, 45, 48, 46, 50),
(207, 390, 80, 78, 82, 85),
(208, 310, 66, 64, 63, 65),
(209, 250, 40, 43, 41, 45),
(210, 410, 90, 88, 89, 92);

-- InformacionDemografica
INSERT INTO InformacionDemografica (id, edad, genero, ciudadResidencia, paisResidencia, ingresosMensuales)
VALUES 
(201, 18, 'Femenino', 'Bogotá', 'Colombia', 2800000),
(202, 19, 'Masculino', 'Cali', 'Colombia', 1200000),
(203, 20, 'Femenino', 'Medellín', 'Colombia', 4000000),
(204, 21, 'Masculino', 'Barranquilla', 'Colombia', 3500000),
(205, 18, 'Femenino', 'Pereira', 'Colombia', 2000000),
(206, 22, 'Masculino', 'Ibagué', 'Colombia', 1000000),
(207, 19, 'Femenino', 'Manizales', 'Colombia', 4500000),
(208, 20, 'Masculino', 'Cartagena', 'Colombia', 3000000),
(209, 21, 'Femenino', 'Neiva', 'Colombia', 900000),
(210, 22, 'Masculino', 'Tunja', 'Colombia', 5000000);

-- CalificacionesColegio
INSERT INTO CalificacionesColegio (id, matematicas, espaniol, ingles, biologia, quimica, fisica)
VALUES 
(201, 4, 4, 3, 4, 4, 3),
(202, 3, 3, 4, 3, 3, 3),
(203, 5, 5, 5, 5, 5, 5),
(204, 4, 4, 4, 4, 4, 4),
(205, 3, 4, 3, 3, 4, 4),
(206, 2, 3, 2, 2, 3, 3),
(207, 5, 5, 5, 5, 4, 5),
(208, 4, 4, 4, 4, 4, 4),
(209, 2, 2, 2, 3, 2, 2),
(210, 5, 5, 5, 5, 5, 5);

-- InformacionFinanciera
INSERT INTO InformacionFinanciera (id, presupuesto, fuenteFinanciacion, disposicionPrestamo, modalidadEstudio)
VALUES 
(201, 3000000, 'Padres,Becas', 'Sí', 'Presencial'),
(202, 1500000, 'Trabajo propio', 'No', 'Virtual'),
(203, 5000000, 'Crédito,Becas', 'Sí', 'Presencial'),
(204, 3500000, 'Padres', 'No', 'Presencial'),
(205, 2000000, 'Trabajo propio', 'Sí', 'Virtual'),
(206, 1000000, 'Crédito', 'Sí', 'Presencial'),
(207, 4500000, 'Becas', 'No', 'Presencial'),
(208, 3200000, 'Padres', 'Sí', 'Virtual'),
(209, 900000, 'Trabajo propio', 'No', 'Presencial'),
(210, 6000000, 'Padres,Crédito', 'Sí', 'Presencial');

-- CuentaUsuario
INSERT INTO cuentausuario (id, authid, tipoUsuario, nombre, numeroDocumento, tipoDocumento, correo, telefono, contrasenia, premium, fechaRegistro)
VALUES 
(201, 'auth0|u201', 'estudiante', 'Laura Ruiz', '1001', 'CC', 'laura.ruiz@gmail.com', '3000001001', 'pass', TRUE, CURRENT_DATE),
(202, 'auth0|u202', 'estudiante', 'Carlos Díaz', '1002', 'CC', 'carlos.diaz@gmail.com', '3000001002', 'pass', TRUE, CURRENT_DATE),
(203, 'auth0|u203', 'estudiante', 'Ana López', '1003', 'CC', 'ana.lopez@gmail.com', '3000001003', 'pass', TRUE, CURRENT_DATE),
(204, 'auth0|u204', 'estudiante', 'Pedro Gómez', '1004', 'CC', 'pedro.gomez@gmail.com', '3000001004', 'pass', FALSE, CURRENT_DATE),
(205, 'auth0|u205', 'estudiante', 'Valentina Mora', '1005', 'CC', 'valentina.mora@gmail.com', '3000001005', 'pass', FALSE, CURRENT_DATE),
(206, 'auth0|u206', 'estudiante', 'David Acosta', '1006', 'CC', 'david.acosta@gmail.com', '3000001006', 'pass', FALSE, CURRENT_DATE),
(207, 'auth0|u207', 'estudiante', 'Mónica Sánchez', '1007', 'CC', 'monica.sanchez@gmail.com', '3000001007', 'pass', FALSE, CURRENT_DATE),
(208, 'auth0|u208', 'estudiante', 'Esteban Vargas', '1008', 'CC', 'esteban.vargas@gmail.com', '3000001008', 'pass', FALSE, CURRENT_DATE),
(209, 'auth0|u209', 'estudiante', 'Claudia Romero', '1009', 'CC', 'claudia.romero@gmail.com', '3000001009', 'pass', FALSE, CURRENT_DATE),
(210, 'auth0|u210', 'estudiante', 'Andrés Torres', '1010', 'CC', 'andres.torres@gmail.com', '3000001010', 'pass', FALSE, CURRENT_DATE);

-- DatosPersonales
INSERT INTO DatosPersonales (idEstudiante, idResultadosIcfes, idInformacionGustos, idInformacionDemografica, idCalificacionesColegio, idInformacionFinanciera)
VALUES 
(201, 201, NULL, 201, 201, 201),
(202, 202, NULL, 202, 202, 202),
(203, 203, NULL, 203, 203, 203),
(204, 204, NULL, 204, 204, 204),
(205, 205, NULL, 205, 205, 205),
(206, 206, NULL, 206, 206, 206),
(207, 207, NULL, 207, 207, 207),
(208, 208, NULL, 208, 208, 208),
(209, 209, NULL, 209, 209, 209),
(210, 210, NULL, 210, 210, 210);

INSERT INTO cuentausuario (idcuentaprincipal, tipousuario, authid, nombre, numerodocumento, tipodocumento, correo, telefono, contrasenia, premium, fecharegistro) VALUES
(NULL, 'admin_marketing', 'auth0|68196f7e63d3e1aaf34baeb2', 'Luis', '1000002', 'CC', 'adminmarketing@gmail.com', '3124563765', 'Aa1234567%', false, '2025-05-06'),
(NULL, 'admin_financiero', 'auth0|68197029019e862393821ffb', 'Julieta', '1000003', 'CC', 'adminfinanciero@gmail.com', '3195524765', 'Aa1234567%', false, '2025-05-06'),
(NULL, 'tutor', 'auth0|681970db533e77551fedb2cb', 'Fabian Suleta', '1100000', 'CC', 'fabian12@gmail.com', '3195524765', 'Password123!', false, '2025-05-06'),
(NULL, 'tutor', 'auth0|6819714de9675da79f8ebd9f', 'Rodolfo Neiza', '1200000', 'CC', 'rodolfo@gmail.com', '3195524765', 'Bb1234567%', false, '2025-05-06'),
(NULL, 'tutor', 'auth0|6819726e6e369b7c2f351235', 'Andrea Perez', '1300000', 'CC', 'andrea@gmail.com', '3195524765', 'Bb1234567%', true, '2025-05-06'),
(NULL, 'tutor', 'auth0|6819731aa209515eca92d9c6', 'Rachel Castro', '1400000', 'CC', 'rachel@gmail.com', '3195524765', 'Bb1234567%', true, '2025-05-06'),
(NULL, 'tutor', 'auth0|68197553fdcd91ba478f6cbd', 'Tony Gonzalez', '110100', 'CC', 'tony@gmail.com', '3195524765', 'Cc1234567%', false, '2025-05-06'),
(NULL, 'tutor', 'auth0|681975d1a673eaa99f060567', 'Toni Gonzalez', '110100', 'CC', 'toni@gmail.com', '3195524765', 'Cc1234567%', false, '2025-05-06'),
(NULL, 'admin_financiero', 'auth0|681975f7a209515eca92db75', 'Antonio Gonzalez', '110100', 'CC', 'antonio@gmail.com', '3195524765', 'Cc1234567%', false, '2025-05-06'),
(NULL, 'admin', 'auth0|68198978190169e0099e2f43', 'Sergio Perez', '110200', 'CC', 'sergio@gmail.com', '3195524765', 'Cc1234567%', false, '2025-05-06'),
(NULL, 'admin_soporte', 'auth0|68198a27fdcd91ba478f7890', 'Sergio Cortez', '110300', 'CC', 'sofia@gmail.com', '3195524765', 'Cc1234567%', false, '2025-05-06'),
(NULL, 'admin', 'auth0|68196ee7decce84ad47f6666', 'Andres', '1000000', 'CC', 'admingeneral@gmail.com', '3124563765', 'Aa1234567%', false, '2025-05-06'),
(NULL, 'admin_soporte', 'auth0|68196f1e6e369b7c2f35105c', 'Adriana', '1000001', 'CC', 'adminsoporte@gmail.com', '3124563765', 'Aa1234567%', false, '2025-05-06'),
(NULL, 'estudiante', 'auth0|68198bf68069a1d92430184d', 'Karen Cortez', '110400', 'CC', 'karen@gmail.com', '321435421', 'Cc1234567%', true, '2025-05-06'),
(NULL, 'estudiante', 'auth0|68198c4c190169e0099e30d2', 'Diego Gomez', '110500', 'CC', 'diegog@gmail.com', '324654121', 'Cc1234567%', true, '2025-05-06');

INSERT INTO cuentaagente (iduniversidad, authid, nombre, numerodocumento, tipodocumento, correo, contrasenia, premium, fecharegistro) VALUES
(NULL, 'auth0|6819894910ae615fc72f0a68', 'Antonio Gonzalez', '110100', 'CC', 'antonio@gmail.com', 'Cc1234567%', false, '2025-05-06'),
(NULL, 'auth0|68198978190169e0099e2f43', 'Sergio Perez', '110200', 'CC', 'sergio@gmail.com', 'Cc1234567%', false, '2025-05-06'),
(NULL, 'auth0|68198a27fdcd91ba478f7890', 'Sergio Cortez', '110300', 'CC', 'sofia@gmail.com', 'Cc1234567%', true, '2025-05-06'),
(NULL, 'auth0|68198c4c190169e0099e30d2', 'Diego Gomez', '110500', 'CC', 'diegog@gmail.com', 'Cc1234567%', true, '2025-05-06');