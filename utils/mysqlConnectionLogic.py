import mysql.connector
from utils import ConfigDatabase
from utils import UtilsVarios
from utils import consultas

# Este archivo se utiliza como puente entre la interfase y los consultas
# Acá se llaman las funciones, se conecta a la DB, crea el cursor, llaman a los respectivas funciones de consultas,
# se realiza el commit para guardar los cambios y se cierra el cursor.

def autenticacion(cursor,datos_usuario):

    # Inicio de las operaciones
    #Nos fijamos el numero de usuario, retorna 0 si no existe
    usuario = consultas.consulta_nombre_user(cursor,[datos_usuario[0]])
    if(usuario != 0):
        usuario_and_contrasena = consultas.check_user_data(cursor,datos_usuario)
        #login_exitoso se utiliza como booleando para guerdar si existe el usuario o no
        login_exitoso = False
        #Para este caso el usuario existe pero no se sabe aún si la contraseña es correcta
        if(usuario_and_contrasena != 0):
            login_exitoso = True
            datos = [usuario[0],login_exitoso,UtilsVarios.get_current_time()]
            #insertar en el formulario el exito
            consultas.insertar_en_formulario(cursor,datos)
            return usuario_and_contrasena
        else:
            datos = [usuario,login_exitoso,UtilsVarios.get_current_time()]
            #insertar en el formulario la falla
            consultas.insertar_en_formulario(cursor,datos)


def add_user_logic(cursor,datos_usuario):
    #Se realiza la consulta si existe el usuario previamente, sino se inserta un nuevo usuario
    usuario = consultas.consulta_nombre_user(cursor,[datos_usuario[0]])
    if(usuario != 0):
        return False
    else:
        consultas.insertar_nuevo_usuario(cursor,datos_usuario)
        return True
        
def new_user_email_password(datos_usuario,datos_perfiles_nuevos):
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
            # Una vez confirmado los cambios, se deben agregar los perfiles nuevos. para ello se consulta sobre el id_usuario recientemente agregado
            user_id_nuevo = consultas.check_user_data(cursor,[datos_usuario[0],datos_usuario[2]])[0]
            # Se insertan los perfiles creados
            consultas.insertar_nuevos_perfiles(cursor,datos_perfiles_nuevos,user_id_nuevo)
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
            # Inicio de las operaciones: se consulta sobre todos los perfiles asociados a una cuenta
            datos_perfiles.append(consultas.consulta_perfiles_asociados(cursor,[datos_usuario[0]]))
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
    usuario = []
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones
            # Llama a la función autenticación, el cual contiene la lógica y llama las consultas requeridas para poder autenticar el ussuario
            usuario.append(autenticacion(cursor,datos_usuario))
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
    return usuario[0]

def get_novedades_database(perfil_id,fecha_Actual=UtilsVarios.get_30_days_ago()):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    datos_contenido_novedoso = []
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones: llama la función que consulta sobre lo novedoso
            datos_contenido_novedoso.append(consultas.consulta_get_contenido_novedoso(cursor,perfil_id,fecha_Actual))
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
    return datos_contenido_novedoso[0]

def get_continuarViendo_database(dato_perfil):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    datos_continuar_viendo = []
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones
            datos_continuar_viendo.append(consultas.consulta_get_continuar_viendo(cursor,dato_perfil))
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
    return datos_continuar_viendo[0]

def get_titulos_database(data_perfil):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    datos_nombres_contenidos = []
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones
            datos_nombres_contenidos.append(consultas.consulta_nombres_contenidos(cursor,data_perfil))
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
    return datos_nombres_contenidos[0]

def get_info_contenido_particular(data_contenido):
    config = ConfigDatabase.get_config()
    cnx = mysql.connector.connect(**config)
    print("Conectado",cnx.is_connected())
    datos_contenido = []
    if cnx.is_connected():
        cursor = cnx.cursor()
        try:
            # Inicio de las operaciones. Se busca la información de un contenido en particular a causa de una búsqueda
            datos_contenido.append(consultas.consulta_busqueda_info_contenido(cursor,data_contenido))
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
    return datos_contenido[0]