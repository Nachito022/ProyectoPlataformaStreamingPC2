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

def insertar_nuevo_usuario(cursor,datos_usuario):
    consulta =  """INSERT INTO Usuarios(nombre,email,contraseña) VALUES(%s, %s, %s)""" 
    cursor.execute(consulta,datos_usuario)

def insertar_nuevos_perfiles(cursor,datos_perfiles,id_usuario_nuevo):
    #Para poder insertar varios perfiles, se deben agrupar de acuerdo a su nombre y tipo junto con el id_usuario que los identifica
    nombres = [dato[0] for dato in datos_perfiles]
    tipo_perfiles = [dato[1] for dato in datos_perfiles]
    perfil_completo = []
    for i in range(len(datos_perfiles)):
        perfil_completo.append([id_usuario_nuevo,nombres[i],tipo_perfiles[i]])
    #ya teniendo todos los perfiles, se ejecuta la consulta:
    consulta_perfiles =  """INSERT INTO Perfiles(usuario_id,nombre,tipo_perfil) VALUES(%s, %s, %s)""" 
    cursor.executemany(consulta_perfiles,perfil_completo)

def consulta_perfiles_asociados(cursor,usuario):
    #esta consulta recibe un ususario y devuelve los perfiles asociados
    consulta = """
    SELECT *
    FROM Usuarios U,Perfiles P
    WHERE U.usuario_id = P.usuario_id and U.usuario_id = %s
    """
    cursor.execute(consulta,usuario)
    filas = cursor.fetchall()
    return filas

def consulta_nombres_contenidos(cursor,perfil_id_kids):
    #Esta consulta pregunta sobre los contenidos del programa;
    #Primero seleciona todos aquellos apto para kids, luego pregunta por los contenidos respecto al tipo de perfil actual
    #Si el tipo de perfil es tipo kids (true), la segunda consulta devuelve lo mismo que el primero y los que se repiten se descartan con UNION
    #Caso contrario devuelve los que sean falsos, lo cual el UNION devuelve todo el contenido
    consulta = """
    SELECT C.titulo,C.contenido_id
    FROM Contenido C
    WHERE C.apto_kids = TRUE
    UNION
    SELECT C.titulo,C.contenido_id
    FROM Contenido C
    WHERE C.apto_kids = %s
    """
    cursor.execute(consulta,perfil_id_kids)
    filas = cursor.fetchall()
    return filas

def consulta_get_continuar_viendo(cursor,id_perfil):
    #devuelve datos de lo último visto de un perfil específico, max 5
    consulta = """
    SELECT C.titulo,H.temporada_actual,H.capitulo_actual,H.tiempo_visualizado,H.valoracion
    FROM Historial H,Contenido C
    WHERE H.contenido_id = C.contenido_id and H.perfil_id = %s
    order by H.fecha_visto desc
    limit 5;
    """
    cursor.execute(consulta,id_perfil)
    filas = cursor.fetchall()
    return filas

def consulta_get_contenido_novedoso(cursor,perfil_id_kids,fecha_Actual):
    #esta consulta devuelve los titulos del contenido que sea más nuevo respecto a una fecha dada.
    #La subquery pregunta si el contenido es apta para el perfil sellecionada
    params = {"perfil": perfil_id_kids,"fecha": fecha_Actual}
    consulta="""
    SELECT C.titulo,C.fecha_publicacion
    FROM Contenido C
    where C.fecha_publicacion > %(fecha)s and C.contenido_id in (SELECT C.contenido_id 
		FROM Contenido C 
		WHERE C.apto_kids = true 
		union 
		SELECT C.contenido_id 
		FROM Contenido C 
		WHERE C.apto_kids = %(perfil)s)
    order by C.fecha_publicacion desc
    Limit 10;   
    """
    cursor.execute(consulta,params)
    filas = cursor.fetchall()
    return filas

def consulta_busqueda_info_contenido(cursor,contenido_id):
    #Esta consulta devuelve información relevante a un contenido como los actores/directores
    consulta = """
    select a.nombre,ca.rol,ca.nom_ficticio,c2.nombre
    from contenido c,contenido_artistas ca,categorias c2,artistas a 
    where c.contenido_id = ca.contenido_id and c2.categoria_id =  c.categoria_id and a.artista_id = ca.artista_id and c.contenido_id = %s;
    """
    cursor.execute(consulta,[contenido_id])
    filas = cursor.fetchall()
    return filas
