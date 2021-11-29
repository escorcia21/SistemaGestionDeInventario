from mysql.connector import connect,Error
from threading import Lock

class Singleton(type):
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
    DB object, allow to use the database and all
    related about CRUD"""

    def __init__(self,User="upwtmxvvdgk7cceh",Password="RVzMgKsE7ZMrFWHr7KZC",Host="bp1hnbrwyl47lbil4s65-mysql.services.clever-cloud.com", Database="bp1hnbrwyl47lbil4s65"):
        try:
            self.__connector = self.connect(User,Password,Host,Database)
        except (Exception,Error) as e:
            print(e)

    #Methods of the Object DB
    def get_employee(self,usuario, contraseña):
        try:
            with self.__connector.cursor() as cur:
                query = "SELECT * FROM Empleado WHERE Cedula=%s AND Contrasena=%s AND Activo=%s"
                cur.execute(query,[usuario,contraseña,0])
                result = cur.fetchone()
                return result
        except (Exception,Error) as e:
            print(e)

    
    def show_tables(self):
        try:
            with self.__connector.cursor() as cur:
                query = "SHOW TABLES"
                cur.execute(query)
                result = cur.fetchall()
                return result
        except (Exception,Error) as e:
            print(e)

    def get_products(self):
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
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT max(ID) from Factura
                '''
                cur.execute(query)
                result = cur.fetchall()
                #print(result)
                return result
        except Error as e:
            print(e)

    def get_client(self):
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
        try:
            connection = connect(host=Host,user=User,password=Password,database=Database)
            return connection
        except (Exception,Error) as e:
            print(e)

    def close(self):
        try:
            self.__connector.close()
            print("Closing the connection..")
        except (Exception,Error) as e:
            print(e)


if __name__ == '__main__':
    bdd = BDD()
    print(bdd.get_employee("1001512392","45753745356779379"))
    bdd.close()