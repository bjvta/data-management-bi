-- Consultas adicionales para obtener datos como promedio de pasajeros, km diarios, etc.

CREATE VIEW MediaViajerosRuta AS
SELECT RutaID, AVG(ViajeroCount) AS MediaViajeros
FROM (
    SELECT ServicioDiario.RutaID, COUNT(Billete.DNI_Pasajero) AS ViajeroCount
    FROM Billete
    JOIN ServicioDiario ON Billete.ServicioID = ServicioDiario.ServicioID
    GROUP BY ServicioDiario.RutaID, Billete.ServicioID
) AS RutaViajeros
GROUP BY RutaID;

-- Total de horas de viaje por pasajero
CREATE VIEW HorasViajePasajero AS
SELECT DNI_Pasajero, SUM(DATEDIFF(MINUTE, HoraSalida, HoraLlegadaPrevista) / 60.0) AS HorasTotales
FROM Billete
JOIN ServicioDiario ON Billete.ServicioID = ServicioDiario.ServicioID
GROUP BY DNI_Pasajero;