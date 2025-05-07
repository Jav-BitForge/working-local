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
	idUniversidad INT NOT NULL,
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
	ingresosMensuales DOUBLE PRECISION NULL
);

CREATE TABLE CalificacionesColegio(
	id SERIAL PRIMARY KEY,
	matematicas INT NULL,
	espaniol INT NULL,
	ingles INT NULL,
	biologia INT NULL,
	quimica INT NULL,
	fisica INT NULL
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

INSERT INTO CuentaUsuario (authid, tipoUsuario, nombre, numeroDocumento, tipoDocumento, correo, telefono, contrasenia, premium, fechaRegistro)
VALUES 
('auth0|680dbfa3da3f54766b83bcd6', 'estudiante','jaime9', '123456789 ', 'CC', 'jaime9@gmail.com', '3001234567', 'Password123', TRUE, '2025-04-28'),
('auth0|680e669494530a56bc197af7', 'estudiante','samuel', '87654321', 'CC', 'samuel@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
('auth0|680e70289a27e1e3d399588e', 'estudiante','samuel1', '11223344', 'CC', 'samuel1@gmail.com', '3102233445', 'Password123', FALSE, '2025-04-28'),
('auth0|680e7481bff427a0814d0564', 'estudiante','samuel2', '87654321', 'CC', 'samuel2@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
('auth0|680e7a469e39bdbc833efb1e', 'estudiante','samuel3', '87654321', 'CC', 'samuel3@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
('auth0|680e96a2f1f0f46efd20ce7e', 'estudiante','Juan', '87654321', 'CC', 'davidb@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
('auth0|680ecbb690b260cd6ffcad8f', 'estudiante','samuel4', '87654321', 'CC', 'samuel4@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28'),
('auth0|680eccd088fc9ad52a5d7382', 'estudiante','Juan', '87654321', 'CC', 'davidb1@gmail.com', '3007654321', 'Password123', FALSE, '2025-04-28');

INSERT INTO CuentaUsuario (authid, tipoUsuario, nombre, numeroDocumento, tipoDocumento, correo, telefono, contrasenia, premium, fechaRegistro)
VALUES
('auth0|680f97f758c4c195f73692dc', 'adminSoporte', 'adminsop', '00000000', 'N/A', 'adminsop@gmail.com', '0000000000', 'Aa1234567%', TRUE, '2025-04-28'),
('auth0|680f98918a361a21d8336648', 'adminMarketing', 'adminmark', '00000000', 'N/A', 'adminmark@gmail.com', '0000000000', 'Aa1234567%', TRUE, '2025-04-28'),
('auth0|680f98dd1b5395aff7b81130', 'adminGeneral', 'adming', '00000000', 'N/A', 'adming@gmail.com', '0000000000', 'Aa1234567%', TRUE, '2025-04-28');

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