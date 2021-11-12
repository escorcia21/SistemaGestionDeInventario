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
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'Supp{i}']=({"idd":row[0],"Nombre":row[1]})

        return json.dumps(mydict)

    def obtenerVentasJSON(self) -> str:pass

    def obtenerCotizacionesJSON(self) -> str:pass

    def obtenerInformesJSON(self) -> str:pass

    def obtenerEmpleadosJSON(self) -> str:pass


if __name__ == "__main__":
    a = Adapter()
    print(a.obtenerTiposJSON(),type(a.obtenerTiposJSON()))