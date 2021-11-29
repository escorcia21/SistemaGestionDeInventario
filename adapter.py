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


class Adapter(Target):

    def __init__(self):
        self.__adaptee = BDD()

    def datosJSON(self,datos) -> str:pass

    def obtenerProductosJSON(self) -> str:
        try:
            result = self.__adaptee.get_products()
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'Product{i}']=({"idd":row[0],"article":row[1],"category":row[2],"price":row[3],"stock":row[4]})

            return json.dumps(mydict)
        except Exception as e:
            print(e)


    def obtenerTiposJSON(self) -> str:
        try:
            result = self.__adaptee.get_types()
            mydict = {}
            for i,row in enumerate(result):
                unidad = "MTS" if row[2] == 1 else "UNIDAD"
                mydict[f'Type{i}']=({"ID":row[0],"Nombre":row[1],"Unidad":unidad})

            return json.dumps(mydict)
        except Exception as e:
            print(e)

    def obtenerProveedoresJSON(self) -> str:
        try:
            result = self.__adaptee.get_supp()
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'Supp{i}']=({"ID":row[0],"Nombre":row[1],"NIT":row[2],"Correo":row[3],"Direccion":row[4],"Telefono":row[5]})

            return json.dumps(mydict)
        except Exception as e:
            print(e)
    
    def obtenerFacturaID(self) -> str:
        try:
            result = self.__adaptee.get_Factura_ID()
            mydict = {}
            for i,row in enumerate(result):
                mydict[f'IDFac{i}']=({"ID":row[0]})
            #print(mydict)
            return json.dumps(mydict)
        except Exception as e:
            print(e)

    def obtenerVentasJSON(self) -> str:pass

    def obtenerCotizacionesJSON(self) -> str:pass

    def obtenerInformesJSON(self) -> str:pass

    def obtenerProveedoresProductosJSON(self) -> str:
        try:
            data,fields = self.__adaptee.get_supp__proc()

            mydict = {}
            for i,row in enumerate(data):
                mydict[f'Supp_Prod{i}']=({'ID':row[0], 'Producto':row[1], 'Proveedor':row[2],'Cantidad':row[3], 'Precio':row[4], 'Fecha':row[5].strftime("%d/%m/%Y ")})

            return json.dumps(mydict),fields
        except Exception as e:
            print(e)

    def obtenerFacturaJSON(self) -> str:
        result = self.__adaptee.get_Factura()
        
        mydict = {}
        
        for i,row in enumerate(result):
            Estado = "LISTA" if row[5] == 0 else "ANULADA"
            mydict[f'Factura{i}']=({"ID":row[0],"Vendedor":row[1],"Cliente":row[2],"Fecha":row[3].strftime("%d/%m/%Y "),"Total":row[4],"Estado":Estado})
        
        return json.dumps(mydict)
    
    def obtenerFacturaListaJSON(self,ID) -> str:
        result = self.__adaptee.get_FacturaLista(ID)
        
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'FacturaLista{i}']=({"ID":row[0],"Producto":row[1],"Cantidad":row[2],"Precio":row[3],"Total":row[4]})
        
        return json.dumps(mydict)

    def obtenerFacturaTotalJSON(self,ID) -> str:
        result = self.__adaptee.get_FacturaTotal(ID)
        
        mydict = {}
        for i,row in enumerate(result):
            mydict[f'FacturaTotal{i}']=({"Total":row[0]})
        
        return json.dumps(mydict)

    def obtenerClienteJSON(self) -> str:
        result = self.__adaptee.get_client()
        
        mydict = {}
        for i,row in enumerate(result):
            Tipo = "EMPRESA" if row[1] == 0 else "PERSONA"
            mydict[f'Client{i}']=({"ID":row[0],"Tipo":Tipo,"Nombre":row[2],"Direccion":row[3],"Telefono":row[4]})
        return json.dumps(mydict)

    def obtenerEmpleadoJSON(self) -> str:
        result = self.__adaptee.get_empleado()
        mydict = {}
        for i,row in enumerate(result):

            Activo = "ACTIVO" if row[11] == 0 else "RETIRADO"

            if None == row[7]:
                Final_Termino = "-"
            else:
                Final_Termino = row[7].strftime("%d/%m/%Y ")
            mydict[f'Emple{i}']=({"Cedula":row[0],"Nombre":row[1],"Edad":row[2],"Celular":row[3],"Direccion":row[4],"Email":row[5],"Ingreso":row[6].strftime("%d/%m/%Y "),"Termino":Final_Termino,"Salario":row[8],"Rol":row[9],"Contrasena":row[10],"Activo":Activo})

        return json.dumps(mydict)

    def close(self):
        self.__adaptee.close()


if __name__ == "__main__":
    a = Adapter()
    print(a.obtenerEmpleadoJSON())
    a.close()