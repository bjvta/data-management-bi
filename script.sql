-- Creación de tablas para la base de datos de TURYBUS

-- Tabla de conductores
CREATE TABLE Conductor (
    DNI VARCHAR(10) PRIMARY KEY,
    ApellidosNombre NVARCHAR(100),
    Telefono NVARCHAR(15),
    Direccion NVARCHAR(200)
);

-- Tabla de autobuses
CREATE TABLE Autobus (
    Matricula VARCHAR(10) PRIMARY KEY,
    Modelo NVARCHAR(50),
    Fabricante NVARCHAR(50),
    NumeroPlazas INT,
    CaracteristicasBasicas NVARCHAR(500)
);

-- Tabla de rutas
CREATE TABLE Ruta (
    RutaID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100),
    Importe DECIMAL(10,2),
    Duracion TIME
);

-- Tabla de lugares (relevantes en cada ruta)
CREATE TABLE Lugar (
    LugarID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100),
    Actividad NVARCHAR(50) NULL
);

-- Relación Ruta-Lugar
CREATE TABLE Ruta_Lugar (
    RutaID INT FOREIGN KEY REFERENCES Ruta(RutaID),
    LugarID INT FOREIGN KEY REFERENCES Lugar(LugarID),
    HoraPrevistaLlegada TIME,
    TiempoParada INT NULL,
    PRIMARY KEY (RutaID, LugarID)
);

-- Tabla de pasajeros
CREATE TABLE Pasajero (
    DNI VARCHAR(10) PRIMARY KEY,
    ApellidosNombre NVARCHAR(100),
    Telefono NVARCHAR(15)
);

-- Tabla de servicios diarios
CREATE TABLE ServicioDiario (
    ServicioID INT PRIMARY KEY IDENTITY(1,1),
    RutaID INT FOREIGN KEY REFERENCES Ruta(RutaID),
    HoraSalida TIME,
    DiasProgramados NVARCHAR(50)
);

-- Relación Servicio-Conductor-Autobús
CREATE TABLE AsignacionServicio (
    ServicioID INT FOREIGN KEY REFERENCES ServicioDiario(ServicioID),
    DNI_Conductor VARCHAR(10) FOREIGN KEY REFERENCES Conductor(DNI),
    MatriculaAutobus VARCHAR(10) FOREIGN KEY REFERENCES Autobus(Matricula),
    PRIMARY KEY (ServicioID, DNI_Conductor, MatriculaAutobus)
);

-- Tabla de billetes (ticket de viaje para los pasajeros)
CREATE TABLE Billete (
    BilleteID INT PRIMARY KEY IDENTITY(1,1),
    DNI_Pasajero VARCHAR(10) FOREIGN KEY REFERENCES Pasajero(DNI),
    ServicioID INT FOREIGN KEY REFERENCES ServicioDiario(ServicioID),
    Fecha DATE,
    HoraLlegadaPrevista TIME
);

-- Tabla de revisiones de los autobuses
CREATE TABLE Revision (
    RevisionID INT PRIMARY KEY IDENTITY(1,1),
    MatriculaAutobus VARCHAR(10) FOREIGN KEY REFERENCES Autobus(Matricula),
    FechaRevision DATE,
    Diagnostico NVARCHAR(500)
);

-- Tabla de reparaciones (asociada a una revisión)
CREATE TABLE Reparacion (
    ReparacionID INT PRIMARY KEY IDENTITY(1,1),
    RevisionID INT FOREIGN KEY REFERENCES Revision(RevisionID),
    CodigoReparacion NVARCHAR(50),
    TiempoEmpleado INT,
    Comentario NVARCHAR(500) NULL
);

-- Tabla para registrar horas de viaje por pasajero
CREATE TABLE HorasViaje (
    DNI_Pasajero VARCHAR(10) FOREIGN KEY REFERENCES Pasajero(DNI),
    HorasTotales INT,
    PRIMARY KEY (DNI_Pasajero)
);