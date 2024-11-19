import mysql.connector
from utils import ConfigDatabase
from utils import UtilsVarios
from utils import consultas



def autenticacion(cursor,datos_usuario):
    
    #datos_usuario = ["Nacho",123]

    # Inicio de las operaciones
    usuario = consultas.check_user_data(cursor,datos_usuario)
    datos = [usuario,True,UtilsVarios.get_current_time()]
    consulta =  """INSERT INTO Formulario(usuario_id,exitoso,fecha_hora) VALUES(%s, %s, %s)""" 
    cursor.execute(consulta,datos)



def username_and_password(datos_usuario):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones
            autenticacion(cursor,datos_usuario)
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