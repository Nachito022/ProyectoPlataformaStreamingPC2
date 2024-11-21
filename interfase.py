from tkinter import *
from tkinter import ttk
import tkinter
from utils import mysqlConnectionLogic as logic

#variable util para esconder la contraseña en el entry
HIDE_CHAR = '*'
HIDE_CHAR_NEWUSER = '*'

class Interfase:

    def __init__(self, root):
        self._username_id = []
        self._perfil_id = []

        root.title("Streaming Movies")

        # create a notebook
        self.notebook = ttk.Notebook(root)
        self.notebook.pack(pady=10)

        #Se agregan 4 mainframes: uno para el login,uno para el programa en sí, uno para registrarse, y otro para elegir el perfil
        self.mainframepassword = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframepassword.grid(column=0, row=0, sticky=(N, W, E, S))
        self.mainframepassword.columnconfigure(0, weight=1)
        self.mainframepassword.rowconfigure(0, weight=1)

        self.mainframegeneral = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframegeneral.grid(column=0, row=0, sticky=(N, W, E, S))
        self.mainframegeneral.columnconfigure(0, weight=1)
        self.mainframegeneral.rowconfigure(0, weight=1)

        self.mainframeNewUser = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframeNewUser.grid(column=0, row=0, sticky=(N, W, E, S))
        self.mainframeNewUser.columnconfigure(0, weight=1)
        self.mainframeNewUser.rowconfigure(0, weight=1)

        self.mainframePickprofile = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframePickprofile.grid(column=0, row=0, sticky=N+S+E+W)
        self.mainframePickprofile.columnconfigure(0, weight=1)
        self.mainframePickprofile.rowconfigure(0, weight=1)

        #agregar los elementos como labels, buttons, etc a pantalla
        self.add_password_mainframe_items()
        

        self.option_registro_usuario_nuevo()

        self.label_error_success = tkinter.Label(self.mainframepassword,fg='red', text="")
        self.label_error_success.grid(column=1, row=4)

        
        self.add_menubar(root)

        for child in self.mainframepassword.winfo_children(): 
            child.grid_configure(padx=5, pady=5)
        for child in self.mainframegeneral.winfo_children(): 
            child.grid_configure(padx=5, pady=5)


        self.notebook.add(self.mainframepassword, text="Username and Password")
        self.notebook.add(self.mainframegeneral, text="Streaming")
        self.notebook.add(self.mainframeNewUser, text="Add New User")
        self.notebook.add(self.mainframePickprofile,text="Pick Profile")
        self.notebook.hide(self.mainframegeneral)
        self.notebook.hide(self.mainframeNewUser)
        self.notebook.hide(self.mainframePickprofile)

    #Función que cambia si se puede visualizar el password
    def toggle_password_display(self):
        show = HIDE_CHAR if not self.password_entry.cget('show') else ''
        self.password_entry.config(show=show)
    
        #Función que cambia si se puede visualizar el password
    def toggle_password_display_newuser(self):
        show = HIDE_CHAR_NEWUSER if not self.Newpassword_entry.cget('show') else ''
        self.Newpassword_entry.config(show=show)

    def add_incorrect_info(self):
        self.label_error_success.config(text="Username/Password is incorrect",fg='red')

    def add_success_info(self):
        self.label_error_success.config(fg='green', text="User Added Correctly")
        self.label_error_2.config(text="")


    def add_user_exists_warning(self):
        self.label_error_2 = tkinter.Label(self.mainframeNewUser,fg='red', text="Username already exists!")
        self.label_error_2.grid(column=1, row=5)

    def add_password_mainframe_items(self):
    # Entry box to get username from users.
        self.username = StringVar(value="test")
        self.username_entry = ttk.Entry(self.mainframepassword, textvariable=self.username)
        self.username_entry.grid(column=1, row=1)


        # Entry box to get password from users.
        self.password = StringVar(value="12345")
        self.password_entry = ttk.Entry(self.mainframepassword, show=HIDE_CHAR, textvariable=self.password)
        self.password_entry.grid(column=1, row=2)

        #Botón para mostrar la contranseña, por default no se puede ver
        toggle_btn = ttk.Button(self.mainframepassword, text='Toggle password display', command=self.toggle_password_display)
        toggle_btn.grid(column=1, row=3)

        enter_passord_btn = ttk.Button(self.mainframepassword, text='Login', command=self.check_username_and_password)
        enter_passord_btn.grid(column=3, row=2)

        # Create two labels
        label_username = tkinter.Label(self.mainframepassword, text="Username")
        label_username.grid(column=0, row=1)
        label_password = tkinter.Label(self.mainframepassword, text="Password")
        label_password.grid(column=0, row=2)

    def add_profile_mainframe_items(self):
        user_data = logic.get_profiles_for_interfase(self.get_username_id_variable())
        #Botón para elegir perfil
        #El user_data tiene la siguiente forma: (usuario_id,perfil_id,nombre)
        #Se asocia a cada boton el comando de cambiar de mainframe con su respectivo numero de perfil, para ello se utiliza la funcion lambda
        for i in range(6):
            if(i<len(user_data)):
                b = Button(self.mainframePickprofile, text=user_data[i][2],height = 2, width = 10,command=lambda k=user_data[i][1]:self.set_mainframe_notebook_general(k))
                b.grid(column=2, row=i,sticky="nwes")
            else:
                b = Button(self.mainframePickprofile, text="No Profile",height = 2, width = 10)
                b.grid(column=2, row=i,sticky="nwes")


        # Create two labels
        #label_username = tkinter.Label(self.mainframePickprofile, text="Pick a Profile:")
        #label_username.grid(column=0, row=0)
        #label_password = tkinter.Label(self.mainframePickprofile, text="Password")
        #label_password.grid(column=0, row=2)
        
    #Funcion para fijarse si existe el usuario
    def check_username_and_password(self):
        data = [self.get_entry_username(),self.get_entry_password()]
        if(logic.username_and_password(data)):
            self.set_username_id_variable([self.get_entry_username()])
            self.add_profile_mainframe_items()
            self.set_mainframe_notebook_profile()
        else:
            self.add_incorrect_info()

    #cambia el mainframe al del programa
    def set_mainframe_notebook_general(self,perfil_id):
        self.set_profile_id_variable(perfil_id)
        self.notebook.add(self.mainframegeneral)
        self.notebook.hide(self.mainframepassword)
        self.notebook.hide(self.mainframeNewUser)
        self.notebook.hide(self.mainframePickprofile)
        self.add_mainframe_items()

    #cambia el mainframe al del programa
    def set_mainframe_notebook_newuser(self):
        self.notebook.add(self.mainframeNewUser)
        self.notebook.hide(self.mainframepassword)
        self.notebook.hide(self.mainframegeneral)
        self.notebook.hide(self.mainframePickprofile)

        #cambia el mainframe al del programa
    def set_mainframe_notebook_password(self):
        self.notebook.add(self.mainframepassword)
        self.notebook.hide(self.mainframeNewUser)
        self.notebook.hide(self.mainframegeneral)
        self.notebook.hide(self.mainframePickprofile)

        #cambia el mainframe al del programa
    def set_mainframe_notebook_profile(self):
        self.notebook.add(self.mainframePickprofile)
        self.notebook.hide(self.mainframeNewUser)
        self.notebook.hide(self.mainframegeneral)
        self.notebook.hide(self.mainframepassword)

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

    def add_mainframe_items(self):
        self.mainframeNovedades = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframeNovedades.grid(column=0, row=0, sticky=(N, W, E, S))
        self.mainframeNovedades.columnconfigure(0, weight=1)
        self.mainframeNovedades.rowconfigure(0, weight=1)

        self.mainframeContinuarViendo = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframeContinuarViendo.grid(column=1, row=0, sticky=(N, W, E, S))
        self.mainframeContinuarViendo.columnconfigure(0, weight=1)
        self.mainframeContinuarViendo.rowconfigure(0, weight=1)

        self.mainframeSearch = ttk.Frame(self.notebook, padding="3 3 12 12")
        self.mainframeSearch.grid(column=0, row=1, sticky=(N, W, E, S),columnspan=2)
        self.mainframeSearch.columnconfigure(0, weight=1)
        self.mainframeSearch.rowconfigure(0, weight=1)

        # Create a label
        label_txt_novedades = Label(self.mainframeNovedades, text="Novedades",font=("Helvetica", 14), fg="grey")
        label_txt_novedades.grid(column=0, row=0)
        label_txt_ContinuarViendo = Label(self.mainframeContinuarViendo, text="Continuar Viendo:",font=("Helvetica", 14), fg="grey")
        label_txt_ContinuarViendo.grid(column=0, row=0)

        label_txt_novedades = Text(self.mainframeNovedades,width=30,height=8,font=("Helvetica", 14), fg="grey")
        label_txt_novedades.grid(column=0, row=1)
        label_txt_ContinuarViendo = Text(self.mainframeContinuarViendo,width=30,height=8,font=("Helvetica", 14), fg="grey")
        label_txt_ContinuarViendo.grid(column=0, row=1)

        lista_contenido_novedoso = logic.get_novedades_database()

        for novedades in lista_contenido_novedoso:
            label_txt_novedades.insert(END, f"{novedades[0]}" + '\n')
        label_txt_novedades.config(state=DISABLED)

        lista_contenido_seguirViendo = logic.get_continuarViendo_database([self.get_profile_id_variable()])

        if(len(lista_contenido_seguirViendo)>0):
            for seguirViendo in lista_contenido_seguirViendo:
                label_txt_ContinuarViendo.insert(END, f"{seguirViendo[0]}" + '\n')
            label_txt_ContinuarViendo.config(state=DISABLED)
        else:
            label_txt_ContinuarViendo.insert(END, "¡Te viste todo!" + '\n')
        label_txt_ContinuarViendo.config(state=DISABLED)
        
        self.lista_contenido_searchbar = logic.get_titulos_database()

        # Create a label
        search_label = Label(self.mainframeSearch, text="Search Content",font=("Helvetica", 14), fg="grey")
        search_label.grid(column=0, row=0)

        # Create an entry box
        self.search_entry = Entry(self.mainframeSearch, font=("Helvetica", 20))
        self.search_entry.grid(column=0, row=1)

        # Create a listbox
        self.search_list = Listbox(self.mainframeSearch, width=50)
        self.search_list.grid(column=0, row=2)

        self.search_entry.bind("<Any-KeyRelease>", self.filter)
        self.filter()

    def filter(self, event=None):
        pattern = self.search_entry.get().lower()
        self.search_list.delete(0, "end")
        lista_titulos_db = [value[0] for value in self.lista_contenido_searchbar]
        filtered = [value for value in lista_titulos_db if value.lower().startswith(pattern)]
        self.search_list.insert("end", *filtered)
    
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

    def set_username_id_variable(self,username_id_login):
        self._username_id.insert(0,username_id_login)

    def set_profile_id_variable(self,profile_id_login):
        self._perfil_id.insert(0,profile_id_login)

    def get_username_id_variable(self):
        return self._username_id[0]

    def get_profile_id_variable(self):
        return self._perfil_id[0]

#función main
def main(): 
    root = tkinter.Tk()
    app = Interfase(root)
    root.mainloop()

if (__name__ == "__main__"):
    main()

