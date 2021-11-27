import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../pages"


PopupBase {
      id: popup


      QtObject{
          id: contador
          function totales(vaina){
              var suma = 0
              for(var i=0;i < vaina.count;i++){
                  var temp = vaina.get(i).Total
                  suma += temp
              }
              var iva = suma * 0.19
              edit.fsubto = suma
              edit.fiva = iva
              edit.ftotal = suma + iva
          }


          function listModelToString(Temp){
              var datamodel = []
              for (var i = 0; i < Temp.count; ++i)
                datamodel.push(Temp.get(i))

              var keysList = JSON.stringify(datamodel)
              return keysList  //output [{"aKey":"aKey0","aKey":"aKey0"},{"aKey":"aKey1","aKey":"aKey1"}]
            }
      }

      height: 700
      width: 1200
      contentItem: Rectangle {
          id: rectangle
          anchors.fill: parent
          FacturaForm {
              id: edit
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: parent.top
              anchors.bottom: buttons.top
              anchors.rightMargin: 0
              anchors.bottomMargin: 0
          }

          Rectangle {
              id: buttons
              height: 60
              color: "#00000000"
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.bottom: parent.bottom
              anchors.leftMargin: 0
              anchors.rightMargin: 0
              anchors.bottomMargin: 0

              CardBtns {
                  width: 100
                  height: 37
                  text: "Cerrar"
                  btnColorClicked: "#cd3737"
                  btnColorMouseOver: "#ec3c3c"
                  btnColorDefault: "#f05454"
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenterOffset: -66
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.verticalCenterOffset: 1
                  font.pointSize: 10
                  font.bold: true
                  MouseArea {
                      anchors.fill: parent
                      cursorShape: Qt.PointingHandCursor

                      onClicked: {
                          popup.close()
                      }
                  }
              }

              CardBtns {
                  width: 100
                  height: 37
                  text: "Añadir"
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.verticalCenterOffset: 1
                  anchors.horizontalCenterOffset: 64
                  font.pointSize: 10
                  anchors.horizontalCenter: parent.horizontalCenter
                  font.bold: true
                  MouseArea {
                      anchors.fill: parent
                      cursorShape: Qt.PointingHandCursor

                      onClicked: {
                          var infoFactura = (edit.ffecha != "//" && edit.fvendedorID !== undefined && edit.fclienteID !== undefined && edit.ftotal != 0)
                          if(infoFactura){
                              backend.agregarFactura(edit.fvendedorID,edit.fclienteID,edit.ffecha,edit.ftotal);
                              backend.agregarFacturaDetalle(edit.fnumeroFact,contador.listModelToString(edit.tablaFactures))
                              popup.close()

                          }
                      }
                  }
              }

              CardBtns {
                  width: 150
                  height: 37
                  text: "Agregar Producto"
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenterOffset: 500
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.verticalCenterOffset: -460
                  font.pointSize: 10
                  font.bold: true
                  MouseArea {
                      anchors.fill: parent
                      cursorShape: Qt.PointingHandCursor

                      onClicked: {
                          if(edit.indice !=0 && edit.fcantidad != ""){
                              var s = edit.fproductoPrecio
                              var a = edit.fcantidad
                              s = parseInt(s)
                              a = parseInt(a)
                              var total = s * a
                              edit.tablaFactures.append({"ID":edit.fproductoId,"Producto":edit.fproductoNombre,"Cantidad":edit.fcantidad,"Precio":edit.fproductoPrecio,"Total":total});
                              contador.totales(edit.tablaFactures)
                          }
                      }
                  }
              }
          }
      }
      function actualziarValores(){
          for (var index = 0; index < edit.tablaFactures.length(); index++){
              var calculo = 0
          }
      }
      Connections {
        target: backend
      }
 }

/*##^##
Designer {
    D{i:0;formeditorZoom:4}D{i:1}D{i:11}
}
##^##*/
