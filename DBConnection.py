from mysql.connector import connect,Error
from threading import Lock
from datetime import datetime

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
                # INNER JOIN Proveedor_Producto ON Producto.ID=Proveedor_Producto.Producto 
                # INNER JOIN Proveedor ON Proveedor_Producto.Proveedor=Proveedor.ID;
                cur.execute(query)
                result = cur.fetchall()
                return result
        except  (Exception,Error) as e:
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
                product_info = (Nombre,Precio,Tipo,id)
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
                product_info = (Nombre,0,Precio,Tipo)
                cur.execute(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except (Exception,Error) as e:
            print(e)

    def add_Type(self,Nombre,unit):
        unidad = 1 if unit =="Mts" else  0
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Tipo (Nombre,Unidad) VALUES (%s,%s);
                ''')  
                product_info = (Nombre,unidad)
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
                product_info = (Nombre,Nit,Email,Telefono,Direccion)
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
                product_info = (Nombre,Nit,Email,Telefono,Direccion,Id)
                cur.execute(add_product,product_info)
                self.__connector.commit()
                print(cur.rowcount, "record updated.")
        except (Exception,Error) as e:
            print(e)

    def edit_type(self,Nombre,unit,id):
        unidad = 1 if unit =="Mts" else  0
        try:
            with self.__connector.cursor() as cur:
                edittype = ('''
                UPDATE Tipo SET Nombre=%s,Unidad=%s WHERE ID=%s;
                ''')  
                info = (Nombre,unidad,id)
                cur.execute(edittype,info)
                self.__connector.commit()
                print(cur.rowcount, "record Updated.")
        except (Exception,Error) as e:
            print(e)

    def get_supp__proc(self):
        try:
            with self.__connector.cursor() as cur:
                query = '''
                SELECT * FROM Proveedor_Producto;
                '''
                cur.execute(query)
                result = cur.fetchall()
                field_names = [i[0] for i in cur.description]
                return result,field_names
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
    #print(bdd.show_tables())
    #print(bdd.get_products())
    #print(bdd.get_supp__proc())
    #print(bdd.get_types())
    print(bdd.get_types())
    bdd.close()

    
