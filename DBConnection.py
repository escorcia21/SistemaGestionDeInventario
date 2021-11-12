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
        except Error as e:
            print(e)

    #Methods of the Object DB
    def show_tables(self):
        mycursor  = self.__connector.cursor()
        show_db_query = "SHOW TABLES"
        mycursor.execute(show_db_query)
        for x in mycursor:
            print(x)

    def get_products(self):
        try:
            with self.__connector.cursor() as cur:
                show_db_query = '''
                SELECT Producto.ID AS idd, Producto.Nombre AS Producto, Tipo.Nombre AS categoria, Producto.Precio, Producto.Stock FROM Producto 
                INNER JOIN Tipo ON Producto.Tipo=Tipo.ID 
                '''
                # INNER JOIN Proveedor_Producto ON Producto.ID=Proveedor_Producto.Producto 
                # INNER JOIN Proveedor ON Proveedor_Producto.Proveedor=Proveedor.ID;
                cur.execute(show_db_query)
                result = cur.fetchall()
                #print(result)
                return result
        except Error as e:
            print(e)
            

    def get_types(self):
        mycursor  = self.__connector.cursor()
        show_db_query = '''
        SELECT ID,Nombre From Tipo;
        '''
        mycursor.execute(show_db_query)
        result = mycursor.fetchall()
        return result

    def get_supp(self):
        mycursor  = self.__connector.cursor()
        show_db_query = '''
        SELECT ID,Nombre From Proveedor;
        '''
        mycursor.execute(show_db_query)
        result = mycursor.fetchall()
        return result

    def add_Products(self,Nombre,Tipo,Precio):
        
        try:
            with self.__connector.cursor() as cur:
                add_product = ('''
                INSERT INTO Producto (Nombre,Stock,Precio,Tipo) VALUES (%s,%s,%s,%s);
                ''')  
                product_info = (Nombre,0,Precio,Tipo)
                cur.execute(add_product, product_info)
                self.__connector.commit()
                print(cur.rowcount, "record inserted.")
        except Error as e:
            print(e)

    def get_supp__proc(self):
        mycursor  = self.__connector.cursor()
        show_db_query = '''
        SELECT * FROM Proveedor_Producto;
        '''
        mycursor.execute(show_db_query)
        result = mycursor.fetchall()
        return result


    #connection and close functions
    def connect(self,User,Password,Host,Database):
        connection = connect(host=Host,user=User,password=Password,database=Database)
        return connection

    def close(self):
        self.__connector.close()




if __name__ == '__main__':

    bdd = BDD()
    print(bdd.get_supp__proc())
    bddd = BDD()

    
