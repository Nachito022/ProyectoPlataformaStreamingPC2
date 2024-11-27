import mysql.connector

# Datos de conexión a la base de datos

def get_config():
    config = {
        "user": "root",
        "password" : "",
        "host": "localhost",
        "database": "plataforma_streaming"
    }
    return config