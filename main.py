#!/usr/bin/python
# This Python file uses the following encoding: utf-8
import sys
from os import environ,path
import cv2
from adapter import Adapter
from DBConnection import BDD
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal
from models import TableSupplier


class MainWindow(QObject):
    def __init__(self,bdd:BDD,adapter:Adapter):
        self.cont = 0
        QObject.__init__(self)
        self.dbc = bdd
        self.adapter = adapter

    #init the bd
    initialize =Signal(str)
    def setBD(self):
        #print("hola")
        a = self.adapter.obtenerProductosJSON()
        self.initialize.emit(a)

    types =Signal(str)
    def setTypes(self):
        a = self.adapter.obtenerTiposJSON()
        self.types.emit(a)

    # target backend
    @Slot()
    def close(self):
        self.dbc.close()

    @Slot(str,int,str)
    def agregarProducto(self,Nombre,Tipo,Precio):
        self.dbc.add_Products(Nombre,Tipo,int(Precio))
        self.setBD()


    listTypes = Signal(str)
    @Slot()
    def setListTypes(self):
        a = self.adapter.obtenerTiposJSON()
        self.listTypes.emit(a)

    listSupp = Signal(str)
    @Slot()
    def setSupp(self):
        a = self.adapter.obtenerProveedoresJSON()
        self.listSupp.emit(a)

    change = Signal(str,int)
    @Slot(str,int)
    def onChangeImage(self,imgUrl,id):
        name = imgUrl.replace("file:///","")
        src = cv2.imread(name, cv2.IMREAD_UNCHANGED)
        scale_percent = 50
        name = name.split('/')
        name = name[len(name) - 1]

        #calculate the 50 percent of original dimensions
        width = int(src.shape[1] * (scale_percent + 20 )/ 100)
        height = int(src.shape[0] * scale_percent / 100)

        # dsize
        dsize = (width, height)

        # resize image
        output = cv2.resize(src, dsize)
        proc = 'file:///'
        path = f'C:\\Users\\pedro\\Documents\\pharmacy_py\\backend\\sources\\{name}'
        proc += path
        cv2.imwrite(path,output)
        self.change.emit(proc,id)

    add = Signal(int,int)
    @Slot(int,int)
    def addToCart(self,item,quantity):
        #print(item,quantity)
        self.add.emit(item,quantity)

    recived = Signal(QObject,int)
    @Slot(QObject,int)
    def send(self,item,quantity):
        self.recived.emit(item,quantity)

    setTotal = Signal(int,int)
    @Slot(int,int)
    def changeTotal(self,csvalue,pk):
        #print(csvalue,pk)
        self.setTotal.emit(csvalue,pk)

    cartListDelete = Signal(int)
    @Slot(int)
    def deleteFrom(self,item_id):
        self.cartListDelete.emit(item_id)

    clearList = Signal()
    @Slot()
    def deleteOrder(self):
        self.clearList.emit()

if __name__ == "__main__":
    #Enviroment variables
    environ["QT_DEVICE_PIXEL_RATIO"] = "0"
    environ["QT_AUTO_SCREEN_SCALE_FACTOR"] = "1"
    environ["QT_SCREEN_SCALE_FACTORS"] = "1"
    environ["QT_SCALE_FACTOR"] = "1"
    environ["QT_FONT_DPI"] = "96"
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    #context
    bdd = BDD()
    adapter = Adapter()
    main = MainWindow(bdd,adapter)

    #QML file
    engine.rootContext().setContextProperty("backend",main)
    engine.load(path.join(path.dirname(__file__), "qml/main.qml"))
    main.setBD()
    main.setTypes()
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
