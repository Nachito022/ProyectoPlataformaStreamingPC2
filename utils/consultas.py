#Consultas de DB

def get_usuarios(cursor):
    # Consulta a realizar
    consulta = """
    SELECT *
    FROM Usuarios
    """

    cursor.execute(consulta)
    # Resultados de la consulta
    filas = cursor.fetchall()
    for fila in filas:
        print(fila)

def check_user_data(cursor,datos_usuario):
    # Consulta a realizar
    consulta = """
    SELECT *
    FROM Usuarios
    WHERE nombre = %s and contraseña = %s
    """
    cursor.execute(consulta,datos_usuario)
    fila = cursor.fetchone()
    if(fila != None):
        return fila
    else:
        return 0

#Esta función realiza la consulta si existe el usuario 
def consulta_nombre_user(cursor,nombre_usuario):
    # Consulta a realizar
    consulta = """
    SELECT *
    FROM Usuarios
    WHERE nombre = %s
    """
    #Si ecuentra uno, devuelve el id. Caso contrario, devuelve 0
    cursor.execute(consulta,nombre_usuario)
    fila = cursor.fetchone()
    if(fila != None):
        return fila
    else:
        return 0


def insertar_en_formulario(cursor,datos):
    consulta =  """INSERT INTO Formulario(usuario_id,exitoso,fecha_hora) VALUES(%s, %s, %s)""" 
    cursor.execute(consulta,datos)

def insertar_nuevo_usuario(cursor,datos):
    consulta =  """INSERT INTO Usuarios(nombre,email,contraseña) VALUES(%s, %s, %s)""" 
    cursor.execute(consulta,datos)

def consulta_perfiles_asociados(cursor,usuario):
    consulta = """
    SELECT *
    FROM Usuarios U,Perfiles P
    WHERE U.usuario_id = P.usuario_id and U.usuario_id = %s
    """
    cursor.execute(consulta,usuario)
    filas = cursor.fetchall()
    return filas

def consulta_nombres_contenidos(cursor,perfil_id_kids):
    consulta = """
    SELECT C.titulo
    FROM Contenido C
    WHERE C.apto_kids = TRUE
    UNION
    SELECT C.titulo
    FROM Contenido C
    WHERE C.apto_kids = %s
    """
    cursor.execute(consulta,perfil_id_kids)
    filas = cursor.fetchall()
    return filas

def consulta_get_continuar_viendo(cursor,id_perfil):
    consulta = """
    SELECT C.titulo,H.temporada_actual,H.capitulo_actual 
    FROM Historial H,Contenido C
    WHERE H.contenido_id = C.contenido_id and H.perfil_id = %s
    order by H.fecha_visto desc
    limit 5;
    """
    cursor.execute(consulta,id_perfil)
    filas = cursor.fetchall()
    return filas

def consulta_get_contenido_novedoso(cursor,fecha_Actual):
    consulta="""
    SELECT C.titulo,C.fecha_publicacion
    FROM Contenido C
    where C.fecha_publicacion > %s
    order by C.fecha_publicacion desc
    Limit 10;
    """
    cursor.execute(consulta,[fecha_Actual])
    filas = cursor.fetchall()
    return filas