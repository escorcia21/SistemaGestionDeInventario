#!/usr/bin/python
# This Python file uses the following encoding: utf-8
import sys
from os import environ,path
#import cv2
from adapter import Adapter
from DBConnection import BDD
from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal,Qt
import json
from informe import informe


class MainWindow(QObject):
    def __init__(self,bdd:BDD,adapter:Adapter,engine):
        self.cont = 0
        QObject.__init__(self)
        self.dbc = bdd
        self.adapter = adapter
        self.engine = engine

    #user
    @Slot(str,str)
    def login(self,nombre,contraseña):
        user = self.dbc.get_employee(nombre,contraseña)
        rol = None
        if user:
            rol = user[9]
            if rol=="BODEGUERO":
                engine.rootObjects()[0].close()
                engine.load(path.join(path.dirname(__file__), "qml/bodeguero.qml"))
                main.setBD()
                main.setPageSupp()
                main.setTypes()
                main.setPageSuppPord()
            elif rol=="ADMINISTRADOR":
                engine.rootObjects()[0].close()
                engine.load(path.join(path.dirname(__file__), "qml/main.qml"))
                main.setBD()
                main.setPageSupp()
                main.setTypes()
                main.setPageSuppPord()
                main.setPageEmpleado()
                main.setPageClient()
                main.setPageFactura()
                main.setAnoCombobox()
            elif rol=="VENDEDOR":
                engine.rootObjects()[0].close()
                engine.load(path.join(path.dirname(__file__), "qml/vendedor.qml"))
                main.setBD()
                main.setTypes()
                main.setPageFactura()

    #init the bd
    initialize =Signal(str)
    def setBD(self):
        a = self.adapter.obtenerProductosJSON()
        self.initialize.emit(a)

    pageSupplier = Signal(str)
    def setPageSupp(self):
        a = self.adapter.obtenerProveedoresJSON()
        self.pageSupplier.emit(a)

    pageSupplierProd = Signal(str,list)
    def setPageSuppPord(self):
        try:
            a,b = self.adapter.obtenerProveedoresProductosJSON()
            self.pageSupplierProd.emit(a,b)
        except Exception as e:
            print(e)

    pageFactura = Signal(str)
    def setPageFactura(self):
        a = self.adapter.obtenerFacturaJSON()
        self.pageFactura.emit(a)
    
    pageFacturaLista = Signal(str)
    @Slot(str)
    def setPageFacturaLista(self,ID):
        a = self.adapter.obtenerFacturaListaJSON(ID)
        self.pageFacturaLista.emit(a)

    pageFacturaTotal = Signal(str)
    @Slot(str)
    def setPageFacturaTotal(self,ID):
        a = self.adapter.obtenerFacturaTotalJSON(ID)
        self.pageFacturaTotal.emit(a)

    pageClient = Signal(str)
    def setPageClient(self):
        a = self.adapter.obtenerClienteJSON()
        self.pageClient.emit(a)

    pageEmpleado = Signal(str)
    def setPageEmpleado(self):
        a = self.adapter.obtenerEmpleadoJSON()
        self.pageEmpleado.emit(a)

    @Slot(str,str)
    def addType(self,Name,unit):
        self.dbc.add_Type(Name,unit)

    types =Signal(str)
    def setTypes(self):
        a = self.adapter.obtenerTiposJSON()
        self.types.emit(a)

    # target backend
    @Slot()
    def close(self):
        self.dbc.close()

    @Slot(str,str,int)
    def editType(self,name,unit,id):
        self.dbc.edit_type(name,unit,id)

    @Slot(int,str,int,str)
    def actualizarProducto(self,id,Nombre,Tipo,Precio):

        self.dbc.edit_product(id,Nombre,Tipo,int(Precio))
        self.setBD()

    @Slot(str,int,str)
    def agregarProducto(self,Nombre,Tipo,Precio):
        self.dbc.add_Products(Nombre,Tipo,int(Precio))
        self.setBD()

    @Slot(str,str,str,str,str)
    def agregarProveedor(self,Nombre,Nit,Email,Telefono,Direccion):
        self.dbc.add_Supplier(Nombre,Nit,Email,int(Telefono),Direccion)
        self.setPageSupp()

    @Slot(str,str,str,str)
    def agregarFactura(self,Vendedor,Cliente,Fecha,Total):
        Fecha = Fecha.split("/")
        Fecha = Fecha[::-1]
        Fecha = "-".join(Fecha)
        self.dbc.add_Factura(Vendedor,Cliente,Fecha,Total)
        self.setPageFactura()
    
    @Slot(str,str)
    def agregarFacturaDetalle(self,ID,jaison):
        temp = json.loads(jaison)
        self.dbc.add_Factura_Detalle(ID,temp)
        self.setPageFactura()

    @Slot(str,str,str,str,str)
    def actualizarCliente(self,Nombre,Telefono,Direccion,Tipo,ID):
        self.dbc.actualizar_Client(Nombre,Telefono,Direccion,Tipo,ID)
        self.setPageClient()

    @Slot(str,str,str,str,str)
    def agregarCliente(self,Nombre,Telefono,Direccion,Tipo,ID):
        self.dbc.add_Client(Nombre,Telefono,Direccion,Tipo,ID)
        self.setPageClient()

    @Slot(str,str,str,str,str)
    def actualizarCliente(self,Nombre,Telefono,Direccion,Tipo,ID):
        self.dbc.actualizar_Client(Nombre,Telefono,Direccion,Tipo,ID)
        self.setPageClient()
    
    @Slot(str,str,str,str,str,str,str,str,str,str,str,str)
    def agregarEmpleado(self,Cedula,Nombre,Edad,Celular,Direccion,Email,Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo):
        if Fecha_Termino == "//":
            Fecha_Termino = Fecha_Termino.replace("//","00/00/0000")
        else:
            Fecha_Termino = Fecha_Termino.split("/")
            Fecha_Termino = Fecha_Termino[::-1]
            Fecha_Termino = "-".join(Fecha_Termino)

        Fecha_Ingreso = Fecha_Ingreso.split("/")
        Fecha_Ingreso = Fecha_Ingreso[::-1]
        Fecha_Ingreso = "-".join(Fecha_Ingreso)

        self.dbc.add_Empleado(Cedula,Nombre,Edad,Celular,Direccion,Email,Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo)
        self.setPageEmpleado()

    @Slot(str,str,str,str,str,str,str,str,str,str,str,str)
    def actualizarEmpleado(self,Cedula,Nombre,Edad,Celular,Direccion,Email,Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo):
        if Fecha_Termino == "//":
            Fecha_Termino = Fecha_Termino.replace("//","00/00/0000")
        else:
            Fecha_Termino = Fecha_Termino.split("/")
            Fecha_Termino = Fecha_Termino[::-1]
            Fecha_Termino = "-".join(Fecha_Termino)

        Fecha_Ingreso = Fecha_Ingreso.split("/")
        Fecha_Ingreso = Fecha_Ingreso[::-1]
        Fecha_Ingreso = "-".join(Fecha_Ingreso)

        self.dbc.actualizar_Empleado(Cedula,Nombre,Edad,Celular,Direccion,Email,Fecha_Ingreso,Fecha_Termino,Salario,Rol,Contrasena,Activo)
        self.setPageEmpleado()

    @Slot(str)
    def anularFactura(self,ID):
        self.dbc.anular(ID)
        self.setPageFactura()

    @Slot(int,int,str,str,str)
    def addSupplierProduct(self,product,supplier,Amount,Price,Date):
        Date = Date.split("/")
        Date = Date[::-1]
        Date = "-".join(Date)
        self.dbc.addSupplier_Product(product,supplier,int(Amount),int(Price),Date)
        self.setPageSuppPord()
        self.setBD()
    
    setSProdCombo = Signal(str)
    @Slot()
    def setSuppCombo(self):
        a = self.adapter.obtenerProveedoresJSON()
        self.setSProdCombo.emit(a)


    
    setClienteCombo = Signal(str)
    @Slot()
    def setClienteCombox(self):
        a = self.adapter.obtenerClienteJSON()
        self.setClienteCombo.emit(a)
    
    setEmpleadoCombo = Signal(str)
    @Slot()
    def setEmpleadoCombox(self):
        a = self.adapter.obtenerEmpleadoJSON()
        self.setEmpleadoCombo.emit(a)

    setProdCombo = Signal(str)
    @Slot()
    def setProdComboBox(self):
        a = self.adapter.obtenerProductosJSON()
        self.setProdCombo.emit(a)

    listTypes = Signal(str)
    @Slot()
    def setListTypes(self):
        a = self.adapter.obtenerTiposJSON()
        self.listTypes.emit(a)

    setAddTypes = Signal(str)
    @Slot()
    def setAddPopUPTypes(self):
        a = self.adapter.obtenerTiposJSON()
        self.listTypes.emit(a)
        self.setAddTypes.emit(a)
        self.types.emit(a)
        

    listSupp = Signal(str)
    @Slot()
    def setSupp(self):
        a = self.adapter.obtenerProveedoresJSON()
        self.listSupp.emit(a)
        #self.setAddPopUPTypes()
    
    setfacturaID = Signal(str)
    @Slot()
    def setFactura_ID(self):
        a = self.adapter.obtenerFacturaID()
        self.setfacturaID.emit(a)
        #self.setAddPopUPTypes()

    change = Signal(str,int)
    @Slot(str,int)
    def onChangeImage(self,imgUrl,id):
        print(imgUrl,id)
        # name = imgUrl.replace("file:///","")
        # src = cv2.imread(name, cv2.IMREAD_UNCHANGED)
        # scale_percent = 50
        # name = name.split('/')
        # name = name[len(name) - 1]

        # #calculate the 50 percent of original dimensions
        # width = int(src.shape[1] * (scale_percent + 20 )/ 100)
        # height = int(src.shape[0] * scale_percent / 100)

        # # dsize
        # dsize = (width, height)

        # # resize image
        # output = cv2.resize(src, dsize)
        # proc = 'file:///'
        # path = f'C:\\Users\\pedro\\Documents\\pharmacy_py\\backend\\sources\\{name}'
        # proc += path
        # cv2.imwrite(path,output)
        # self.change.emit(proc,id)

    add = Signal(int,int)
    @Slot(int,int)
    def addToCart(self,item,quantity):
        self.add.emit(item,quantity)

    recived = Signal(QObject,int)
    @Slot(QObject,int)
    def send(self,item,quantity):
        self.recived.emit(item,quantity)

    setTotal = Signal(int,int)
    @Slot(int,int)
    def changeTotal(self,csvalue,pk):
        self.setTotal.emit(csvalue,pk)

    cartListDelete = Signal(int)
    @Slot(int)
    def deleteFrom(self,item_id):
        self.cartListDelete.emit(item_id)

    clearList = Signal()
    @Slot()
    def deleteOrder(self):
        self.clearList.emit()

    setGenerar = Signal()
    @Slot(str,str)
    def setGenerarInforme(self,Mes,Ano):
        #a = self.adapter.obtenerProveedoresJSON()
        #self.setGenerar.emit(a)
        print("Generar Factura")
        if len(Mes) == 1:
            Mes = "0"+Mes
        
        Ventas = self.dbc.get_Ventas(Mes,Ano)
        Gastos = self.dbc.get_Gastos(Mes,Ano)
        Num = self.dbc.get_CountVentas(Mes,Ano)


        if Gastos is None: Gastos = 0
        if Ventas is None: Ventas = 0
        if Num is None: Ventas = 0


        informe(Ventas,Gastos,Num,Mes,Ano)

    setMesCombo = Signal(str)
    @Slot(str)
    def setMesCombobox(self,ano):
        a = self.adapter.obtenerMesJSON(ano)
        self.setMesCombo.emit(a)

    setAnoCombo = Signal(str)
    @Slot()
    def setAnoCombobox(self):
        a = self.adapter.obtenerAnoJSON()
        self.setAnoCombo.emit(a)

if __name__ == "__main__":
    #Enviroment variables
    environ["QT_DEVICE_PIXEL_RATIO"] = "0"
    environ["QT_AUTO_SCREEN_SCALE_FACTOR"] = "1"
    environ["QT_SCREEN_SCALE_FACTORS"] = "1"
    environ["QT_SCALE_FACTOR"] = "1"
    #environ["QT_FONT_DPI"] = "96"
    
    QGuiApplication.setAttribute(Qt.AA_EnableHighDpiScaling)
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    app.setWindowIcon(QIcon("img/images/favicon.png"))

    #context
    bdd = BDD()
    adapter = Adapter()
    main = MainWindow(bdd,adapter,engine)

    #QML file
    engine.rootContext().setContextProperty("backend",main)
    engine.load(path.join(path.dirname(__file__), "qml/login.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
