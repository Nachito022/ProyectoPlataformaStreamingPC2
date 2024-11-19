import mysql.connector

config = {
    "user": "root",
    "password" : "28072000Nn",
    "host": "localhost",
    "database": "plataforma_streaming"
}

def autenticacion(cursor):
     # Inicio de las operaciones
     cursor.execute( """INSERT INTO Formulario(usuario_id,exitoso,fecha_hora) VALUES(2,False,'20120618 10:34:10 AM')""" )


cnx = mysql.connector.connect(**config)
print("Conectado",cnx.is_connected())

if cnx.is_connected():
    cursor = cnx.cursor()
    try:
        # Inicio de las operaciones
        autenticacion(cursor)
        # Confirma todos los cambios
        cnx.commit()
        print("Operaciones completadas exitosamente" )
    except mysql.connector.Error as err:
        # Deshacer los cambios no confirmados
        cnx.rollback()
        print(f"Error en el proceso: {err}")
    finally:
        # Cerrar el cursor y la conexión
        cursor.close()
        cnx.close()