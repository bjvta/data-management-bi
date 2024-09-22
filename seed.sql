-- Insertar datos de conductores
INSERT INTO Conductor (DNI, ApellidosNombre, Telefono, Direccion) VALUES
('12345678A', 'Juan Pérez', '600111222', 'Calle Falsa 123'),
('87654321B', 'María García', '600333444', 'Avenida Siempreviva 456'),
('11223344C', 'Carlos López', '600555666', 'Calle Larga 789');

-- Insertar datos de autobuses
INSERT INTO Autobus (Matricula, Modelo, Fabricante, NumeroPlazas, CaracteristicasBasicas) VALUES
('ABC123', 'Volvo B9', 'Volvo', 50, 'Autobús turístico de 50 plazas'),
('DEF456', 'Mercedes-Benz O500', 'Mercedes-Benz', 45, 'Autobús con aire acondicionado y WiFi'),
('GHI789', 'Scania K310', 'Scania', 55, 'Autobús con asientos reclinables');

-- Insertar datos de rutas
INSERT INTO Ruta (Nombre, Importe, Duracion) VALUES
('Ruta Playa', 25.00, '03:00:00'),
('Ruta Montaña', 35.00, '05:00:00'),
('Ruta Ciudad', 20.00, '02:30:00');

-- Insertar datos de lugares
INSERT INTO Lugar (Nombre, Actividad) VALUES
('Playa del Sol', 'Visita'), 
('Mirador del Monte', 'Comida'),
('Museo Histórico', NULL);

-- Insertar relación Ruta-Lugar
INSERT INTO Ruta_Lugar (RutaID, LugarID, HoraPrevistaLlegada, TiempoParada) VALUES
(1, 1, '10:00:00', 30),
(2, 2, '13:00:00', 60),
(3, 3, '11:30:00', 20);

-- Insertar datos de pasajeros
INSERT INTO Pasajero (DNI, ApellidosNombre, Telefono) VALUES
('12345678X', 'Ana Torres', '611111111'),
('87654321Y', 'Luis Morales', '622222222'),
('11223344Z', 'Sofía Fernández', '633333333');

-- Insertar datos de servicios diarios
INSERT INTO ServicioDiario (RutaID, HoraSalida, DiasProgramados) VALUES
(1, '09:00:00', 'Lunes a Viernes'),
(2, '12:00:00', 'Sábado y Domingo'),
(3, '10:00:00', 'Todos los días');

-- Insertar asignación de servicio (conductor y autobús)
INSERT INTO AsignacionServicio (ServicioID, DNI_Conductor, MatriculaAutobus) VALUES
(1, '12345678A', 'ABC123'),
(2, '87654321B', 'DEF456'),
(3, '11223344C', 'GHI789');

-- Insertar datos de billetes
INSERT INTO Billete (DNI_Pasajero, ServicioID, Fecha, HoraLlegadaPrevista) VALUES
('12345678X', 1, '2024-07-01', '12:00:00'),
('87654321Y', 2, '2024-07-02', '17:00:00'),
('11223344Z', 3, '2024-07-03', '12:30:00'),
('12345678X', 1, '2024-07-04', '12:00:00'),
('87654321Y', 2, '2024-07-05', '17:00:00');

-- Insertar datos de revisiones de autobuses
INSERT INTO Revision (MatriculaAutobus, FechaRevision, Diagnostico) VALUES
('ABC123', '2024-06-15', 'Revisión general sin incidencias'),
('DEF456', '2024-06-20', 'Cambio de neumáticos'),
('GHI789', '2024-06-25', 'Reparación del aire acondicionado');

-- Insertar datos de reparaciones
INSERT INTO Reparacion (RevisionID, CodigoReparacion, TiempoEmpleado, Comentario) VALUES
(2, 'R001', 120, 'Cambio de las 4 ruedas'),
(3, 'R002', 180, 'Reparación del sistema de aire acondicionado');

-- Insertar horas de viaje por pasajero
INSERT INTO HorasViaje (DNI_Pasajero, HorasTotales) VALUES
('12345678X', 15),
('87654321Y', 20),
('11223344Z', 10);