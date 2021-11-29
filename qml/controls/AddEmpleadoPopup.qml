import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../pages"


PopupBase {
      id: popup
      height: 600
      width: 960
      contentItem: Rectangle {
          id: rectangle
          anchors.fill: parent
          EmpleadoForm {
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
                  text: "Close"
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
                  text: "Save"
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.verticalCenterOffset: 1
                  anchors.horizontalCenterOffset: 64
                  font.pointSize: 10
                  anchors.horizontalCenter: parent.horizontalCenter
                  font.bold: true
                  enabled: edit.factivo == -1 ? false:true
                  MouseArea {
                      anchors.fill: parent
                      cursorShape: Qt.PointingHandCursor

                      onClicked: {
                          if(edit.fcedula != ""
                                  && edit.ftelefono != ""
                                  && edit.fcargo != ""

                                  && edit.fnombre != ""
                                  && edit.fdireccion != ""
                                  && edit.fsueldo != ""
                                  && edit.fingreso != ""

                                  && edit.fcorreo != ""
                                  && edit.fpassword != ""
                                  && edit.fedad != ""
                                  && edit.fsalida != ""){
                              
                              backend.agregarEmpleado(edit.fcedula,
                                                      edit.fnombre,
                                                      edit.fedad,
                                                      edit.ftelefono,

                                                      edit.fdireccion,
                                                      edit.fcorreo,
                                                      edit.fingreso,
                                                      edit.fsalida,

                                                      edit.fsueldo,
                                                      edit.fcargo,
                                                      edit.fpassword,
                                                      edit.factivo);
                          }

                          popup.close();
                      }
                  }
              }
          }
      }
      Connections {
        target: backend
      }
 }
