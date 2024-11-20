import mysql.connector
from utils import ConfigDatabase
from utils import UtilsVarios
from utils import consultas



def autenticacion(cursor,datos_usuario):
    
    #datos_usuario = ["Nacho",123]

    # Inicio de las operaciones
    #Nos fijamos el numero de usuario, retorna 0 si no existe
    usuario = consultas.consulta_nombre_user(cursor,[datos_usuario[0]])
    if(usuario != 0):
        usuario_and_contrasena = consultas.check_user_data(cursor,datos_usuario)
        login_exitoso = False
        #Para este caso el usuario existe pero no se sabe aún si la contraseña es correcta
        if(usuario_and_contrasena != 0):
            login_exitoso = True
            datos = [usuario,login_exitoso,UtilsVarios.get_current_time()]
            consultas.insertar_en_formulario(cursor,datos)
            return True
        else:
            datos = [usuario,login_exitoso,UtilsVarios.get_current_time()]
            consultas.insertar_en_formulario(cursor,datos)


def add_user_logic(cursor,datos_usuario):
    usuario = consultas.consulta_nombre_user(cursor,[datos_usuario[0]])
    if(usuario != 0):
        return False
    else:
        consultas.insertar_nuevo_usuario(cursor,datos_usuario)
        return True
        
def new_user_email_password(datos_usuario):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    fueExitoso = False
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones
            fueExitoso = add_user_logic(cursor,datos_usuario)
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
    return fueExitoso
    

def get_profiles_for_interfase(datos_usuario):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    datos_perfiles = []
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones
            datos_perfiles.append(consultas.consulta_perfiles_asociados(cursor,datos_usuario))
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
    return datos_perfiles[0]


def username_and_password(datos_usuario):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    fueExitoso = False
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones
            fueExitoso = autenticacion(cursor,datos_usuario)
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
    return fueExitoso

