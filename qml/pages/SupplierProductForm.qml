import QtQuick 2.15
import QtQuick.Controls 1.4

import "../controls"

Item {
    property alias producID: fproduct.comboValue
    property alias supplierID: fsupplier.comboValue
    property alias amounnt: famount.value
    property alias price: fprice.value
    property alias fdate: myDate.value

    Rectangle {
        id: rectangle
        anchors.fill: parent
        Text {
            text: qsTr("AÑADIR COMPRA")
            anchors.top: parent.top
            font.pixelSize: 20
            anchors.topMargin: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            id: column
            width: parent.width/2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            spacing: 20
            anchors.leftMargin: 0

            Column {
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: qsTr("Producto")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                FungusComboBox {
                    id:fproduct

                }

            }

            Column {
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: qsTr("Proveedor")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                FungusComboBox {
                    id:fsupplier

                }

            }

        }

        Column {
            id: column1
            anchors.left: column.right
            anchors.right: parent.right
            height: column.height
            spacing: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Text {
                    text: qsTr("Cantidad")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                FormField{
                    id:famount
                    validator: RegExpValidator {regExp: /^\d{1,5}$/}
                }
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Text {
                    text: qsTr("Precio unitario")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                FormField {
                    id:fprice
                    validator: RegExpValidator {regExp: /^\d{1,10}$/}
                }
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Text {
                    text: qsTr("Fecha (DD/MM/YYYY)")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id: myDate
                    //text : "31/01/2017"
                    validator: RegExpValidator {regExp: /^(((([0\s][1-9\s]|[1\s][0-9\s]|[2\s][0-8\s])[\/]([0\s][1-9\s]|[1\s][012\s]))|((29|30|31)[\/]([0\s][13578\s]|[1\s][02\s]))|((29|30)[\/]([0\s][4,6,9]|11)))[\/]([19\s[2-9\s][0-9\s])\d\d|(^29[\/]02[\/]([19\s]|[2-9\s][0-9\s])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)))$/}
                    inputMask: "99/99/9999"

                }
            }
        }
    }

    Connections {
        target: backend
        function onSetSProdCombo(object){
            //console.log("aa");
            var txt = JSON.parse(object);
             for (var index = 0; index < Object.keys(txt).length; index++) {
                 var a = txt[`Supp${index}`];
                 fsupplier.listm.append({'ID': a.ID, 'Nombre':  + a.ID + " - " + a.Nombre });
             }
        }

        function onSetProdCombo(object){
            //console.log("aa");
            var txt = JSON.parse(object);
             for (var index = 0; index < Object.keys(txt).length; index++) {
                 var a = txt[`Product${index}`];
                 fproduct.listm.append({'ID': a.idd, 'Nombre':  + a.idd + " - " + a.article });
             }
        }

    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.66;height:480;width:640}
}
##^##*/
