import mysql.connector

config = {
    "user": "root",
    "password" : "",
    "host": "localhost",
    "database": "ejemplo_materias"
}

cnx = mysql.connector.connect(**config)
print("Conectado",cnx.is_connected())
cnx.close()