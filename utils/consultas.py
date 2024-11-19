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


