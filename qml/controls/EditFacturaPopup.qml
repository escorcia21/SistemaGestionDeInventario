import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../pages"


PopupBase {
      id: popup

      property string numeroFactura: ""
      property int total: 0

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
              return keysList
            }
      }

      height: 700
      width: 1200
      contentItem: Rectangle {
          id: rectangle
          anchors.fill: parent
          FacturaFormEdit {
              id: edit
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: parent.top
              anchors.bottom: buttons.top
              anchors.rightMargin: 0
              anchors.bottomMargin: 0

              fnumeroFact: numeroFactura
              ftotal: total

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
                  anchors.horizontalCenterOffset: 0
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


