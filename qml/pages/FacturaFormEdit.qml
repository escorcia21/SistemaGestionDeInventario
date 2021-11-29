import QtQuick 2.15
import "../controls"
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

Item {
    property string title: "CREAR FACTURA"
    property alias ftotal: total.text
    property alias fnumeroFact: numeroFact.value

    height: 720
    width: 1300
    Rectangle {
        height: 720
        width: 1000
        id: rectangle
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: text1
            x: 0
            width: parent.width
            height: 29
            text: "FACTURA"
            anchors.top: parent.top
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            anchors.topMargin: 20
        }

        Rectangle {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: text1.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 10


            Column {
                id: rectangle10
                height: 69
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Text {
                    id: text5
                    width: 117
                    text: qsTr("N° de facturas")
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                }

                FormField {
                    id:numeroFact
                    placeholderText: "..."
                    width: 150
                    enabled: false
                }
            }

            TableSupp {
                id: homeTab
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangle10.bottom
                anchors.bottom: row2.top
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                headers: ["ID","Producto","Cantidad","Precio","Total"]
                tablevisible: false

            }

            Row {
                id: row2
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 10
                spacing: 90

                Row {
                    spacing: 5
                    Text {
                        id: text17
                        text: qsTr("SubTotal ($):")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                    }
                    Text {
                        id: subto
                        width: 200
                        text: qsTr("0")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true
                    }
                }

                Row {
                    spacing: 5
                    Text {
                        id: text15
                        text: qsTr("IVA ($):")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                    }

                    Text {
                        id: iva
                        width: 198
                        text: qsTr("0")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true
                    }
                }

                Row {
                    spacing: 5
                    Text {
                        id: text19
                        text: qsTr("Total$:")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true

                    }
                    Text {
                        id: total
                        width: 200
                        text: qsTr("0")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true

                    }
                }

            }

        }


    }
    Connections {
        target: backend
        function onPageFacturaLista(object){
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`FacturaLista${index}`];
                homeTab.add.append({"ID":a.ID,"Producto":a.Producto,"Cantidad":a.Cantidad,"Precio":a.Precio,"Total":a.Total});
            }
        }
        function onPageFacturaTotal(object){
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`FacturaTotal${index}`];
                subto.text = (a.Total);
                var b = a.Total;
                iva.text = (b*0.19);
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
