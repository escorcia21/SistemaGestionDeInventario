import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"

Item {
    id: productsWindow

    Rectangle {
        id: rectangleProducts
        color: "#00000000"
        anchors.fill: parent

        SearchButton {
            id: btns
            width: 200
            height: 35
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.rightMargin: 2
            placeholder: " Buscar Producto"
            onTextChanged: {
                productList.applyFilter(text,1)
            }
        }

        Rectangle {
            id: rectangle1
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: btns.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0

            ProductsList {
                id: productList
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                clip: true

                RoundBtn {
                    id: roundButton
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.rightMargin: 30

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                           var popup = Qt.createComponent("../controls/AddPopup.qml");
                           var popup2 = popup.createObject(rectangleProducts);
                           popup2.open();
                           backend.setListTypes();
                           backend.setAddPopUPTypes();
                        }
                    }

                }
            }
        }

        ComboBox {
            id: comboBox
            width: 240
            height: 35
            anchors.left: parent.left
            anchors.top: parent.top
            font.pointSize: 12
            anchors.topMargin: 0
            anchors.leftMargin: 0

            background: Rectangle{
               color: "#e8e8e8"
               border.width: 0
            }

            model: ListModel {
                id:lista
                ListElement{Nombre: ""}
            }

            delegate: ItemDelegate {
                      id:itemDlgt
                      width: comboBox.width


                      contentItem: Text {
                          id:textItem
                          text: Nombre
                          color: "#000"
                          font: comboBox.font
                          elide: Text.ElideRight
                          verticalAlignment: Text.AlignVCenter
                          horizontalAlignment: Text.AlignLeft
                          leftPadding: 0
                      }

                      background: Rectangle {
                        id: rec
                        color:itemDlgt.hovered?"#b5b5b5":"#e8e8e8";
                        anchors.left: itemDlgt.left
                        anchors.leftMargin: -1
                        anchors.right: itemDlgt.right
                        anchors.rightMargin: -1
                        anchors.top: itemDlgt.top
                        anchors.topMargin: -1
                        anchors.bottom: itemDlgt.bottom
                        anchors.bottomMargin: -1
                        width:itemDlgt.width
                      }

                    }


            popup: Popup {
                     id:comboPopup
                     y: comboBox.height
                     width: comboBox.width
                     height:contentItem.implicitHeigh
                     padding: 1


                     contentItem: ListView {
                         id:listView
                         clip: true
                         implicitHeight: 200
                         model: comboBox.popup.visible ? comboBox.delegateModel : null

                         ScrollBar.vertical: ScrollBar {
                             id: scrollBar
                             width: 10
                             anchors.top: listView.top
                             anchors.right: listView.right
                             anchors.bottom: listView.bottom
                             anchors.rightMargin: 0
                             contentItem: Rectangle {
                                 id:contentItem_rect2
                                 color: "#30475e"
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 width: 10 // This will be overridden by the width of the scrollbar
                                 height: 10 // This will be overridden based on the size of the scrollbar
                             }
                         }
                     }

                     background: Rectangle {
                         color: "#e8e8e8"
                         border.width: 0

                     }
                }
            onActivated:  productList.applyFilter(lista.get(index).Nombre,2)

            }

    }

    Connections {
        target: backend
        function onTypes(object){
            lista.clear();
            lista.append({Nombre: "ALL"});
            let txt = JSON.parse(object);
             for (let index = 0; index < Object.keys(txt).length; index++) {
                 let a = txt[`Type${index}`];
                 lista.append({'ID': a.ID, 'Nombre': a.Nombre,'Unidad': a.Unidad});
             }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/
