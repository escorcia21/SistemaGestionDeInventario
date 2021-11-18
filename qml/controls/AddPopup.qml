import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import "../pages"


PopupBase {
    id:popup
    width: 640
    height: 480
    TabBar {
        id:tab
        width: parent.width

        TabButton {
            text: qsTr("PRODUCT")
            font.bold: true
            font.pointSize: 10
        }
        TabButton {
            text: qsTr("TYPES")
            font.bold: true
            font.pointSize: 10

        }
    }

    StackLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tab.bottom
        anchors.bottom: parent.bottom
        currentIndex: tab.currentIndex
        ProductForm {
            id:edit
            //Layout.fillWidth: true
            //Layout.fillHeight: true

            Rectangle {
                id: buttons
                height: 100
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
                                //console.log(edit.name,edit.type,edit.price);
                                backend.agregarProducto(edit.name,edit.type,edit.price);
                                popup.close();
                            }
                        }
                    }
                }
            }
        }

        TableSupp {
            id:listTypes
            headers: ["ID","Nombre","Unidad"]
            //Layout.fillWidth: true
            //Layout.fillHeight: true
            //columss: 3

            RoundBtnEdit {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                btnIconSource: "../../img/svg_img/edit.svg"
                anchors.leftMargin: 20
                anchors.bottomMargin: 30
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (listTypes.selectedRow > -1){
                            var popup = Qt.createComponent("EditTypePopup.qml");
                            var popup2 = popup.createObject(rectangleProducts,{name:listTypes.add.get(listTypes.selectedRow).Nombre, identification:listTypes.add.get(listTypes.selectedRow).ID});
                            popup2.open();
                        }
                    }
                }

            }

            RoundBtn {
                id:secondTabRound
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                anchors.rightMargin: 30
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        var popup = Qt.createComponent("AddTypePopup.qml");
                        var popup2 = popup.createObject(rectangleProducts);
                        popup2.open();
                    }
                }
            }
        }
    }

    Connections {
        target: backend
        function onSetAddTypes(object){
            //console.log("aa");
            listTypes.add.clear();
            var txt = JSON.parse(object);
             for (var index = 0; index < Object.keys(txt).length; index++) {
                 var a = txt[`Type${index}`];
                 listTypes.add.append({'ID': a.ID, 'Nombre': a.Nombre,'Unidad': a.Unidad});
             }
        }
    }

}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
