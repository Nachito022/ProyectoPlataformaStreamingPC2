from tkinter import *
from tkinter import ttk
import tkinter
from utils import mysqlConnection

#variable util para esconder la contraseña en el entry
HIDE_CHAR = '*'

class Interfase:

    def __init__(self, root):

        root.title("Streaming Movies")

        # create a notebook
        self.notebook = ttk.Notebook(root)
        self.notebook.pack(pady=10)

        #Se agregan 2 mainframes: uno para el login, y el otro para el programa en sí
        self.mainframepasword = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframepasword.grid(column=0, row=0, sticky=(N, W, E, S))
        self.mainframepasword.columnconfigure(0, weight=1)
        self.mainframepasword.rowconfigure(0, weight=1)

        self.mainframegeneral = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframegeneral.grid(column=0, row=0, sticky=(N, W, E, S))
        self.mainframegeneral.columnconfigure(0, weight=1)
        self.mainframegeneral.rowconfigure(0, weight=1)

        #agregar los elementos como labels, buttons, etc a pantalla
        self.add_password_mainframe_items()
        


        for child in self.mainframepasword.winfo_children(): 
            child.grid_configure(padx=5, pady=5)
        for child in self.mainframegeneral.winfo_children(): 
            child.grid_configure(padx=5, pady=5)


        self.notebook.add(self.mainframepasword, text="Username and Password")
        self.notebook.add(self.mainframegeneral, text="Streaming")
        self.notebook.hide(self.mainframegeneral)

    #Función que cambia si se puede visualizar el password
    def toggle_password_display(self):
        show = HIDE_CHAR if not self.password_entry.cget('show') else ''
        self.password_entry.config(show=show)



    def add_password_mainframe_items(self):
    # Entry box to get username from users.
        self.username = StringVar()
        self.username_entry = ttk.Entry(self.mainframepasword, textvariable=self.username)
        self.username_entry.grid(column=1, row=1)


        # Entry box to get password from users.
        self.password = StringVar()
        self.password_entry = ttk.Entry(self.mainframepasword, show=HIDE_CHAR, textvariable=self.password)
        self.password_entry.grid(column=1, row=2)

        #Botón para mostrar la contranseña, por default no se puede ver
        toggle_btn = ttk.Button(self.mainframepasword, text='Toggle password display', command=self.toggle_password_display)
        toggle_btn.grid(column=1, row=3)

        enter_passord_btn = ttk.Button(self.mainframepasword, text='Login', command=self.check_username_and_password)
        enter_passord_btn.grid(column=3, row=2)

        # Create two labels
        label_username = tkinter.Label(self.mainframepasword, text="Username")
        label_username.grid(column=0, row=1)
        label_password = tkinter.Label(self.mainframepasword, text="Password")
        label_password.grid(column=0, row=2)
        
    #Funcion para fijarse si existe el usuario
    def check_username_and_password(self):
        data = [self.get_entry_username(),self.get_entry_password()]
        mysqlConnection.username_and_password(data)
        #self.change_mainframe_notebook()

    #cambia el mainframe al del programa
    def change_mainframe_notebook(self):
        self.notebook.add(self.mainframegeneral)
        self.notebook.hide(self.mainframepasword)

    #getter
    def get_entry_password(self):
        return str(self.password.get())
    
    #getter
    def get_entry_username(self):
        return str(self.username.get())


#función main
def main(): 
    root = tkinter.Tk()
    app = Interfase(root)
    root.mainloop()

if (__name__ == "__main__"):
    main()

