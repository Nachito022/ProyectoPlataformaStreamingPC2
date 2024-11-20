from tkinter import *
from tkinter import ttk
import tkinter
from utils import mysqlConnectionLogic as logic

#variable util para esconder la contraseña en el entry
HIDE_CHAR = '*'
HIDE_CHAR_NEWUSER = '*'

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

        self.mainframeNewUser = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframeNewUser.grid(column=0, row=0, sticky=(N, W, E, S))
        self.mainframeNewUser.columnconfigure(0, weight=1)
        self.mainframeNewUser.rowconfigure(0, weight=1)

        #agregar los elementos como labels, buttons, etc a pantalla
        self.add_password_mainframe_items()

        self.option_registro_usuario_nuevo()
        
        self.add_menubar(root)

        for child in self.mainframepasword.winfo_children(): 
            child.grid_configure(padx=5, pady=5)
        for child in self.mainframegeneral.winfo_children(): 
            child.grid_configure(padx=5, pady=5)


        self.notebook.add(self.mainframepasword, text="Username and Password")
        self.notebook.add(self.mainframegeneral, text="Streaming")
        self.notebook.add(self.mainframeNewUser, text="Add New User")
        self.notebook.hide(self.mainframegeneral)
        self.notebook.hide(self.mainframeNewUser)

    #Función que cambia si se puede visualizar el password
    def toggle_password_display(self):
        show = HIDE_CHAR if not self.password_entry.cget('show') else ''
        self.password_entry.config(show=show)
    
        #Función que cambia si se puede visualizar el password
    def toggle_password_display_newuser(self):
        show = HIDE_CHAR_NEWUSER if not self.Newpassword_entry.cget('show') else ''
        self.Newpassword_entry.config(show=show)

    def add_incorrect_info(self):
        label_error_1 = tkinter.Label(self.mainframepasword,fg='red', text="Username/Password is incorrect")
        label_error_1.grid(column=1, row=4)

    def add_success_info(self):
        label_success_1 = tkinter.Label(self.mainframepasword,fg='green', text="User Added Correctly")
        label_success_1.grid(column=1, row=4)

    def add_user_exists_warning(self):
        label_error_2 = tkinter.Label(self.mainframeNewUser,fg='red', text="Username already exists!")
        label_error_2.grid(column=1, row=5)

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
        if(logic.username_and_password(data)):
            self.set_mainframe_notebook_general()
        else:
            self.add_incorrect_info()

    #cambia el mainframe al del programa
    def set_mainframe_notebook_general(self):
        self.notebook.add(self.mainframegeneral)
        self.notebook.hide(self.mainframepasword)
        self.notebook.hide(self.mainframeNewUser)

    #cambia el mainframe al del programa
    def set_mainframe_notebook_newuser(self):
        self.notebook.add(self.mainframeNewUser)
        self.notebook.hide(self.mainframepasword)
        self.notebook.hide(self.mainframegeneral)

        #cambia el mainframe al del programa
    def set_mainframe_notebook_password(self):
        self.notebook.add(self.mainframepasword)
        self.notebook.hide(self.mainframeNewUser)
        self.notebook.hide(self.mainframegeneral)


    def add_menubar(self,root):
        #add menu for adding points and lines
        menubar = tkinter.Menu(root)
        options_menu = tkinter.Menu(menubar,tearoff=False)
        options_menu.add_command(label="Registrarse",command=self.set_mainframe_notebook_newuser)
        #options_menu.add_command(label="Add line")

        # Append the menu to the menubar.
        menubar.add_cascade(menu=options_menu,label="Options")
        root.config(menu=menubar)

    def option_registro_usuario_nuevo(self):
        # Entry box to get username from users.
        self.Newusername = StringVar()
        self.Newusername_entry = ttk.Entry(self.mainframeNewUser, textvariable=self.Newusername)
        self.Newusername_entry.grid(column=1, row=1)

        #Entry box to get password from users.
        self.NewEmail = StringVar()
        self.NewEmail_entry = ttk.Entry(self.mainframeNewUser, textvariable=self.NewEmail)
        self.NewEmail_entry.grid(column=1, row=2)    

        # Entry box to get password from users.
        self.Newpassword = StringVar()
        self.Newpassword_entry = ttk.Entry(self.mainframeNewUser, show=HIDE_CHAR, textvariable=self.Newpassword)
        self.Newpassword_entry.grid(column=1, row=3)

        #Botón para mostrar la contranseña, por default no se puede ver
        toggle_new_btn = ttk.Button(self.mainframeNewUser, text='Toggle password display', command=self.toggle_password_display_newuser)
        toggle_new_btn.grid(column=1, row=4)

        enter_new_passord_btn = ttk.Button(self.mainframeNewUser, text='Add New User', command=self.interfase_create_new_user)
        enter_new_passord_btn.grid(column=3, row=3)

        quit_new_passord_btn = ttk.Button(self.mainframeNewUser, text='Cancel New User', command=self.set_mainframe_notebook_password)
        quit_new_passord_btn.grid(column=0, row=4)

        # Create two labels
        label_newusername = tkinter.Label(self.mainframeNewUser, text="New Username")
        label_newusername.grid(column=0, row=1)
        # Create two labels
        label_newEmail = tkinter.Label(self.mainframeNewUser, text="New Email")
        label_newEmail.grid(column=0, row=2)
        label_newpassword = tkinter.Label(self.mainframeNewUser, text="New Password")
        label_newpassword.grid(column=0, row=3)

    def interfase_create_new_user(self):
        datos = [self.get_entry_new_username(),self.get_entry_new_email(),self.get_entry_new_password()]
        if(logic.new_user_email_password(datos)):
            self.set_mainframe_notebook_password()
            self.add_success_info()
        else:
            self.add_user_exists_warning()

    
    
    #getter
    def get_entry_password(self):
        return str(self.password.get())
    
    #getter
    def get_entry_username(self):
        return str(self.username.get())
    
        #getter
    def get_entry_new_password(self):
        return str(self.Newpassword.get())
    
    #getter
    def get_entry_new_username(self):
        return str(self.Newusername.get())
    
    #getter
    def get_entry_new_email(self):
        return str(self.NewEmail.get())


#función main
def main(): 
    root = tkinter.Tk()
    app = Interfase(root)
    root.mainloop()

if (__name__ == "__main__"):
    main()

