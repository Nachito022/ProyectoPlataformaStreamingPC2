import mysql.connector
import ConfigDatabase

config = ConfigDatabase.get_config()

def autenticacion(cursor):
     # Inicio de las operaciones
     cursor.execute( """INSERT INTO Formulario(usuario_id,exitoso,fecha_hora) VALUES(1,False,"2012-06-18 10:34:10")""" )


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