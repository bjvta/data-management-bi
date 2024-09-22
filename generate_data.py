from faker import Faker
import random

# Inicializar Faker
fake = Faker()

# Función para generar registros para la tabla Conductor
def generar_conductores(n=100):
    conductores = []
    for _ in range(n):
        dni = fake.unique.ssn()
        nombre = fake.name()
        telefono = fake.phone_number()
        direccion = fake.address().replace('\n', ', ')
        conductores.append(f"('{dni}', '{nombre}', '{telefono}', '{direccion}')")
    return conductores

# Función para generar registros para la tabla Autobus
def generar_autobuses(n=20):
    autobuses = []
    for _ in range(n):
        matricula = fake.license_plate()
        modelo = random.choice(['Volvo B9', 'Mercedes-Benz O500', 'Scania K310', 'Iveco Evadys', 'MAN Lion\'s Coach'])
        fabricante = random.choice(['Volvo', 'Mercedes-Benz', 'Scania', 'Iveco', 'MAN'])
        plazas = random.randint(40, 60)
        caracteristicas = fake.sentence(nb_words=6)
        autobuses.append(f"('{matricula}', '{modelo}', '{fabricante}', {plazas}, '{caracteristicas}')")
    return autobuses

# Función para generar registros para la tabla Ruta
def generar_rutas(n=20):
    rutas = []
    for _ in range(n):
        nombre = fake.city() + " Tour"
        importe = round(random.uniform(15.00, 50.00), 2)
        duracion = fake.time(pattern='%H:%M:%S')
        rutas.append(f"('{nombre}', {importe}, '{duracion}')")
    return rutas

# Función para generar registros para la tabla Lugar
def generar_lugares(n=100):
    lugares = []
    for _ in range(n):
        nombre = fake.city()
        actividad = random.choice(['Comida', 'Visita', 'Fotografía', None])
        actividad_str = f"'{actividad}'" if actividad else "NULL"
        lugares.append(f"('{nombre}', {actividad_str})")
    return lugares

# Función para generar registros para la tabla Pasajero
def generar_pasajeros(n=100):
    pasajeros = []
    for _ in range(n):
        dni = fake.unique.ssn()
        nombre = fake.name()
        telefono = fake.phone_number()
        pasajeros.append(f"('{dni}', '{nombre}', '{telefono}')")
    return pasajeros

# Función para generar registros de asignaciones de servicios
def generar_asignacion_servicio(n=100, max_rutas=20, max_conductores=100, max_autobuses=20):
    asignaciones = []
    for _ in range(n):
        servicio_id = random.randint(1, max_rutas)
        dni_conductor = f"DNI{random.randint(1, max_conductores):03d}"
        matricula_autobus = f"MAT{random.randint(1, max_autobuses):03d}"
        asignaciones.append(f"({servicio_id}, '{dni_conductor}', '{matricula_autobus}')")
    return asignaciones

# Función para generar registros de billetes
def generar_billetes(n=100, max_servicios=20, max_pasajeros=100):
    billetes = []
    for _ in range(n):
        dni_pasajero = f"P{random.randint(1, max_pasajeros):03d}"
        servicio_id = random.randint(1, max_servicios)
        fecha = fake.date_between(start_date='-1y', end_date='today')
        hora_llegada_prevista = fake.time(pattern='%H:%M:%S')
        billetes.append(f"('{dni_pasajero}', {servicio_id}, '{fecha}', '{hora_llegada_prevista}')")
    return billetes

# Función principal para generar el script SQL
def generar_script_sql():
    script = ""

    # Generar conductores
    script += "-- INSERT INTO Conductor\n"
    conductores = generar_conductores()
    script += "INSERT INTO Conductor (DNI, ApellidosNombre, Telefono, Direccion) VALUES\n" + ",\n".join(conductores) + ";\n\n"

    # Generar autobuses
    script += "-- INSERT INTO Autobus\n"
    autobuses = generar_autobuses()
    script += "INSERT INTO Autobus (Matricula, Modelo, Fabricante, NumeroPlazas, CaracteristicasBasicas) VALUES\n" + ",\n".join(autobuses) + ";\n\n"

    # Generar rutas
    script += "-- INSERT INTO Ruta\n"
    rutas = generar_rutas()
    script += "INSERT INTO Ruta (Nombre, Importe, Duracion) VALUES\n" + ",\n".join(rutas) + ";\n\n"

    # Generar lugares
    script += "-- INSERT INTO Lugar\n"
    lugares = generar_lugares()
    script += "INSERT INTO Lugar (Nombre, Actividad) VALUES\n" + ",\n".join(lugares) + ";\n\n"

    # Generar pasajeros
    script += "-- INSERT INTO Pasajero\n"
    pasajeros = generar_pasajeros()
    script += "INSERT INTO Pasajero (DNI, ApellidosNombre, Telefono) VALUES\n" + ",\n".join(pasajeros) + ";\n\n"

    # Generar asignaciones de servicios
    script += "-- INSERT INTO AsignacionServicio\n"
    asignaciones = generar_asignacion_servicio()
    script += "INSERT INTO AsignacionServicio (ServicioID, DNI_Conductor, MatriculaAutobus) VALUES\n" + ",\n".join(asignaciones) + ";\n\n"

    # Generar billetes
    script += "-- INSERT INTO Billete\n"
    billetes = generar_billetes()
    script += "INSERT INTO Billete (DNI_Pasajero, ServicioID, Fecha, HoraLlegadaPrevista) VALUES\n" + ",\n".join(billetes) + ";\n\n"

    return script

# Guardar el script en un archivo SQL
with open('turybus_data.sql', 'w') as file:
    file.write(generar_script_sql())

print("Script SQL generado y guardado como 'turybus_data.sql'.")