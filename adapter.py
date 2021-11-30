from abc import ABC, abstractmethod
from DBConnection import BDD
import json

class Target(ABC):
    """
    Este clase abstracta plantea la interfaz por la cual pasaran los datos de la BDD, para si poder convertirlos en un objeto JSON, formato en el cual se representan los datos en las vistas QML 
    """
    @abstractmethod
    def obtenerProductosJSON(self) -> str:pass
    @abstractmethod
    def obtenerTiposJSON(self) -> str:pass
    @abstractmethod
    def obtenerProveedoresJSON(self) -> str:pass
    @abstractmethod
    def obtenerClienteJSON(self) -> str:pass
    @abstractmethod
    def obtenerEmpleadoJSON(self) -> str:pass
    @abstractmethod
    def obtenerFacturaJSON(self) -> str:pass
    @abstractmethod
    def obtenerFacturaID(self) -> str:pass
    @abstractmethod
    def obtenerProveedoresProductosJSON(self) -> str:pass
    @abstractmethod
    def obtenerFacturaListaJSON(self) -> str:pass
    @abstractmethod
    def obtenerFacturaTotalJSON(self) -> str:pass
    @abstractmethod
    def obtenerAnoJSON(self) -> str:pass
    @abstractmethod
    def obtenerMesJSON(self) -> str:pass


