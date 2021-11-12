import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../pages"


Popup {
      id: popup
      //parent: Overlay.overlay
      anchors.centerIn: Overlay.overlay
      width: 640
      height: 480
      modal: true
      focus: true
      closePolicy: Popup.NoAutoClose

      contentItem: Rectangle {
          id: rectangle
          anchors.fill: parent
          ProductForm {
              id: edit
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: parent.top
              anchors.rightMargin: 0
              anchors.bottomMargin: 100
              formTitle: "ADD PRODUCT"
          }

          Rectangle {
              id: buttons
              height: 100
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
                  MouseArea {
                      anchors.fill: parent
                      cursorShape: Qt.PointingHandCursor

                      onClicked: {
                          if(edit.name != "" && edit.type>0 && edit.price > 1){
                            //console.log(typeof(edit.name),typeof(edit.supplier),typeof(edit.type),typeof(edit.price));
                              backend.agregarProducto(edit.name,edit.type,edit.price);
                          }
                      }
                  }
              }
          }
          layer.enabled: enabled
          layer.effect: DropShadow {
              color: "#5c242826"
              horizontalOffset: 1
              verticalOffset: 1
              radius: 4
              samples: 9
          }

      }
      Overlay.modal: Rectangle {
          color: "#00000000"
          border.width: 0
      }

      Connections {
        target: backend
      }
 }


/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
