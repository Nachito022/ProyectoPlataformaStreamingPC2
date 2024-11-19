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
    SELECT usuario_id
    FROM Usuarios
    WHERE nombre = %s and contraseña = %s
    """
    cursor.execute(consulta,datos_usuario)
    fila = cursor.fetchone()
    if(fila != None):
        return fila[0]
    else:
        return 0

#Esta función realiza la consulta si existe el usuario 
def consulta_nombre_user(cursor,nombre_usuario):
    # Consulta a realizar
    consulta = """
    SELECT usuario_id
    FROM Usuarios
    WHERE nombre = %s
    """
    #Si ecuentra uno, devuelve el id. Caso contrario, devuelve 0
    cursor.execute(consulta,nombre_usuario)
    fila = cursor.fetchone()
    if(fila != None):
        return fila[0]
    else:
        return 0


def insertar_en_formulario(cursor,datos):
    consulta =  """INSERT INTO Formulario(usuario_id,exitoso,fecha_hora) VALUES(%s, %s, %s)""" 
    cursor.execute(consulta,datos)