class Adapter(Target):

    def __init__(self):
        """
        Descripcion:
        Se inicializa el objeto BDD() es cual es una clase singleton por lo cual esta instancia siempre sera la misma en todo el programa. La funcion es proporcionar la conexcion a la base de datos.
        """
        self.__adaptee = BDD()

    def obtenerProductosJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen los productos y se adaptan a formato JSON.

        Salidas:\n
        {
            "Product0": {
                "article": "TORNILLO M.2",
                "category": "TORNILLO",   
                "idd": 24,
                "price": 1000,
                "stock": 11
            },
            "Product1": {
                "article": "TUBO EMT 3\"",
                "category": "TUBO",       
                "idd": 26,
                "price": 15500,
                "stock": 20
            }
        }
        """
        try:
            result = self.__adaptee.get_products()
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'Product{i}']=({"idd":row[0],"article":row[1],"category":row[2],"price":row[3],"stock":row[4]})

            return json.dumps(mydict, sort_keys=True, indent=4)
        except Exception as e:
            print(e)


    def obtenerTiposJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen los tipos y se adaptan a formato JSON.

        Salidas:\n
        {
            "Type0": {
                "ID": 5,
                "Nombre": "CHAZO",
                "Unidad": "UNIDAD"
            },
            "Type1": {
                "ID": 6,
                "Nombre": "CINTA",
                "Unidad": "MTS"
            }
        }
        """
        try:
            result = self.__adaptee.get_types()
            mydict = {}
            for i,row in enumerate(result):
                unidad = "MTS" if row[2] == 1 else "UNIDAD"
                mydict[f'Type{i}']=({"ID":row[0],"Nombre":row[1],"Unidad":unidad})

            return json.dumps(mydict, sort_keys=True, indent=4)
        except Exception as e:
            print(e)

    def obtenerProveedoresJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen los Proveedores y se adaptan a formato JSON.

        Salidas:\n
        {
            "Supp0": {
                "Correo": "ENERGIAS@GMAIL.COM",
                "Direccion": "CR14 #45-09",
                "ID": 3,
                "NIT": "213129591-1",
                "Nombre": "ENERGIAS POSITIVAS",
                "Telefono": 134434234
            },
            "Supp1": {
                "Correo": "TUBOSCARIBE@HOTMAIL.COM",
                "Direccion": "VIA 40 CR 14A #45-90",
                "ID": 4,
                "NIT": "23123132-1",
                "Nombre": "TUBOS S.A.S",
                "Telefono": 313232132
            }
        }
        """
        try:
            result = self.__adaptee.get_supp()
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'Supp{i}']=({"ID":row[0],"Nombre":row[1],"NIT":row[2],"Correo":row[3],"Direccion":row[4],"Telefono":row[5]})

            return json.dumps(mydict, sort_keys=True, indent=4)
        except Exception as e:
            print(e)
    
    def obtenerFacturaID(self) -> str:
        """
        Descripcion:
        Con este metodo se optiene el ID de la ultima factura y se adaptan a formato JSON.

        Salidas:\n
        {
            "IDFac0": {
                "ID": 24,
            }
        }
        """
        try:
            result = self.__adaptee.get_Factura_ID()
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'IDFac{i}']=({"ID":row[0]})
            #print(mydict)
            return json.dumps(mydict, sort_keys=True, indent=4)
        except Exception as e:
            print(e)

    def obtenerProveedoresProductosJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen los Proveedores,Productos y se adaptan a formato JSON.

        Salidas:\n
        {
            "Supp_Prod0": {
                "Cantidad": 10,
                "Fecha": "18/11/2021 ",    
                "ID": 9,
                "Precio": 12000,
                "Producto": "TORNILLO M.2",
                "Proveedor": "TUBOS S.A.S" 
            },
            "Supp_Prod1": {
                "Cantidad": 1,
                "Fecha": "18/11/2021 ",    
                "ID": 10,
                "Precio": 12000,
                "Producto": "TORNILLO M.2",
                "Proveedor": "TUBOS S.A.S" 
            }
        }
        """
        try:
            data,fields = self.__adaptee.get_supp__proc()

            mydict = {}
            for i,row in enumerate(data):
                mydict[f'Supp_Prod{i}']=({'ID':row[0], 'Producto':row[1], 'Proveedor':row[2],'Cantidad':row[3], 'Precio':row[4], 'Fecha':row[5].strftime("%d/%m/%Y ")})

            return json.dumps(mydict, sort_keys=True, indent=4),fields
        except Exception as e:
            print(e)

    def obtenerFacturaJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen las facturas y se adaptan a formato JSON.

        Salidas:\n
        {
            "Factura0": {
                "Cliente": "LUBRIPARTES S.A",
                "Estado": "ANULADA",
                "Fecha": "15/10/2021 ",
                "ID": 23,
                "Total": "5950",
                "Vendedor": "DAN LOPEZ"
            },
            "Factura1": {
                "Cliente": "ALCATRAZ",
                "Estado": "LISTA",
                "Fecha": "21/11/2021 ",
                "ID": 24,
                "Total": "946645",
                "Vendedor": "DAN LOPEZ"
            }
        }
        """
        result = self.__adaptee.get_Factura()
        
        mydict = {}
        
        for i,row in enumerate(result):
            Estado = "LISTA" if row[5] == 0 else "ANULADA"
            mydict[f'Factura{i}']=({"ID":row[0],"Vendedor":row[1],"Cliente":row[2],"Fecha":row[3].strftime("%d/%m/%Y "),"Total":row[4],"Estado":Estado})
        
        return json.dumps(mydict, sort_keys=True, indent=4)
    
    def obtenerFacturaListaJSON(self,ID) -> str:
        """
        Descripcion:
        Con este metodo se optienen los productos con el id de factura dado y se adaptan a formato JSON.

        Entradas
        ID ---- ID de la factura a buscar

        Salidas:\n
        {
            "FacturaLista0": {
                "Cantidad": 5,
                "ID": 24,
                "Precio": "1000",
                "Producto": "TORNILLO M.2",
                "Total": "5000"
            },
            "FacturaLista1": {
                "Cantidad": 51,
                "ID": 26,
                "Precio": "15500",
                "Producto": "TUBO EMT 3\"",
                "Total": "790500"
            }
        }
        """
        result = self.__adaptee.get_FacturaLista(ID)
        
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'FacturaLista{i}']=({"ID":row[0],"Producto":row[1],"Cantidad":row[2],"Precio":row[3],"Total":row[4]})
        
        return json.dumps(mydict, sort_keys=True, indent=4)

    def obtenerFacturaTotalJSON(self,ID) -> str:
        """
        Descripcion:
        Con este metodo se optiene el total de la factura y se adapta a formato JSON.

        Entradas
        ID ---- ID de la factura a buscar

        Salidas:\n
        {
            "FacturaTotal0": {
                "Total": 795500.0
            }
        }
        """
        result = self.__adaptee.get_FacturaTotal(ID)
        
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'FacturaTotal{i}']=({"Total":row[0]})
        
        return json.dumps(mydict, sort_keys=True, indent=4)

    def obtenerClienteJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen todos los clientes y se adaptan a formato JSON.

        Salidas:\n
        {
            "Client0": {
                "Direccion": "CR 43 #69-90",
                "ID": "1001916251",
                "Nombre": "DANIEL LOPEZ POLO",
                "Telefono": "918918988",
                "Tipo": "PERSONA"
            },
            "Client1": {
                "Direccion": "CR 5 #36-65",
                "ID": "788189192-5",
                "Nombre": "LUBRIPARTES S.A",
                "Telefono": "456464646",
                "Tipo": "EMPRESA"
            }
        }
        """
        result = self.__adaptee.get_client()
        
        mydict = {}
        for i,row in enumerate(result):
            Tipo = "EMPRESA" if row[1] == 0 else "PERSONA"
            mydict[f'Client{i}']=({"ID":row[0],"Tipo":Tipo,"Nombre":row[2],"Direccion":row[3],"Telefono":row[4]})
        return json.dumps(mydict, sort_keys=True, indent=4)

    def obtenerEmpleadoJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen todos los empleados y se adaptan a formato JSON.

        Salidas:\n
        {
            "Emple0": {
                "Activo": "ACTIVO",
                "Cedula": "1001512392",
                "Celular": "3011229596",
                "Contrasena": "45753745356779379",
                "Direccion": "CR 8 #9-10",
                "Edad": 15,
                "Email": "ANTCARLOS@HOTMAIL.COM",
                "Ingreso": "12/01/2021 ",
                "Nombre": "CARLOS ANTORNIO",
                "Rol": "VENDEDOR",
                "Salario": 550000,
                "Termino": "-"
            }
        }
        """

        result = self.__adaptee.get_empleado()
        mydict = {}
        for i,row in enumerate(result):

            Activo = "ACTIVO" if row[11] == 0 else "RETIRADO"

            if None == row[7]:
                Final_Termino = "-"
            else:
                Final_Termino = row[7].strftime("%d/%m/%Y ")
            mydict[f'Emple{i}']=({"Cedula":row[0],"Nombre":row[1],"Edad":row[2],"Celular":row[3],"Direccion":row[4],"Email":row[5],"Ingreso":row[6].strftime("%d/%m/%Y "),"Termino":Final_Termino,"Salario":row[8],"Rol":row[9],"Contrasena":row[10],"Activo":Activo})

        return json.dumps(mydict, sort_keys=True, indent=4)

    def obtenerAnoJSON(self) -> str:
        """
        Descripcion:
        Con este metodo se optienen todos los años en los cuales
        se han hecho ventas y se adaptan a formato JSON.

        Salidas:\n
        {
            "AnoList0": {
                "ID": 0,
                "ano": 2021
            },
            "AnoList1": {
                "ID": 1,
                "ano": 2020
            },
            "AnoList2": {
                "ID": 2,
                "ano": 2011
            }
        }
        """
        try:
            result = self.__adaptee.get_ano()
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'AnoList{i}']=({"ID":i,"ano":row[0]})

            return json.dumps(mydict, sort_keys=True, indent=4)
        except Exception as e:
            print(e)
    
    def obtenerMesJSON(self,ano) -> str:
        """
        Descripcion:
        Con este metodo se optienen todos los meses en los cuales
        se han hecho ventas y se adaptan a formato JSON.

        Salidas:\n
        {
            "MesList0": {
                "ID": 0,
                "Mes": 11
            }
        }
        """
        try:
            result = self.__adaptee.get_mes(ano)
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'MesList{i}']=({"ID":i,"Mes":row[0]})
            return json.dumps(mydict, sort_keys=True, indent=4)
        except Exception as e:
            print(e)
            
    def close(self):
        """
        Con este metodo se cierra la conexion en la base de datos.
        """
        self.__adaptee.close()


if __name__ == "__main__":
    a = Adapter()
    print(a.obtenerProductosJSON())
    print(a.obtenerTiposJSON())
    print(a.obtenerProveedoresJSON())
    print(a.obtenerClienteJSON())
    print(a.obtenerEmpleadoJSON())
    print(a.obtenerFacturaJSON())
    print(a.obtenerFacturaID())
    print(a.obtenerProveedoresProductosJSON()[0])
    print(a.obtenerFacturaListaJSON("24"))
    print(a.obtenerFacturaTotalJSON("24"))
    print(a.obtenerAnoJSON())
    print(a.obtenerMesJSON("2021"))
    a.close()