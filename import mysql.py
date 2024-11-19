import mysql.connector

config = {
    "user": "root",
    "password" : "",
    "host": "localhost",
    "database": "plataform_streaming"
}

cnx = mysql.connector.connect(**config)
print("Conectado",cnx.is_connected())
cnx.close()