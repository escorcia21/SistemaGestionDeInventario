from abc import ABC, abstractmethod
from DBConnection import BDD
import json

class Target(ABC):
    """
    The Target defines the domain-specific interface used by the client code.
    """
    @abstractmethod
    def datosJSON(self,datos) -> str:pass
    @abstractmethod
    def obtenerProductosJSON(self) -> str:pass
    @abstractmethod
    def obtenerTiposJSON(self) -> str:pass
    @abstractmethod
    def obtenerProveedoresJSON(self) -> str:pass
    @abstractmethod
    def obtenerVentasJSON(self) -> str:pass
    @abstractmethod
    def obtenerCotizacionesJSON(self) -> str:pass
    @abstractmethod
    def obtenerInformesJSON(self) -> str:pass
    @abstractmethod
    def obtenerEmpleadosJSON(self) -> str:pass
    @abstractmethod
    def obtenerProveedoresProductosJSON(self) -> str:pass


class Adapter(Target):

    def __init__(self):
        self.__adaptee = BDD()

    def datosJSON(self,datos) -> str:pass

    def obtenerProductosJSON(self) -> str:
        result = self.__adaptee.get_products()
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'Product{i}']=({"idd":row[0],"article":row[1],"category":row[2],"price":f"${row[3]}","stock":row[4]})

        return json.dumps(mydict)


    def obtenerTiposJSON(self) -> str:
        result = self.__adaptee.get_types()
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'Type{i}']=({"idd":row[0],"Nombre":row[1]})

        return json.dumps(mydict)

    def obtenerProveedoresJSON(self) -> str:
        result = self.__adaptee.get_supp()
        
        # 1, 'SOLDISEE S.A.S.', '900436084-5', 'Almacen@Soldisee.com.co', 'Cl. 49 #67-105', 123456789
        #'ID', 'Nombre', 'NIT', 'Correo', 'Direccion', 'Telefono'
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'Supp{i}']=({"ID":row[0],"Nombre":row[1],"NIT":row[2],"Correo":row[3],"Direccion":row[4],"Telefono":row[5]})

        return json.dumps(mydict)

    def obtenerVentasJSON(self) -> str:pass

    def obtenerCotizacionesJSON(self) -> str:pass

    def obtenerInformesJSON(self) -> str:pass

    def obtenerEmpleadosJSON(self) -> str:pass

    def obtenerProveedoresProductosJSON(self) -> str:
        data,fields = self.__adaptee.get_supp__proc()

        mydict = {}
        for i,row in enumerate(data):
            mydict[f'Supp_Prod{i}']=({'ID':row[0], 'Producto':row[1], 'Proveedor':row[2],'Cantidad':row[3], 'Precio':row[4], 'Fecha':row[5].strftime("%d/%b/%Y ")})

        return json.dumps(mydict),fields
        

    def close(self):
        self.__adaptee.close()


if __name__ == "__main__":
    a = Adapter()
    print(a.obtenerProveedoresProductosJSON())
    a.close()