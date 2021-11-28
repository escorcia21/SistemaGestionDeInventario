import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../pages"


PopupBase {
      id: popup
      property int identification: -1

      property string tipo: ""
      property string name: ""
      property string direccion: ""
      property string phone: ""
      property string idCedula: ""
      property string idNit: ""
      property string idNitNumero: ""

      height: 600
      width: 960

      contentItem: Rectangle {
          id: rectangle
          anchors.fill: parent
          ClientForm {
              id: edit
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: parent.top
              anchors.bottom: buttons.top
              anchors.rightMargin: 0
              anchors.bottomMargin: 0
              title: "EDITAR CLIENTE"
              ftipo: tipo
              fname: name
              fdireccion: direccion
              fphone: phone
              fcedula: idCedula
              fnit: idNit
              fnitnumero: idNitNumero
              disableForms:true
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
                  text: "Editar"
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
                          if(edit.fname != "" && edit.fphone != "" && edit.fdireccion != "" && edit.ftipo == 0 && edit.fnit != "" && edit.fnitnumero != ""){
                              //console.log(edit.fnit+"-"+edit.fnitnumero);
                              backend.actualizarCliente(edit.fname,edit.fphone,edit.fdireccion,edit.ftipo,edit.fnit+"-"+edit.fnitnumero);
                          }
                          else if(edit.fname != "" && edit.fphone != "" && edit.fdireccion != "" && edit.ftipo == 1 && edit.fcedula != ""){
                              backend.actualizarCliente(edit.fname,edit.fphone,edit.fdireccion,edit.ftipo,edit.fcedula);
                          }
                          popup.close()
                      }
                  }
              }
          }
      }
      Connections {
        target: backend
      }
 }
