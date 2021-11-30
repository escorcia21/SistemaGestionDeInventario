from mysql.connector import connect,Error
from threading import Lock

class Singleton(type):
    """
    Con esta clase implementa el singleton en python, ademas se hace thread safe es decir
    que solo un hilo puede crear una conexion, si ya existe una se bloquea el hilo.
    Ademas cada ves que se instancia el objeto se devuelve la instancia ya creada si no hay una se crea automaticamente.
    """
    _instances = {}

    _lock = Lock()

    def __call__(cls, *args, **kwargs):

        with cls._lock:
            if cls not in cls._instances:
                instance = super().__call__(*args, **kwargs)
                cls._instances[cls] = instance

        return cls._instances[cls]


class BDD(metaclass=Singleton):
    """
    Con esta clase se hace la conexion a la base de datos y se definen todos los metodos
    para asi poder operacionar, generar consultas y ejecutar queries
    """

    def __init__(self,User="upwtmxvvdgk7cceh",Password="RVzMgKsE7ZMrFWHr7KZC",Host="bp1hnbrwyl47lbil4s65-mysql.services.clever-cloud.com", Database="bp1hnbrwyl47lbil4s65"):
        try:
            self.__connector = self.connect(User,Password,Host,Database)
        except (Exception,Error) as e:
            print(e)

    #Methods of the Object DB
    def get_employee(self,usuario, contraseña):
        """
        Descripcion:
        Con esta se valida la entrada al sistema, al verificarlos este devuele todos los datos de ese empleado

        Entradas:
        usuario(string) ------- se debe ingresar la cedula
        contraseña(string) ---- se sebe ingresar la contraseña
        """
        try:
            with self.__connector.cursor() as cur:
                query = "SELECT * FROM Empleado WHERE Cedula=%s AND Contrasena=%s AND Activo=%s"
                cur.execute(query,[usuario,contraseña,0])
                result = cur.fetchone()
                return result
        except (Exception,Error) as e:
            print(e)

    
    def show_tables(self):
        """
        Descripcion:
        Este metodo devuelve todas las tablas en la BDD.

        Salidad:
        () -> tupla
        """
        try:
            with self.__connector.cursor() as cur:
                query = "SHOW TABLES"
                cur.execute(query)
                result = cur.fetchall()
                return result
        except (Exception,Error) as e:
            print(e)

    def get_products(self):
        """
        Descripcion:
        Este metodo devuelve todos los productos en la BDD.

        Salidad:
        Al buscar los productos en la BDD devuelve una lista de tuplas con cada producto

        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT Producto.ID AS idd, Producto.Nombre AS Producto, Tipo.Nombre AS categoria, Producto.Precio, Producto.Stock FROM Producto 
                INNER JOIN Tipo ON Producto.Tipo=Tipo.ID 
                '''
                cur.execute(query)
                result = cur.fetchall()
                return result
        except  (Exception,Error) as e:
            print(e)

    def get_Factura(self):
        """
        Descripcion:
        Este metodo devuelve todas las facturas en la BDD.

        Salidad:
        Al buscar las facturas en la BDD devuelve una lista de tuplas con cada producto
        
        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT Factura.ID, Empleado.Nombre, Cliente.Nombre, Factura.Fecha, Factura.Total, Factura.Estado 
                FROM Factura 
                INNER JOIN Cliente ON Factura.Cliente = Cliente.ID 
                INNER JOIN Empleado ON Factura.Vendedor = Empleado.Cedula
                '''
                cur.execute(query)
                result = cur.fetchall()
                return result
        except Error as e:
            print(e)

    def get_FacturaLista(self,ID):
        """
        Descripcion:
        Este metodo devuelve todas los productos pertenecientes a una factura en la BDD.

        Entradas:
        ID (string) --- ID de la factura a buscar

        Salidad:
        busca los productos pertenecientes a una factura en la BDD devuelve una lista de tuplas con cada producto
        
        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT Detalle_Factura.Producto, Producto.Nombre, Detalle_Factura.Cantidad, Detalle_Factura.Precio, Detalle_Factura.subtotal 
                FROM Detalle_Factura 
                INNER JOIN Producto ON Detalle_Factura.Producto = Producto.ID 
                WHERE Detalle_Factura.Factura = %s
                '''

                cur.execute(query,[ID])
                result = cur.fetchall()
                return result
        except Error as e:
            print(e)
    
    def get_FacturaTotal(self,ID):
        """
        Descripcion:
        Este metodo devuelve el total de una factura en la BDD.

        Entradas:
        ID (string) --- ID de la factura a buscar

        Salidad:
        devuelve una lista con una tupla
        
        [()] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT sum(Detalle_Factura.Subtotal) 
                AS total 
                FROM Detalle_Factura 
                WHERE Detalle_Factura.Factura = %s
                '''

                cur.execute(query,[ID])
                result = cur.fetchall()
                return result
        except Error as e:
            print(e)
    
    def get_Factura_ID(self):
        """
        Descripcion:
        Este metodo devuelve el id de la ultimafactura en la BDD.

        Salidad:
        devuelve una lista con una tupla
        
        [()] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT max(ID) from Factura
                '''
                cur.execute(query)
                result = cur.fetchall()
                return result
        except Error as e:
            print(e)

    def get_client(self):
        """
        Descripcion:
        Este metodo devuelve todos los clientes en la BDD.
        
        Salidad:
        devuelve una lista de tuplas
        
        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT * From Cliente;
                '''
                cur.execute(query)
                result = cur.fetchall()
                return result
        except Error as e:
            print(e)
    
    def get_empleado(self):
        """
        Descripcion:
        Este metodo devuelve todos los empleados en la BDD.
        
        Salidad:
        devuelve una lista de tuplas
        
        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT * From Empleado;
                '''
                cur.execute(query)
                result = cur.fetchall()
                return result
        except Error as e:
            print(e)        

    def get_types(self):
        """
        Descripcion:
        Este metodo devuelve todos los tipos en la BDD.
        
        Salidad:
        devuelve una lista de tuplas
        
        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT ID,Nombre,Unidad From Tipo;
                '''
                cur.execute(query)
                result = cur.fetchall()
                return result
        except (Exception,Error) as e:
            print(e)

    def get_supp(self):
        """
        Descripcion:
        Este metodo devuelve todos los proveedores en la BDD.
        
        Salidad:
        devuelve una lista de tuplas
        
        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT * From Proveedor;
                '''
                cur.execute(query)
                result = cur.fetchall()
                return result
        except (Exception,Error) as e:
            print(e)

    def edit_product(self,id,Nombre,Tipo,Precio):
        """
        Descripcion:
        Con este metodo podemos editar un producto en la BDD.
        
        Entradas:
        id (int) --- ID del producto a editar
        Nombre (str) --- Nombre del producto a editar
        Tipo (int) --- Tipo del producto a editar
        Precio (float) --- Precio del producto a editar
        """
        try:
            with self.__connector.cursor() as cur:
                update_product = ('''
                UPDATE Producto SET Nombre=%s,Precio=%s,Tipo=%s WHERE ID=%s;
                ''')  
                product_info = (Nombre.upper(),Precio,Tipo,id)
                cur.execute(update_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record updated.")
        except (Exception,Error) as e:
            print(e)


    def add_Products(self,Nombre,Tipo,Precio):
        """
        Descripcion:
        Con este metodo podemos añadir un producto en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del producto a añadir
        Tipo (int) --- Tipo del producto a añadir
        Precio (float) --- Precio del producto a añadir
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Producto (Nombre,Stock,Precio,Tipo) VALUES (%s,%s,%s,%s);
                ''')  
                product_info = (Nombre.upper(),0,Precio,Tipo)
                cur.execute(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)
    
    def add_Factura(self,Vendedor,Cliente,Fecha,Total):
        """
        Descripcion:
        Con este metodo podemos añadir una factura en la BDD.
        
        Entradas:
        Vendedor (int) --- Vendedor de la factura a añadir
        Cliente (int) --- Cliente de la factura a añadir
        Fecha (str) --- Fecha de la factura a añadir
        Total (float) --- Total de la factura a añadir
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Factura (Vendedor,Cliente,Fecha,Total,Estado) VALUES (%s,%s,%s,%s,%s);
                ''')  
                product_info = (Vendedor,Cliente,Fecha,Total,0)
                cur.execute(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)
    
    def add_Factura_Detalle(self,ID,temp):
        """
        Descripcion:
        Con este metodo podemos añadir productos una factura en la BDD.
        
        Entradas:
        ID (int) --- ID de la factura a añadir
        temp (list) --- lista de los productos a añadir en la factura
        """
        product_info = []
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Detalle_Factura (Factura,Producto,Cantidad,Precio,Subtotal) VALUES (%s,%s,%s,%s,%s);
                ''')

                for row in temp:
                    #print(row)
                    fila = (ID,row["ID"],row["Cantidad"],row["Precio"],row["Total"])
                    product_info.append(fila)

                cur.executemany(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)

    def add_Type(self,Nombre,unit):
        """
        Descripcion:
        Con este metodo podemos añadir un tipo en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del tipo a añadir
        unit (int) --- unidad del tipo a añadir (0 o 1) (mts = 1 || unidad = 0)
        """
        unidad = 1 if unit =="MTS" else  0
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Tipo (Nombre,Unidad) VALUES (%s,%s);
                ''')  
                product_info = (Nombre.upper(),unidad)
                cur.execute(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)

    def addSupplier_Product(self,product,supplier,Amount,Price,Date):
        """
        Descripcion:
        Con este metodo podemos añadir compras de productos en la BDD.
        
        Entradas:
        product (int) --- producto a añadir
        supplier (int) --- proveedor a añadir
        Amount (float) --- monto a añadir
        Price (float) --- precio unitario a añadir
        Date (str) --- fecha a añadir
        """
        try:
            with self.__connector.cursor() as cur:
                add_Supplier_Product = ('''
                INSERT INTO Proveedor_Producto (Producto,Proveedor,Cantidad,Precio,Fecha) VALUES (%s,%s,%s,%s,%s);
                ''')  
                info = (product,supplier,Amount,Price,Date)
                cur.execute(add_Supplier_Product,info)
                self.__connector.commit()

                print(cur.rowcount, "record inserted.")
                self.updateStock(Amount,product,1)
        except (Exception,Error) as e:
            print(e)

    def updateStock(self,Amount,product,suma):
        """
        Descripcion:
        Con este metodo podemos actualizar el stock de un producto.

        Entradas:
        Amount (int) --- contidad comprada del producto
        product (int) --- ID del producto
        suma (int) --- variable vandera para determinar si se añade o se resta stock (suma==1: se suma stock de lo contrario se resta)
        """
        try:
            with self.__connector.cursor() as cur:

                info = (Amount,product)
                if suma == 1:
                    update_stock ='''
                    UPDATE Producto SET Stock=Stock+%s WHERE ID=%s;
                    '''
                    cur.execute(update_stock,info)
                else:
                    update_stock ='''
                    UPDATE Producto SET Stock=Stock-%s WHERE ID=%s;
                    '''
                    cur.execute(update_stock,info)

                self.__connector.commit()
                print(cur.rowcount, "record updated.")
        except (Exception,Error) as e:
            print(e)

    def add_Supplier(self,Nombre,Nit,Email,Telefono,Direccion):
        """
        Descripcion:
        Con este metodo podemos añadir proveedores en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del proveedor a añadir
        Nit (str) --- Nit del proveedor a añadir
        Email (str) --- Email del proveedor a añadir
        Telefono (str) --- Telefono del proveedor a añadir
        Direccion (str) --- Direccion del proveedor a añadir
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Proveedor (Nombre,Nit,Correo,Telefono,Direccion) VALUES (%s,%s,%s,%s,%s);
                ''')  
                product_info = (Nombre.upper(),Nit,Email.upper(),Telefono,Direccion.upper())
                cur.execute(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)

    def edit_Supplier(self,Nombre,Nit,Email,Telefono,Direccion,Id):
        """
        Descripcion:
        Con este metodo podemos editar proveedores en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del proveedor a editar
        Nit (str) --- Nit del proveedor a editar
        Email (str) --- Email del proveedor a editar
        Telefono (str) --- Telefono del proveedor a editar
        Direccion (str) --- Direccion del proveedor a editar
        id (int) --- ID del proveedor a editar
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                UPDATE Proveedor SET Nombre=%s,Nit=%s,Correo=%s,Telefono=%s,Direccion=%s
                WHERE ID=%s;''')  
                product_info = (Nombre.upper(),Nit,Email.upper(),Telefono,Direccion.upper(),Id)
                cur.execute(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record updated.")
        except (Exception,Error) as e:
            print(e)

    def anular(self,ID):
        """
        Descripcion:
        Con este metodo podemos anular una factura en la BDD.
        
        Entradas:
        id (int) --- ID de la factura a anular
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                UPDATE Factura SET Estado = 1 WHERE ID = %s;''')  
                cur.execute(add_product,[(ID)])
                self.__connector.commit()
                print(cur.rowcount, "record updated.")
        except (Exception,Error) as e:
            print(e)

    def edit_type(self,Nombre,unit,id):
        """
        Descripcion:
        Con este metodo podemos editar un tipo en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del tipo a editar
        unit (int) --- unidad del tipo a editar (0 o 1) (mts = 1 || unidad = 0)
        id (int) --- id del tipo a editar
        """
        unidad = 1 if unit =="MTS" else  0
        try:
            with self.__connector.cursor() as cur:
                edittype = ('''
                UPDATE Tipo SET Nombre=%s,Unidad=%s WHERE ID=%s;
                ''')  
                info = (Nombre.upper(),unidad,id)
                cur.execute(edittype,info)
                self.__connector.commit()
                print(cur.rowcount, "record Updated.")
        except (Exception,Error) as e:
            print(e)

    def get_supp__proc(self):
        """
        Descripcion:
        Este metodo devuelve todas los proveedores productos en la BDD.

        Salidad:
        devuelve una lista de tuplas con cada producto
        
        [(),(),...] -> list
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT n.ID,Producto.Nombre,Proveedor.Nombre,n.Cantidad,n.Precio,n.Fecha FROM Proveedor_Producto as n
                JOIN Producto ON n.Producto = Producto.ID
                JOIN Proveedor ON n.Proveedor = Proveedor.ID;
                '''
                cur.execute(query)
                result = cur.fetchall()
                field_names = [i[0] for i in cur.description]
                return result,field_names
        except (Exception,Error) as e:
            print(e)

    def add_Client(self,Nombre,Telefono,Direccion,Tipo,ID):
        """
        Descripcion:
        Con este metodo podemos añadir un cliente en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del cliente a añadir
        Telefono (str) --- Telefono del cliente a añadir
        Direccion (str) --- Direccion del cliente a añadir
        Tipo (str) --- Tipo del cliente a añadir
        ID (str) --- ID del cliente a añadir
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Cliente (ID,Tipo,Nombre,Direccion,Telefono) VALUES (%s,%s,%s,%s,%s);
                ''')  
                info_Consulta = (ID,Tipo,Nombre.upper(),Direccion.upper(),Telefono)
                cur.execute(add_product,info_Consulta)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)

    def actualizar_Client(self,Nombre,Telefono,Direccion,Tipo,ID):
        """
        Descripcion:
        Con este metodo podemos editar un cliente en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del cliente a editar
        Telefono (str) --- Telefono del cliente a editar
        Direccion (str) --- Direccion del cliente a editar
        Tipo (str) --- Tipo del cliente a editar
        ID (str) --- ID del cliente a editar
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                UPDATE Cliente SET Tipo=%s,Nombre=%s,Direccion=%s,Telefono=%s WHERE ID=%s
                ''')  
                info_Consulta = (Tipo,Nombre.upper(),Direccion.upper(),Telefono,ID)
                cur.execute(add_product,info_Consulta)
                self.__connector.commit()
                print(cur.rowcount, "record updated.")
        except (Exception,Error) as e:
            print(e)

    def add_Empleado(self,Cedula,Nombre,Edad,Celular,Direccion,Email,Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo):
        """
        Descripcion:
        Con este metodo podemos añadir un empleado en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del empleado a añadir
        Telefono (str) --- Telefono del empleado a añadir
        Direccion (str) --- Direccion del empleado a añadir
        Edad (int) --- Edad del empleado a añadir
        Celular (str) --- Celular del empleado a añadir
        Email (str) --- Email del empleado a añadir
        Fecha_Ingreso (str) --- Fecha_Ingreso del empleado a añadir
        Fecha_Termino (str) --- Fecha_Termino del empleado a añadir
        Salario (str) --- Salario del empleado a añadir
        Contrasena (str) --- Contrasena del empleado a añadir
        Rol (str) --- Rol del empleado a añadir
        Cedula (str) --- Cedula del empleado a añadir
        Activo (int) --- Activo del empleado a añadir
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Empleado (Cedula,Nombre,Edad,Celular,Direccion,Email,Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);
                ''')  
                info_Consulta = (Cedula,Nombre.upper(),Edad,Celular,Direccion.upper(),Email.upper(),Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo)
                cur.execute(add_product,info_Consulta)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)

    def actualizar_Empleado(self,Cedula,Nombre,Edad,Celular,Direccion,Email,Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo):
        """
        Descripcion:
        Con este metodo podemos editar un empleado en la BDD.
        
        Entradas:
        Nombre (str) --- Nombre del empleado a editar
        Telefono (str) --- Telefono del empleado a editar
        Direccion (str) --- Direccion del empleado a editar
        Edad (int) --- Edad del empleado a editar
        Celular (str) --- Celular del empleado a editar
        Email (str) --- Email del empleado a editar
        Fecha_Ingreso (str) --- Fecha_Ingreso del empleado a editar
        Fecha_Termino (str) --- Fecha_Termino del empleado a editar
        Salario (str) --- Salario del empleado a editar
        Contrasena (str) --- Contrasena del empleado a editar
        Rol (str) --- Rol del empleado a editar
        Cedula (str) --- Cedula del empleado a editar
        Activo (int) --- Activo del empleado a editar
        """
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                UPDATE Empleado SET Nombre=%s,Edad=%s,Celular=%s,Direccion=%s,Email=%s,Fecha_Ingreso=%s,Fecha_Termino=%s,Salario=%s,Rol=%s,Contrasena=%s,Activo=%s WHERE Cedula=%s
                ''')  
                info_Consulta = (Nombre.upper(),Edad,Celular,Direccion.upper(),Email.upper(),Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo,Cedula)
                cur.execute(add_product,info_Consulta)
                self.__connector.commit()
                print(cur.rowcount, "record updated.")
        except (Exception,Error) as e:
            print(e)

    #connection and close functions
    def connect(self,User,Password,Host,Database):
        """
        Descripcion:
        Este metodo devuelve la conexion BDD.

        Salidad:
        object -> MySQLConnection 
        """
        try:
            connection = connect(host=Host,user=User,password=Password,database=Database)
            return connection
        except (Exception,Error) as e:
            print(e)

    def close(self):
        """
        Descripcion:
        Con este metodo se puede cerrar la conexion a la BDD.
        """
        try:
            self.__connector.close()
            print("Closing the connection..")
        except (Exception,Error) as e:
            print(e)

    def get_Ventas(self,Mes,Ano):
        """
        Descripcion:
        Con este metodo podemos obtener el total de ventas en un mes dado.
        
        Entradas:
        Mes (str) --- Mes
        Ano (str) --- Ano 
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT SUM(Total) 
                FROM Factura 
                WHERE year(Fecha) = %s AND Estado = 0 AND month(Fecha) = %s;
                '''
                cur.execute(query,[Ano,Mes])
                result = cur.fetchall()
                result = result[0][0]
                return result
        except (Exception,Error) as e:
            print(e)
    
    def get_CountVentas(self,Mes,Ano):
        """
        Descripcion:
        Con este metodo podemos obtener el numero de ventas en un mes dado.
        
        Entradas:
        Mes (str) --- Mes
        Ano (str) --- Ano 
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT Count(*) 
                FROM Factura 
                WHERE year(Fecha) = %s AND Estado = 0 AND month(Fecha) = %s;
                '''
                cur.execute(query,[Ano,Mes])
                result = cur.fetchall()
                result = result[0][0]
                return result
        except (Exception,Error) as e:
            print(e)

    def get_Gastos(self,Mes,Ano):
        """
        Descripcion:
        Con este metodo podemos obtener el total de gastos en un mes dado.
        
        Entradas:
        Mes (str) --- Mes
        Ano (str) --- Año 
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT SUM(Cantidad * Precio) 
                FROM Proveedor_Producto 
                WHERE year(Fecha) = %s AND month(Fecha) = %s;
                '''
                cur.execute(query,[Ano,Mes])
                result = cur.fetchall()
                result = result[0][0]
                return result
        except (Exception,Error) as e:
            print(e)

    def get_ano(self):
        """
        Descripcion:
        Con este metodo podemos obtener años en los cuales se han realizado facturas.
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT year(Fecha) 
                FROM Factura 
                WHERE Estado = 0 
                GROUP BY year(Fecha) 
                UNION 
                SELECT year(Fecha) 
                FROM Proveedor_Producto 
                GROUP BY year(Fecha);
                '''
                cur.execute(query)
                result = cur.fetchall()
                print(result)
                return result
        except (Exception,Error) as e:
            print(e)
    
    def get_mes(self,ano):
        """
        Descripcion:
        Con este metodo podemos obtener los meses en los cuales se han realizado facturas en un año dado.

        Entradas:
        Ano (str) --- Año 
        """
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT month(Fecha) 
                FROM Factura 
                WHERE year(Fecha) = %s and Estado = 0 
                GROUP BY month(Fecha) 
                UNION 
                SELECT month(Fecha) 
                FROM Proveedor_Producto 
                WHERE year(Fecha) = %s 
                GROUP BY month(Fecha);
                '''
                cur.execute(query,[ano,ano])

                result = cur.fetchall()
                return result
        except (Exception,Error) as e:
            print(e)

if __name__ == '__main__':
    bdd = BDD()
    print(bdd.get_employee("1001512392","45753745356779379"))
    print(bdd.get_products())
    print(bdd.get_Factura())
    print(bdd.get_Factura_ID())
    bdd.close()